public class InwiB2C_CancelOrderBatch implements Database.Batchable<sObject>, Database.AllowsCallouts{
    String query;
    String email;
    Id toUserId;
    Id fromUserId;
    private DateTime dt;
    private Decimal TimeOrder;
    private Integer intConvertedValue;
    
    public Database.querylocator start(Database.BatchableContext BC){
        
        TimeOrder = [Select MasterLabel, inwiB2C_TimeOutOrder__c, Label from inwiB2CTimeOrderCancel__mdt limit 1].inwiB2C_TimeOutOrder__c;
        intConvertedValue = TimeOrder.intValue();
        dt = System.Now().addHours(-intConvertedValue);
        system.debug('limit time order is :'+ dt);
        return Database.getQueryLocator(
            //'select Id,LastModifiedDate,inwib2c_Partenaire__r.inwib2c_CodePartenaire__c from order where Id = \'8012500000283xCAAQ\''
            'select Id,LastModifiedDate,inwib2c_Partenaire__r.inwib2c_CodePartenaire__c from order where LastModifiedDate <= :dt and inwiB2C_Statut__c in (\'inwiB2C_EnCours\', \'inwiB2C_Paiement\')'
        );}
    
    public void execute(Database.BatchableContext BC, List<Order> scope){
        
        List<inwiB2C_CancelOrdersBatchEvent__e> ItemsToInsert = new List<inwiB2C_CancelOrdersBatchEvent__e>();
        
        for (Order orderItem : scope) {
            
            inwiB2C_CancelOrdersBatchEvent__e eventToCreate = new inwiB2C_CancelOrdersBatchEvent__e();
            eventToCreate.inwiB2C_OrderId__c = orderItem.Id;
            eventToCreate.inwiB2C_CodePartenaire__c = orderItem.inwib2c_Partenaire__r.inwib2c_CodePartenaire__c;
            ItemsToInsert.add(eventToCreate);
            
        }	
        system.debug('list of orders to cancel :'+ ItemsToInsert);
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