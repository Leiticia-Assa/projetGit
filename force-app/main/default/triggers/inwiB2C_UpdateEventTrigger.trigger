trigger inwiB2C_UpdateEventTrigger on inwiB2C_SubscriptionUpdateEvent__e (after insert) {

  for (inwiB2C_SubscriptionUpdateEvent__e event : Trigger.New) {
         String IP_UpdatesSubscription = 'Inwi_InwiB2C_UpdateSubscriptionLegacy';
         system.debug('EVENT SUBSCRIPTION UPDATE CREATED!');
         
         //Build the CSOperationInfo
         Map<String, Object> CSOperationInfo = new Map<String, Object>();
         CSOperationInfo.put('channel', 'SFB2C');
         CSOperationInfo.put('user', 'jawad.bentaybi');
         //CSOperationInfo.put('uuid', '73fc2b9c-1ed7-0c2d-b0b0-3a732cb1d712');
         Map<String, Object> ObjCSOperationInfo = new Map<String, Object>();
         ObjCSOperationInfo.put('CSOperationInfo', CSOperationInfo);
         
         //Build the handlingAction object
         Map <String, Object> handlingAction = new Map <String, Object> ();
         handlingAction.put('handlingAction ',event.inwiB2C_Action__c);
         
         //Build the CSOffer
         Map<String, Object> CSOffer = new Map<String, Object>();
         CSOffer.put('subscriptionID', event.inwiB2C_subscriptionID__c);
         CSOffer.put('mainNetworkOffer', event.inwiB2C_mainNetworkOffer__c);
         CSOffer.put('oldMainNetworkOffer', event.inwiB2C_oldMainNetworkOffer__c);
         Map<String, Object> ObjCSOffer = new Map<String, Object>();
         ObjCSOffer.put('CSOffer', CSOffer);
         
         //Build the CSSubscriberIdentityModule
         Map<String, Object> CSSubscriberIdentityModule = new Map<String, Object>();
         CSSubscriberIdentityModule.put('icc1', event.inwiB2C_icc1__c);
         CSSubscriberIdentityModule.put('icc2', event.inwiB2C_icc2__c);
         Map<String, Object> ObjCSSubscriberIdentity = new Map<String, Object>();
         ObjCSSubscriberIdentity.put('CSSubscriberIdentityModule', CSSubscriberIdentityModule);
   
         //Build the CSMobileDirectoryNumber
         Map<String, Object> CSMobileDirectoryNumber= new Map<String, Object>();
         CSMobileDirectoryNumber.put('mdn', event.inwiB2C_mdn__c);
         CSMobileDirectoryNumber.put('oldMdn', event.inwiB2C_oldmdn__c);
         Map<String, Object> ObjCSMobileDirectoryNumber= new Map<String, Object>();
         ObjCSMobileDirectoryNumber.put('CSSubscriberIdentityModule', CSMobileDirectoryNumber);
         
         //Build the List of the OrderResources
         Map<String, Object> ListOrderResources = new Map<String, Object>();
         ListOrderResources.put('CSSubscriberIdentityModule',CSSubscriberIdentityModule);
         ListOrderResources.put('CSMobileDirectoryNumber',CSMobileDirectoryNumber);
         
         //Build the OrderResources object
         Map <String, Object> OrderResources= new Map <String, Object> ();
         OrderResources.put('OrderResources',ListOrderResources);
         
         //Build the CSOrder object
         Map<String, Object> CSOrderObject = new Map<String, Object>();
         CSOrderObject.put('CSOffer',CSOffer);
         CSOrderObject.put('OrderResources',ListOrderResources);
         CSOrderObject.put('handlingAction',event.inwiB2C_Action__c);
   
         Map <String, Object> ipInput = new Map <String, Object> ();
         Map <String, Object> ipOutput = new Map <String, Object> ();
         Map <String, Object> ipOptions = new Map <String, Object> ();
         
         /* Populating input map for an Integration Procedure. Follow whatever structure your VIP expects */
         ipInput.put('CSOperationInfo', CSOperationInfo);
         ipInput.put('CSOrder', CSOrderObject);
          
          String inputSerialized = JSON.serialize(ipInput);
          system.debug('INPUT FOR inputSerialized : '+ inputSerialized);
         InwiB2C_RunUpdateSubscriptionIP.RunUpdateSubscriptionIP(inputSerialized);
      /*
          system.debug('INPUT FOR inputSerialized : '+ inputSerialized);
          Map<String, Object> valuesMap = (Map<String, Object>)JSON.deserializeUntyped(inputSerialized);
          /*valuesMap.put('', inputSerialized );
          system.debug('INPUT FOR UPDATE SUBSCRIPTION : '+ ipInput);

         
         /* Call the IP via runIntegrationService, and save the output to ipOutput 
         ipOutput = (Map <String, Object>) vlocity_cmt.IntegrationProcedureService.runIntegrationService(IP_UpdatesSubscription , ipInput, ipOptions);
         system.debug('OUTPUT FOR UPDATE SUBSCRIPTION : '+ ipOutput);*/
     }
   
}