public class InwiB2C_ResiliateRequestBatch implements Database.Batchable<sObject>, Database.AllowsCallouts{
    String RequestQuery ;
    Date myDate = system.today();
    String RequestStatus = 'En attente de résiliation';
      
    public Database.querylocator start(Database.BatchableContext BC){

        RequestQuery = 'select Id,InwiB2C_Subscription__c,InwiB2C_Statut_Resil__c,InwiB2C_Date_pr_vue_de_r_siliation__c from InwiB2C_Demande_de_resiliation__c where InwiB2C_Statut_Resil__c = :RequestStatus and InwiB2C_Date_pr_vue_de_r_siliation__c <= :myDate';
        return Database.getQueryLocator(RequestQuery) ;         
    }   

    public void execute(Database.BatchableContext BC, List<InwiB2C_Demande_de_resiliation__c> scope){      
        
        system.debug('batch scope'+scope);  

        List<inwiB2C_ResilRequestEvt__e> ResilRequest_event = new List<inwiB2C_ResilRequestEvt__e>();
       
        for (InwiB2C_Demande_de_resiliation__c  resilrequestitem: scope){
            inwiB2C_ResilRequestEvt__e eventToCreate = new inwiB2C_ResilRequestEvt__e();
            eventToCreate.inwiB2C_requestId__c = resilrequestitem.Id;
            eventToCreate.inwiB2C_subsId__c = resilrequestitem.InwiB2C_Subscription__c;
            ResilRequest_event.add(eventToCreate);	
            system.debug('batch id'+resilrequestitem.InwiB2C_Subscription__c); 
        }

        List <Database.SaveResult> sresult = EventBus.publish(ResilRequest_event);

    }


    public void finish(Database.BatchableContext BC){

        AsyncApexJob a = [Select a.TotalJobItems, a.Status, a.NumberOfErrors,
        a.JobType, a.JobItemsProcessed, a.ExtendedStatus, a.CreatedById,
        a.CompletedDate From AsyncApexJob a WHERE id = :BC.getJobId()];
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
 
        String[] email = new String[]{'khadija.abourkia@atos.net'};
        mail.setToAddresses(email);
        mail.setReplyTo('khadija.abourkia@atos.net');
        mail.setSenderDisplayName('Batch Processing');
        mail.setSubject('Batch Process Completed'+a.Status);
        mail.setPlainTextBody('The Batch Apex job processed '+ a.TotalJobItems+' batches with '+a.NumberOfErrors+' failures '+' Job Itemprocessed are '+a.JobItemsProcessed);
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
  
    }

    
}