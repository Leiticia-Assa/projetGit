@isTest
private class Inwib2c_updateSubswithoutcontrTest {
    @testSetup
    static void setup() {
        List<vlocity_cmt__Subscription__c> subscriptions = new List<vlocity_cmt__Subscription__c>();
   
        // insert 10 subscriptions
        for (Integer i=0;i<10;i++) {
            vlocity_cmt__Subscription__c  sub = new vlocity_cmt__Subscription__c();
            sub.name='vlocity_cmt__Subscription__c '+i;
            sub.inwiB2C_managedInSF__c =true;
            sub.inwib2c_inst_prod_id__c='INS '+i;
            sub.vlocity_cmt__SubscriptionNumber__c='0025513232'+i;

            subscriptions.add(sub);
        }
        insert subscriptions;
  
    }
    @isTest static void test() {
        Test.startTest();
        Inwib2c_updateSubswithoutcontr uca = new Inwib2c_updateSubswithoutcontr();
        Id batchId = Database.executeBatch(uca);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertEquals(10, [select count() from vlocity_cmt__Subscription__c where inwiB2C_managedInSF__c = false]);
    }
}