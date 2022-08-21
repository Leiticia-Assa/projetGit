trigger inwiB2C_ResilRequestEvtTrigger on inwiB2C_ResilRequestEvt__e (after insert) {
    system.debug('In trigger');
    String IP_ResilMassProcessing = 'inwib2c_InwiB2C_ResiliateBasedOnClientRequestVIP';
    List<INWIB2C_SMSSender__mdt> senderList = [Select Sender__c from INWIB2C_SMSSender__mdt];
    for (inwiB2C_ResilRequestEvt__e event : Trigger.New) {
        
        if (event.inwiB2C_subsId__c != null ){
          system.debug('event.inwiB2C_subsId__c'+event.inwiB2C_subsId__c);
             Map <String, Object> ipInput = new Map <String, Object> ();
             Map <String, Object> ipOutput = new Map <String, Object> ();
             Map <String, Object> ipOptions = new Map <String, Object> ();
             
            ipInput.put('SubId', event.inwiB2C_subsId__c);
            ipInput.put('requestId', event.inwiB2C_requestId__c);
            system.debug('In ipInput'+ipInput);
            ipOutput = (Map <String, Object>) vlocity_cmt.IntegrationProcedureService.runIntegrationService(IP_ResilMassProcessing, ipInput, ipOptions);
            system.debug('In ipOutput '+ipOutput );
             
            Boolean checkmobile = (Boolean) ipOutput.get('checkmobile');
            
            Decimal receiver = (Decimal) ipOutput.get('NumeroLigne');
            system.debug('In receiver'+receiver);
            system.debug('In typeoffer'+checkmobile );
            if(receiver != null && checkmobile == true ){

                String requestId = event.inwiB2C_requestId__c;
                String ligneId = event.inwiB2C_subsId__c;               
                String sender = senderList[0].Sender__c;                
                //String receiver = (String) ipOutput.get('mdn');
                String message= 'Votre demande de résiliation est effective, votre ligne est dorénavant prépayée';                
                system.debug('In requestId'+requestId);                           
                system.debug('In ligneId'+ligneId);                           
                system.debug('In sender'+sender);                             
                system.debug('In receiver'+receiver);                             
                system.debug('In message'+message);                           
  
                String body= '{ "content":"'+message+'", "sender": {"phoneNumber":"'+sender+'"}, "receiver": [{"phoneNumber":"'+receiver+'"}] }';
                system.debug('In body'+body);   

                InwiB2C_SendSMSResilRequest.SendMsg(body, requestId, ligneId);

            }


                
        }  
        
    }
}