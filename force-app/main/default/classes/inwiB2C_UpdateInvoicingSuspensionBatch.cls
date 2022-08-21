public class inwiB2C_UpdateInvoicingSuspensionBatch implements Database.Batchable<sObject>, Database.AllowsCallouts{

    Integer nbrM;
    public inwiB2C_UpdateInvoicingSuspensionBatch(Integer nbrMonth){
        this.nbrM= nbrMonth;
    }
    
    public Database.querylocator start(Database.BatchableContext BC){
		
        return Database.getQueryLocator([
          SELECT Id,inwiB2C_SubscriptionId__r.inwiB2C_Statut__c,inwiB2C_SubscriptionId__c,inwiB2C_TypeModification__c,createddate
          From INWIB2C_HIST_ACTION_LINE__c 
          Where inwiB2C_TypeModification__c = 'InwiB2C_suspensionDeFacturation'
          And inwiB2C_SubscriptionId__r.inwiB2C_Statut__c = 'InwiB2C_SuspendueFacturation'
        ]);
        
    }
    
     public void execute(Database.BatchableContext BC, List<INWIB2C_HIST_ACTION_LINE__c> scope){
         system.debug('batch size'+scope.size());
         Date myDate = system.today(); 
         List<InwiB2C_Insert_Histo_Action__e> Histo_Action_event = new List<InwiB2C_Insert_Histo_Action__e>();
        
           for (INWIB2C_HIST_ACTION_LINE__c  actionSub: scope){
                     if(actionSub.createddate.Date().addMonths(nbrM) == myDate) {
                 InwiB2C_Insert_Histo_Action__e NewActionEvent = new InwiB2C_Insert_Histo_Action__e();
                 NewActionEvent.inwiB2C_SubscriptionId__c = actionSub.inwiB2C_SubscriptionId__c;               
            
                 Histo_Action_event.Add(NewActionEvent);
                     }  
               
           }
          if(!Test.isRunningTest()) {
            List<Database.SaveResult> results = EventBus.publish(Histo_Action_event);
          }   
    }
    
    public void finish(Database.BatchableContext BC){
       
    }}