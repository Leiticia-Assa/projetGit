global class inwiB2C_DeferredMigrationVIP  extends vlocity_cmt.XOMAsyncSystemInterface  {
/**
 * This class extends the default XOM Asynchronous System Interface class used by Order Management to
 * make an asynchronous Callout using an Integration Procedure (rather than a direct REST API Call).
 *
 * The general flow is as follows:
 * 
 *  -----------    ------------------    ------------    -----------------------
 * | Orch Item |  | System Interface |  | this Class |  | Integration Procedure |
 *  -----------    ------------------    ------------    -----------------------
 *       |                 |                   |                    |
 *       |     execute     |                   |                    |
 *       |---------------->|    startBatch()   |                    |
 *       |                 |------------------>|                    |
 *       |                 |                   |                    |
 *       |                 |   executeItem()   |                    |
 *       |                 |------------------>|       call         |
 *       |                 |                   |------------------->|
 *       |                 |                   |                    |<----------> Do integration stuff
 *       |                 |                   |     response/ack   |
 *       |                 | processResponse() |<-------------------|
 *       |     updates     |<------------------|                    |
 *       |<----------------|                   |                    |
 *       |     (note 1)    |    endBatch()     |                    |
 *       |                 |------------------>|                    |
 *       |                 |                   |                    |
 *       |                 |                   |                    |
 *       \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 *                          Some time passes
 *       ////////////////////////////////////////////////////////////
 *       |                 |                   |                    |
 *       |                 |   processResponse |                    |
 *       |                 |   Deferred()      |<------------------------------- XOMAsyncResponseRESTService.processCallback() <---- REST Call
 *       |    complete     |<------------------|                    |                           (note 2)
 *       |<----------------|                   |                    |
 * 
 * 
 * note 1: By default, this class doesn't do much in terms of updates to the Orchestration Item other than capturing the IP response
 *         if there is one.  The Orchestration Item is left in an 'Active' state.
 * 
 * note 2: The default callback handler sets the Orchestration Item as 'Completed'.  If you want different behavior such as
 *         handling interim responses, you will need to create your own callback handler and modify the callback URI sent in the request
 *         accordingly.
 * 
 *
 * @author Joe McMaster (jmcmaster@vlocity.com)
 *
 * @version 1.1
 *
 * History
 * =======
 * 1.0 - May 24, 2019 - Initial Version
 * 1.1 - May 29, 2019 - Enhanced to support Fulfilment Request Lines
 */

   /**
    * Default Constructor
    */
   global inwiB2C_DeferredMigrationVIP() {
    
       super();
   }

   /**
    * This method is a part of the ISystemInterface. It is invoked at the start of the batch
    * 
    * @param url   base URL the batch is started for
    * @param path  path this batch is started for
    */
   global override void startBatch(String url, String path) {}

   /**
    * Executes a Callout OrchestrationItem
    * 
    * @param url   base URL to send the request to (in this class it is ignored)
    * @param path  path to send the request to (in this class it is interpreted as the Integration Procedure API Key)
    * @param item  OrchestrationItem that needs to be executed
    */
   global override void executeItem(String url, String path, vlocity_cmt__OrchestrationItem__c item) {

       System.debug('JOE - Orchestration Item -> ' + JSON.serialize(item.getPopulatedFieldsAsMap()));
       
       // Get the Order SObject - the technique will differ depending on if this orchestration item is related to an Order Item or a Fulfillment Request Line
       Id orderId = null;
       if (item.vlocity_cmt__OrderItemId__c != null) orderId = item.vlocity_cmt__OrderItemId__r.OrderId;
       else {
           
           vlocity_cmt__OrchestrationItem__c orchItem = [SELECT vlocity_cmt__OrchestrationPlanId__r.vlocity_cmt__OrderId__r.Id FROM vlocity_cmt__OrchestrationItem__c WHERE Id = :item.Id];
           orderId = orchItem.vlocity_cmt__OrchestrationPlanId__r.vlocity_cmt__OrderId__r.Id;
       }
       vlocity_cmt.XOMOrderDomainObject orderObj = ((vlocity_cmt.XOMOrderService)vlocity_cmt.XOMObjectFactory.getService(Order.SObjectType)).getObject(orderId, true);
      //LBI
       boolean isIN = false;
      Integer daysBefore = 2;
      inwiB2C_OrderSubscription__c OrderSub = [select id,inwiB2C_Order__c, inwiB2C_Subscription__r.vlocity_cmt__BillingAccountId__r.InwiB2C_Cycle_de_facturation__c  from  inwiB2C_OrderSubscription__c where inwiB2C_Order__c =: orderId LIMIT 1];
      Integer cycledeFacturation =Integer.ValueOf(OrderSub.inwiB2C_Subscription__r.vlocity_cmt__BillingAccountId__r.InwiB2C_Cycle_de_facturation__c) ;
     // Date todayDate = system.today(); 
       Date todayDate = Date.newInstance(2022,03,18);
      for (integer i = 0 ; i<=daysBefore; i++){
         Date migrationDate = todayDate.addDays(i);
          
         Integer Day = migrationDate.Day();
 
          if(Day == cycledeFacturation ){
              isIN = true;
          }
      }
       if(isIN == true){
          
       //Update step status to Completed       
         item.vlocity_cmt__State__c = 'Completed';
         update item;
          
       }else{
       Map<String, Object> ipInput   = (Map<String, Object>)JSON.deserializeUntyped(super.generatePayload(item, orderObj));
       Map<String, Object> ipOptions = new Map<String, Object>();
       
       // Add any extra information to the payload that might be useful and otherwise not available via the DataRaptors configured in the Callout
       ipInput.put('orchestration_item_id',   item.Id);
       ipInput.put('orchestration_item_name', item.Name);
       //ipInput.put('responseUri', 'your override value');   // Override the default callback URI if you have written your own callback handler
       
       // Call the Integration Procedure
       System.debug('JOE - Attempting to call Integration Procedure "' + path + '"');
       System.debug('JOE - IP Input -> ' + JSON.serialize(ipInput));
       Map<String, Object> ipOutput = (Map <String, Object>) vlocity_cmt.IntegrationProcedureService.runIntegrationService(path, ipInput, ipOptions);

       // process any response
       processResponse(item, ipInput, ipOutput);  
       }
   }
       
   /**
    * This method is called from executeItem to handle the response from the Integration Procedure.
    * By default it does nothing (but some logging), but it could be customized to do something more.
    *
    * @param item      The Orchestration Item
    * @param ipInput   The request sent to the Integration Procedure
    * @param ipOutput  The response from the Integration Procedure
    */
   global virtual void processResponse(vlocity_cmt__OrchestrationItem__c item, Map<String, Object> ipInput, Map<String, Object> ipOutput) {

       // Do nothing by default
       System.debug('JOE - IP Output -> ' + JSON.serialize(ipOutput));
       
       // For debugging, store the Request in the Orchestration Item SObject
       item.vlocity_cmt__Request__c  = 'test';
       item.vlocity_cmt__Response__c  = 'test';
       update item;
   }

   /**
    * This method is called at the end of the batch
    * 
    * @param url   base URL for the batch
    * @param path  path for the batch
    */
   global override void endBatch(String url, String path) {}
       
   /**
    * This method is called by the Callback service when a callback is received from an external system.
    * 
    * NOTE! The default XOMAsyncResponseRESTService class will NOT call this method.  Instead it will call the super class 
    *       method XOMAsyncSystemInterface.processResponseDeferred(), so do not expect anything you put into this method to 
    *       be executed unless you create your own callback handler which explicitly creates and instance of this class and
    *       calls this method!
    * 
    * @param item      OrchestrationItem that needs to be executed
    * @param url       base URL (XOMAsyncResponseRESTService sets this to null)
    * @param path      path to send the request to (XOMAsyncResponseRESTService sets this to null)
    * @param orderObj  The order Object related to this Orchestration Item
    * @param res       The Response object to process (XOMAsyncResponseRESTService only sets the body, no headers, etc.)
    * 
    */ 
   global virtual override void processResponseDeferred(vlocity_cmt__OrchestrationItem__c item, String url, String path, vlocity_cmt.XOMOrderDomainObject orderObj, System.HttpResponse res) {

       // Customize this as needed if using your own callback handler
       super.processResponseDeferred(item, url, path, orderObj, res);
   }    

  }