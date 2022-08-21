public class InwiB2C_RattrapageActivationOrderBatch  implements Database.Batchable<sobject>{
    public Database.QueryLocator start(Database.BatchableContext bc) {
        Id thisJobId = bc.getJobId();
        AsyncApexJob[] jobs = [select id from AsyncApexJob where status='Processing' AND ApexClass.Name = 'InwiB2C_RattrapageActivationOrderBatch' and id != :thisJobId];
        if(!jobs.IsEmpty()){
            // RETURN 0 RECORDS SINCE A JOB IS STILL RUNNING
            return Database.getQueryLocator('select inwiB2C_IdOrder__c,inwiB2C_IdAccount__c from inwiB2C_CreateContractBulk__c where inwiB2C_StatutDeTraitement__c    = \'inwiB2C_Termine\' and inwiB2C_IdOrder__r.Status = \'Draft\' and inwiB2C_IdOrder__r.inwiB2C_Statut__c not in (\'inwiB2C_Activation\', \'inwiB2C_Activee\')');
        }
        else{
            if(!Test.isRunningTest()) {
                // JBEN - Limit records retrieved based on the metadata value
                String limitRecordsRetreived;
                limitRecordsRetreived = [Select MasterLabel, InwiB2C_LimitBulkBatch__c, Label from InwiB2C_CreateContractBulkLimit__mdt where label = 'InwiB2C_RattrapageActivationOrderLimit' limit 1].InwiB2C_LimitBulkBatch__c;


                String query = 'select Id, inwiB2C_IdOrder__c,inwiB2C_IdAccount__c,inwiB2C_Icc__c, inwiB2C_IdContract__c, inwiB2C_imsi__c, inwiB2C_Ki__c, inwiB2C_Mdn__c, inwiB2C_ProfileId__c, inwiB2C_Puk__c, inwiB2C_CodeArticle__c, inwiB2C_OcsId__c from inwiB2C_CreateContractBulk__c where inwiB2C_StatutDeTraitement__c    = \'inwiB2C_Termine\' and inwiB2C_IdOrder__r.Status = \'Draft\' and inwiB2C_IdOrder__r.inwiB2C_Statut__c not in (\'inwiB2C_Activation\',\'inwiB2C_Activee\') LIMIT '+ limitRecordsRetreived;
                //String query = 'select Id, inwiB2C_IdOrder__c,inwiB2C_IdAccount__c,inwiB2C_Icc__c, inwiB2C_IdContract__c, inwiB2C_imsi__c, inwiB2C_Ki__c, inwiB2C_Mdn__c, inwiB2C_ProfileId__c, inwiB2C_Puk__c, inwiB2C_CodeArticle__c, inwiB2C_OcsId__c from inwiB2C_CreateContractBulk__c where inwiB2C_StatutDeTraitement__c    = \'inwiB2C_Termine\' and inwiB2C_IdOrder__r.Status = \'Draft\' and inwiB2C_IdOrder__r.inwiB2C_Statut__c not in (\'inwiB2C_Activation\',\'inwiB2C_Activee\') and inwiB2C_Mdn__c = \'212704546851\' LIMIT '+ limitRecordsRetreived;
                return Database.getQueryLocator(query);

               
                    
            }
            else {
                return Database.getQueryLocator('Select Id, inwiB2C_IdOrder__c,inwiB2C_IdAccount__c,inwiB2C_Icc__c, inwiB2C_IdContract__c, inwiB2C_imsi__c, inwiB2C_Ki__c, inwiB2C_Mdn__c, inwiB2C_ProfileId__c, inwiB2C_Puk__c, inwiB2C_CodeArticle__c, inwiB2C_OcsId__c from inwiB2C_CreateContractBulk__c where inwiB2C_StatutDeTraitement__c    = \'inwiB2C_Termine\' and inwiB2C_IdOrder__r.Status = \'Draft\' and inwiB2C_IdOrder__r.inwiB2C_Statut__c not in (\'inwiB2C_Activation\',\'inwiB2C_Activee\') LIMIT 100 ');
            }
        }
    }
    public void execute (Database.BatchableContext BC, List<sobject> scope) {
        List<inwiB2C_CloneOrderEvent__e> cloneOrderListPE = new List<inwiB2C_CloneOrderEvent__e>();     
        for (sObject objScope: scope) {
            inwiB2C_CreateContractBulk__c newObjScope = (inwiB2C_CreateContractBulk__c)objScope;
            inwiB2C_CloneOrderEvent__e cloneOrderObj = new inwiB2C_CloneOrderEvent__e();
                                     
            cloneOrderObj.inwiB2C_CustomerId__c = newObjScope.inwiB2C_IdAccount__c;
            cloneOrderObj.inwiB2C_OrderId__c = newObjScope.inwiB2C_IdOrder__c;
            cloneOrderObj.inwiB2C_Icc__c = newObjScope.inwiB2C_Icc__c;
            cloneOrderObj.inwiB2C_imsi__c = newObjScope.inwiB2C_imsi__c;
            cloneOrderObj.inwiB2C_ki__c = newObjScope.inwiB2C_Ki__c;
            cloneOrderObj.inwiB2C_Mdn__c = newObjScope.inwiB2C_Mdn__c;
            cloneOrderObj.inwiB2C_ProfileId__c = newObjScope.inwiB2C_ProfileId__c;
            cloneOrderObj.inwiB2C_puk__c = newObjScope.inwiB2C_Puk__c;
            cloneOrderObj.inwiB2C_SimOCSID__c = newObjScope.inwiB2C_OcsId__c;
            cloneOrderObj.inwiB2C_MdnOCSID__c = newObjScope.inwiB2C_OcsId__c;
            cloneOrderObj.inwiB2C_CodeArticle__c = newObjScope.inwiB2C_CodeArticle__c;
            cloneOrderObj.inwiB2C_IdCreateContractBulk__c = newObjScope.id;
            cloneOrderObj.inwiB2C_ContratId__c=newObjScope.inwiB2C_IdContract__c;
            cloneOrderObj.inwiB2C_UpdateAttribute__c = true;
            cloneOrderObj.inwiB2C_CheckOut__c= true;
            

            cloneOrderListPE.add(cloneOrderObj);
                    

        }
        if(!Test.isRunningTest()) {
            List<Database.SaveResult> results = EventBus.publish(cloneOrderListPE);
        }
    }
    public void finish(Database.BatchableContext BC){
        AsyncApexJob a = [Select a.id, a.TotalJobItems, a.Status, a.NumberOfErrors,
        a.JobType, a.JobItemsProcessed, a.ExtendedStatus, a.CreatedById,
        a.CompletedDate From AsyncApexJob a WHERE id = :BC.getJobId()];
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] email = new String[]{'zakaria.mehdid@assa-associates.com'};
        mail.setToAddresses(email);
        mail.setReplyTo('zakaria.mehdid@assa-associates.com');
        mail.setSenderDisplayName('Batch Processing');
        mail.setSubject('Batch Process '+a.Status);
        mail.setPlainTextBody('The Batch Apex job ('+ a.id +') processed '+ a.TotalJobItems+' batches with '+a.NumberOfErrors+' failures '+' Job Itemprocessed are '+a.JobItemsProcessed);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    }
}