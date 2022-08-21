public with sharing class InwiB2C_CallRehabilitationVIP {
    
    @future(callout = true)
    public static void CallVIP(List<String> SubIds){
		system.debug('In Class');
        List<INWIB2C_HIST_ACTION_LINE__c> ActionsToInsert = new List<INWIB2C_HIST_ACTION_LINE__c>();
        for (String SubId : SubIds){
            INWIB2C_HIST_ACTION_LINE__c Action = new INWIB2C_HIST_ACTION_LINE__c();

        Map<String, Object> ipInput = new Map<String, Object>();
        ipInput.put('SubscriptionId', SubId); 
        ipInput.put('SubscriptionStatus', 'InwiB2C_Active'); 
        ipInput.put('SubscriptionLegacyStatusatus__c', 'ACTIVE'); 
        Map<String, Object> ipOptions = new Map<String, Object>();
        Map<String, Object> ipOutput = new Map<String, Object>();
        String procedureName = 'InwiB2C_RehabilitationBillingBSCS';
        if(Test.isRunningTest()) {
         //Code en dur du resultat de l'api pour la class de test
          ipOutput.put('code','API-BSCS');
          ipOutput.put('status','1'); 
        }else{
          ipOutput = (Map<String, Object>)vlocity_cmt.IntegrationProcedureService.runIntegrationService(procedureName, ipInput, ipOptions);
       system.debug('ipOutput'+ipOutput);
        }
        String vipError = (String) ipOutput.get('status');
            system.debug('ipOutput'+ipOutput);
            system.debug('vipError'+vipError);
            if(vipError == '1'){
                Action.inwiB2C_SubscriptionId__c = SubId;
                Action.inwiB2C_TypeModification__c ='InwiB2C_rehabilitationDeFacturation';
                Action.inwiB2C_STATUT__c = 'OK';
                Action.inwiB2C_Canal__c = 'inwiB2C_CRC';
                ActionsToInsert.Add(Action);
            }
        }
        Insert ActionsToInsert;
    }
}