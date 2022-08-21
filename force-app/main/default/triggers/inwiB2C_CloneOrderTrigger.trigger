trigger inwiB2C_CloneOrderTrigger on inwiB2C_CloneOrderEvent__e (after insert) {
    for (inwiB2C_CloneOrderEvent__e event : Trigger.New) {
        Map<String, Object> ipInput = new Map<String, Object> ();
        Map<String, Object> ipOutput = new Map<String, Object> ();
        Map<String, Object> ipOptions = new Map<String, Object> ();
        
        ipInput.put('inwiB2C_CustomerId__c', event.inwiB2C_CustomerId__c);
        ipInput.put('inwiB2C_ContratId__c', event.inwiB2C_ContratId__c);
        ipInput.put('inwiB2C_Icc__c', event.inwiB2C_Icc__c);
        ipInput.put('inwiB2C_imsi__c', event.inwiB2C_imsi__c);
        ipInput.put('inwiB2C_ki__c', event.inwiB2C_ki__c);
        ipInput.put('inwiB2C_Mdn__c', event.inwiB2C_Mdn__c);
        ipInput.put('inwiB2C_ProfileId__c', event.inwiB2C_ProfileId__c);
        ipInput.put('inwiB2C_puk__c', event.inwiB2C_puk__c);
        ipInput.put('inwiB2C_CodeArticle__c', event.inwiB2C_CodeArticle__c);
        ipInput.put('inwiB2C_MdnOCSID__c', event.inwiB2C_MdnOCSID__c);
        ipInput.put('inwiB2C_SimOCSID__c', event.inwiB2C_SimOCSID__c);
        ipInput.put('inwiB2C_IdCreateContractBulk__c', event.inwiB2C_IdCreateContractBulk__c);
        ipInput.put('inwiB2C_dealerAccount__c', event.inwiB2C_dealerAccount__c);
        ipInput.put('inwiB2C_orderId__c', event.inwiB2C_orderId__c);
        ipInput.put('inwiB2C_UpdateAttribute__c', event.inwiB2C_UpdateAttribute__c);
        ipInput.put('inwiB2C_CheckOut__c', event.inwiB2C_CheckOut__c);
        
        String inputSerialized = JSON.serialize(ipInput);
        if(!Test.isRunningTest()) {
            InwiB2C_CreateClonedOrder.CloneOrder(inputSerialized);
        }
    }
}