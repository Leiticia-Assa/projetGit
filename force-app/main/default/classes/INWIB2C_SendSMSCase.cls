public class INWIB2C_SendSMSCase {
    @InvocableMethod
    public static void SendSMS(List<Id> caseId) {
        System.debug('process ok');
        List<Case> requetes = [select Id,CaseNumber, vlocity_cmt__SubscriptionId__c from Case where Id in: caseId];
        List<vlocity_cmt__Subscription__c> subscriptions = [Select Inwib2c_Num_ro_de_la_ligne__c From vlocity_cmt__Subscription__c
                                                            Where Id=: requetes[0].vlocity_cmt__SubscriptionId__c];
        List<INWIB2C_SMSSender__mdt> senderList = [Select Sender__c from INWIB2C_SMSSender__mdt];
        String receiver = subscriptions[0].Inwib2c_Num_ro_de_la_ligne__c;
        String sender = senderList[0].Sender__c;
        /*B-0933 ILA 03/03/2021 Begin*/
        /* String message = 'Votre requête numéro '+requetes[0].CaseNumber+' est résolue';*/  
        String message = 'Cher(e) client(e), nous vous confirmons que votre demande N°'+requetes[0].CaseNumber+', a bien été traitée. Nous restons à votre disposition pour toute information complémentaire. Le service client inwi.';
        /*B-0933 ILA 03/03/2021 End*/
        String body='{ "content":"'+message+'", "sender": {"phoneNumber":"'+sender+'"}, "receiver": [{"phoneNumber":"'+receiver+'"}] }';
        system.debug(body);
        SendMsg(body,requetes[0].Id,subscriptions[0].Id);
        
    }
    
    @future(callout=true)
    public static void SendMsg(String body, String caseId, String ligneId)
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
                                                          INWIB2C_CaseId__c = caseId,INWIB2C_SubscriptionId__c=ligneId,
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