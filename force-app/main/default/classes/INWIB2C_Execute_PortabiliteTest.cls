@isTest
public class INWIB2C_Execute_PortabiliteTest {
@testSetup
    static void dataSetup() {
        //create account and contact
        Contact cnt = new Contact(LastName='Test',FirstName='Test',InwiB2C_CIN__c='1234',InwiB2C_Type_CIN__c ='CNI');
        Insert cnt;
        Account client = new Account(Name='acc',vlocity_cmt__PersonContactId__c=cnt.id);
        insert client;
       
        
        vlocity_cmt__Subscription__c ligne = new vlocity_cmt__Subscription__c(Inwib2c_Num_ro_de_la_ligne__c = '212612345678',vlocity_cmt__SubscriptionNumber__c='999',
                                                                             Inwib2c_Offre__c = 'Mobile a la carte',inwiB2C_LegacyStatus__c='ACTIVE');
        Database.insert(ligne,false);
        Asset asset=new Asset(Name='asset',AccountId=client.Id,vlocity_cmt__SubscriptionId__c=ligne.Id);
        insert asset;
    }
    static testMethod void testPOST() {
        dataSetup();
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestBody =Blob.valueof('{"CSPortabilityOrder": {"id": 1000000000275436,"offerType": "MOBILE","sourceOperator": "INWI", "targetOperator": "mTelecom","newRoute": "D77","customerSegment": "B2C", "customerIdentityType": "ONG","customerIdentityNumber": "H98","PortedNumber": [{ "mdn": 212612345678} ]},"CSOperationInfo": {"uuid": "f975f115-dcc5-41fc-ad48-63a90f94425e","channel": "PORTMGM", "user": "PortabilityUser","action": "DEACTIVATION" }}');
        req.requestURI = '/services/apexrest/ExecutePortabilite';
        req.httpMethod = 'POST';
        RestContext.request =req; 
        RestContext.response= res;
        INWIB2C_Execute_Portabilite.ExecutePortabilite();
    }
    static testMethod void testPOST1() {
        dataSetup();
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestBody =Blob.valueof('{"CSPortabilityOrder": {"id": 1000000000275436,"offerType": "MOBILE","sourceOperator": "INWI", "targetOperator": "mTelecom","newRoute": "D77","customerSegment": "B2C", "customerIdentityType": "ONG","customerIdentityNumber": "H98","PortedNumber": [{ "mdn": 2126123456789} ]},"CSOperationInfo": {"uuid": "f975f115-dcc5-41fc-ad48-63a90f94425e","channel": "PORTMGM", "user": "PortabilityUser","action": "DEACTIVATION" }}');
        req.requestURI = '/services/apexrest/ExecutePortabilite';
        req.httpMethod = 'POST';
        RestContext.request =req; 
        RestContext.response= res;
        INWIB2C_Execute_Portabilite.ExecutePortabilite();
    }
}