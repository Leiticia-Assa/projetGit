@isTest
public class INWIB2C_SendSMSCaseTest {
    @isTest
    private static void testSendSMS(){
       Case req = INWIB2C_DataFactorySMS.createCasewithSubscription();
       List<String> id = new List<String>();
       id.add(req.Id);
       Test.setMock(HttpCalloutMock.class, new INWIB2C_SMSCalloutMock()); 
       INWIB2C_SendSMSCase.SendSMS(id);
    }
 /*   @isTest
    private static void testSendMsg(){
        Case req = INWIB2C_TestDataSMS.createCasewithSubscription();
       Test.setMock(HttpCalloutMock.class, new INWIB2C_SMSCalloutMock()); 
       Test.startTest();
       INWIB2C_SendSMSCase.SendMsg('Body',req.id);
       Test.stopTest();
       List<INWIB2C_SMSLog__c> logs = [select Name from INWIB2C_SMSLog__c where INWIB2C_CaseId__c=:req.Id];
       System.assertEquals(1, logs.size());
    }*/
    

}