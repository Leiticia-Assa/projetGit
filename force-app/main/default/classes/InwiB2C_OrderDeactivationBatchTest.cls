@IsTest
public class InwiB2C_OrderDeactivationBatchTest {

    @TestSetup
    public static void setupData() {
        
        
        //List<Order> OrderList = TestUtility.prepare
        //insert OrderList;
    }
    
    public static testMethod void batchOrderTest() {

        Test.startTest();
        
                INWIB2C_REQ_PORTA__c NewPortaOutRequest = new INWIB2C_REQ_PORTA__c (INWIB2C_STATUT__c= 'NEW', INWIB2C_ACTION_CODE__c = 'DEACTIVATION', INWIB2C_PORTED_MDN__c ='212626979924');
        Insert NewPortaOutRequest;
        System.debug('ID PORTA OUT : '+ NewPortaOutRequest.Id);
        	Id bacthId = Database.executeBatch( new InwiB2C_OrderDeactivationBatch() , 10 );
        Test.stopTest();
    }
}