@IsTest
public class InwiB2C_SubsMassProcessingBatchTest {

    @TestSetup
    public static void setupData() {

    }
    
    public static testMethod void batchOrderTest() {

        Test.startTest();
        INWIB2C_SUBSMASSPROCESSING__c newOrder = new INWIB2C_SUBSMASSPROCESSING__c (INWIB2C_STATUT__c= 'NEW', INWIB2C_MDN__c = '', INWIB2C_MOTIF__c ='REHAB', INWIB2C_ACTION__c = 'REHAB');
        Insert newOrder;	
        Id bacthId = Database.executeBatch( new InwiB2C_SubsMassProcessingBatch() , 10 );
        Test.stopTest();
    }
}