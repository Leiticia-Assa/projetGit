public with sharing class InwiB2C_NotifyClientBeforeResiliation implements Database.Batchable<sObject>, Database.AllowsCallouts{
    String NotifRequestQuery;
    Integer nbrDays;
    Date myDate = system.today();
    String RequestStatus = 'En attente de résiliation';
    String NumLigne;

    public Database.querylocator start(Database.BatchableContext BC){

        NotifRequestQuery = 'select Id,InwiB2C_Subscription__c,InwiB2C_Statut_Resil__c,InwiB2C_Date_pr_vue_de_r_siliation__c,x_NumberDaysResilNotif__c,inwiB2C_num_Ligne__c from InwiB2C_Demande_de_resiliation__c where InwiB2C_Statut_Resil__c = :RequestStatus and InwiB2C_Date_pr_vue_de_r_siliation__c > :myDate';
        return Database.getQueryLocator(NotifRequestQuery) ;         
    }   

    public void execute(Database.BatchableContext BC, List<InwiB2C_Demande_de_resiliation__c> scope){        
        system.debug('batch scope'+scope);
        
        List<inwiB2C_NotifResilRequestEvt__e> NotifResilRequest_event = new List<inwiB2C_NotifResilRequestEvt__e>();
       
        for (InwiB2C_Demande_de_resiliation__c  resilrequestitem: scope){         
            this.nbrDays= Integer.valueOf(resilrequestitem.x_NumberDaysResilNotif__c);
            system.debug('batch nbrDays'+nbrDays);
            if(resilrequestitem.InwiB2C_Date_pr_vue_de_r_siliation__c.adddays(-nbrDays) == myDate) {
                system.debug('true');
                inwiB2C_NotifResilRequestEvt__e eventToCreate = new inwiB2C_NotifResilRequestEvt__e();
                eventToCreate.inwiB2C_requestIdNotif__c = resilrequestitem.Id;
                eventToCreate.inwiB2C_subsIdNotif__c = resilrequestitem.InwiB2C_Subscription__c;
                eventToCreate.inwiB2C_numLigne__c = resilrequestitem.inwiB2C_num_Ligne__c;
                eventToCreate.inwiB2C_nbrofDays__c = String.valueOf(nbrDays);
                NotifResilRequest_event.add(eventToCreate);
                system.debug('eventToCreate.inwiB2C_numLigne__c'+eventToCreate.inwiB2C_numLigne__c);
            }
        }

        List <Database.SaveResult> sresult = EventBus.publish(NotifResilRequest_event);

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