@isTest
public class inwiB2C_UpdateInvoicSuspensionBatchTest {
@isTest(SeeAllData=true)
        public static void inwiB2C_UpdateInvoicSuspensionBatchTest() {
       
        Test.startTest();
          List<INWIB2C_HIST_ACTION_LINE__c> ListActionsToInsert = [ SELECT Id,inwiB2C_SubscriptionId__r.inwiB2C_Statut__c,inwiB2C_SubscriptionId__c,inwiB2C_TypeModification__c,createddate
          From INWIB2C_HIST_ACTION_LINE__c 
          Where inwiB2C_TypeModification__c = 'InwiB2C_suspensionDeFacturation'
          And inwiB2C_SubscriptionId__r.inwiB2C_Statut__c = 'InwiB2C_SuspendueFacturation' limit 1];
            
         Id bacthId2 = Database.executeBatch( new inwiB2C_UpdateInvoicingSuspensionBatch(0));
         Test.stopTest();
    }
}