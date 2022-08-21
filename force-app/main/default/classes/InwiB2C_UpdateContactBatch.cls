public class InwiB2C_UpdateContactBatch implements Database.Batchable<sObject>, Database.AllowsCallouts{
    String query;
    String email;
    Id toUserId;
    Id fromUserId;
    String selectedFieldValue = 'Carte d\'Identi%';
   	String selectedFieldValueCIN = 'Carte d\'Identité Nationale';
    String CaseQuery;
    
       public InwiB2C_UpdateContactBatch()
    {
        CaseQuery = 'select Id,InwiB2C_Type_CIN__c from Contact where InwiB2C_Type_CIN__c LIKE :selectedFieldValue and InwiB2C_Type_CIN__c NOT IN (:selectedFieldValueCIN)';
    }
    
    public Database.querylocator start(Database.BatchableContext BC){
		
        return Database.getQueryLocator(CaseQuery);
    }
    
    public void execute(Database.BatchableContext BC, List<Contact> scope){
        
        for (Contact ContactItem : scope) {
            
            ContactItem.InwiB2C_Type_CIN__c = 'Carte d\'Identité nationale';
            
        }	
	Update scope;
        
    }
    public void finish(Database.BatchableContext BC){
        AsyncApexJob a = [Select a.TotalJobItems, a.Status, a.NumberOfErrors,
                          a.JobType, a.JobItemsProcessed, a.ExtendedStatus, a.CreatedById,
                          a.CompletedDate From AsyncApexJob a WHERE id = :BC.getJobId()];
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        String[] email = new String[]{'jawad.bentaybi@atos.net'};
            mail.setToAddresses(email);
        mail.setReplyTo('jawad.bentaybi@atos.net');
        mail.setSenderDisplayName('Batch Processing');
        mail.setSubject('Batch Process Completed'+a.Status);
        mail.setPlainTextBody('The Batch Apex job processed '+ a.TotalJobItems+' batches with '+a.NumberOfErrors+' failures '+' Job Itemprocessed are '+a.JobItemsProcessed);
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    
}