public class InwiB2C_SendSMSResilRequest {
    @InvocableMethod
    public static void SendSMSResilRequest(List<Id> requestId) {
        System.debug('process ok');
        List<InwiB2C_Demande_de_resiliation__c> requetes = [select Id, InwiB2C_Subscription__c,inwiB2C_Statut_d_approbation__c,InwiB2C_Date_pr_vue_de_r_siliation__c from InwiB2C_Demande_de_resiliation__c where Id in: requestId];
        List<vlocity_cmt__Subscription__c> subscriptions = [Select Inwib2c_Num_ro_de_la_ligne__c From vlocity_cmt__Subscription__c
                                                            Where Id=: requetes[0].InwiB2C_Subscription__c];
        List<INWIB2C_SMSSender__mdt> senderList = [Select Sender__c from INWIB2C_SMSSender__mdt];
        String receiver = subscriptions[0].Inwib2c_Num_ro_de_la_ligne__c;
        String sender = senderList[0].Sender__c;
        Date resildate = requetes[0].InwiB2C_Date_pr_vue_de_r_siliation__c;
        Date todaydate = Date.today();
        Integer nbjours = todaydate.daysBetween(resildate);
        system.debug(nbjours);
        String message = '';
        String messageapprooved = 'Cher client(e), votre ligne sera résiliée dans '+nbjours+' jours';
        String messagerefused = 'Votre demande de résiliation n’est pas validée, prière de prendre contact avec votre boutique';
        if(requetes[0].inwiB2C_Statut_d_approbation__c == 'Approuvée'){
            message = 'Cher client(e), votre ligne sera résiliée dans '+nbjours+' jours';
        }else if(requetes[0].inwiB2C_Statut_d_approbation__c == 'Refusée'){
            message = messagerefused;
        }
        String body='{ "content":"'+message+'", "sender": {"phoneNumber":"'+sender+'"}, "receiver": [{"phoneNumber":"'+receiver+'"}] }';
        system.debug(body);
        SendMsg(body,requetes[0].Id,subscriptions[0].Id);
        
    }
    
    @future(callout=true)
    public static void SendMsg(String body, String requestId, String ligneId)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:SOA_URL/inwi-api/communicationManagement/v1/communicationMessage');
        request.setMethod('POST');
        request.setHeader('Content-Type','application/json;charset=UTF-8');
        request.setHeader('canal', 'SF');
        request.setHeader('user', UserInfo.getName());
        request.setHeader('uuid', 'SF');
        request.setBody(body);
        INWIB2C_SMSLog__c smslog = new INWIB2C_SMSLog__c (INWIB2C_Date_d_envoie_SMS__c = System.today(),
                                                         InwiB2C_Demande_de_r_siliation_Id__c = requestId,
                                                         INWIB2C_SubscriptionId__c=ligneId,
                                                         INWIB2C_Statut_SMS__c = 'Non envoyé');
        try {
            HttpResponse response = http.send(request);
            if (response.getStatusCode() != 200)
            {
                System.debug('Erreur: ' +response.getStatusCode() + ' ' + response.getStatus());
            } 
            else 
            {
                System.debug(response.getBody());
                smslog.INWIB2C_Statut_SMS__c = 'Envoyé';
            }
        } catch(Exception e){
            System.debug('An exception occurred: ' + e.getMessage());
        }
        insert smslog;
    } 
}