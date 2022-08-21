trigger inwiB2C_NotifResilRequestEvtTrigger on inwiB2C_NotifResilRequestEvt__e (after insert) {
    system.debug('In trigger');
    List<INWIB2C_SMSSender__mdt> senderList = [Select Sender__c from INWIB2C_SMSSender__mdt];
    for (inwiB2C_NotifResilRequestEvt__e event : Trigger.New) {
        
        if (event.inwiB2C_numLigne__c != null ){       
                String requestId = event.inwiB2C_requestIdNotif__c;
                String ligneId = event.inwiB2C_subsIdNotif__c;               
                String sender = senderList[0].Sender__c;
                String receiver = event.inwiB2C_numLigne__c;            
                String nbrOfDays = event.inwiB2C_nbrofDays__c;
                String message= 'Cher client(e), votre ligne sera résiliée dans '+nbrOfDays+' jours';           
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