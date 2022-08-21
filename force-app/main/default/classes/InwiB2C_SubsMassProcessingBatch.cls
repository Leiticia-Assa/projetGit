public class InwiB2C_SubsMassProcessingBatch implements Database.Batchable<sObject>, Database.AllowsCallouts{
String query;
String email;
Id toUserId;
Id fromUserId;

public Database.querylocator start(Database.BatchableContext BC){
    
    Id thisJobId = bc.getJobId();
    AsyncApexJob[] jobs = [select id from AsyncApexJob where status='Processing' AND ApexClass.Name = '	InwiB2C_SubsMassProcessingBatch' and id != :thisJobId];
    
    if(!jobs.IsEmpty()){
        // RETURN 0 RECORDS SINCE A JOB IS STILL RUNNING
        return Database.getQueryLocator('select ID, INWIB2C_MOTIF__c, INWIB2C_MDN__c,INWIB2C_ACTION__c from INWIB2C_SUBSMASSPROCESSING__c where INWIB2C_STATUT__c = \'ERROR\' limit 1');
    }
    else{
            return Database.getQueryLocator(
            'select ID, INWIB2C_MOTIF__c, INWIB2C_MDN__c,INWIB2C_ACTION__c from INWIB2C_SUBSMASSPROCESSING__c where INWIB2C_STATUT__c = \'NEW\' ORDER BY CreatedDate asc limit 2000'
        );}
    }
 
public void execute(Database.BatchableContext BC, List<INWIB2C_SUBSMASSPROCESSING__c> scope){
    
    List<inwiB2C_SubsMassProcessingEvt__e> ItemsToInsert = new List<inwiB2C_SubsMassProcessingEvt__e>();
    
   for (INWIB2C_SUBSMASSPROCESSING__c SubMassItem : scope) {

		inwiB2C_SubsMassProcessingEvt__e eventToCreate = new inwiB2C_SubsMassProcessingEvt__e();
        eventToCreate.inwiB2C_MDN__c = SubMassItem.INWIB2C_MDN__c;
        eventToCreate.inwiB2C_SubMassId__c = SubMassItem.ID;
        eventToCreate.inwiB2C_Motif__c = SubMassItem.INWIB2C_MOTIF__c;
        eventToCreate.inwiB2C_Action__c = SubMassItem.INWIB2C_ACTION__c;
        eventToCreate.inwiB2C_step__c = 'SusRehabResil';
        //eventToCreate.inwiB2C_Source__c = 'Deactivate';
        ItemsToInsert.add(eventToCreate);
		
   }
    List <Database.SaveResult> sresult = EventBus.publish(ItemsToInsert);
    
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