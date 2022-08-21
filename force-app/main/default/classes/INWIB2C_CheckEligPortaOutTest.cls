@isTest
public class INWIB2C_CheckEligPortaOutTest {
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
        
        vlocity_cmt__Subscription__c ligne1 = new vlocity_cmt__Subscription__c(Inwib2c_Num_ro_de_la_ligne__c = '212612345679',vlocity_cmt__SubscriptionNumber__c='999',
                                                                             Inwib2c_Offre__c = 'Mobile a la carte',inwiB2C_LegacyStatus__c='EXPIRED');
        Database.insert(ligne1,false);
        Asset asset1=new Asset(Name='asset',AccountId=client.Id,vlocity_cmt__SubscriptionId__c=ligne1.Id);
        insert asset1;
    }
    static testMethod void testPOST() {
        dataSetup();
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestBody =Blob.valueof('{"CSPortabilityOrder": {"id": "10,850,009","customerSegment": "B2C","customerIdentityType": "CNI","customerIdentityNumber": "123","customerAccountID": "","PortedNumber": [{"mdn": 212612345678} ]}, "CSOperationInfo": { "uuid": "6923969d-c235-4494-bdcf-85c47dc0da04","channel": "PORTMGM","user": "PortabilityUser"}}');
        req.requestURI = '/services/apexrest/CheckEligPortaOut';
        req.httpMethod = 'POST';
        RestContext.request =req; 
        RestContext.response= res;
        INWIB2C_CheckEligPortaOut.Checkeligibilite();
    }
static testMethod void testPOST1() {
        dataSetup();
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestBody =Blob.valueof('{"CSPortabilityOrder": {"id": "10,850,009","customerSegment": "B2C","customerIdentityType": "ONG","customerIdentityNumber": "123","customerAccountID": "","PortedNumber": [{"mdn": 212612345678} ]}, "CSOperationInfo": { "uuid": "6923969d-c235-4494-bdcf-85c47dc0da04","channel": "PORTMGM","user": "PortabilityUser"}}');
        req.requestURI = '/services/apexrest/CheckEligPortaOut';
        req.httpMethod = 'POST';
        RestContext.request =req; 
        RestContext.response= res;
        INWIB2C_CheckEligPortaOut.Checkeligibilite();
    }
    
    static testMethod void testPOST2() {
        dataSetup();
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestBody =Blob.valueof('{"CSPortabilityOrder": {"id": "10,850,009","customerSegment": "B2C","customerIdentityType": "CNI","customerIdentityNumber": "123","customerAccountID": "","PortedNumber": [{"mdn": 212612345679} ]}, "CSOperationInfo": { "uuid": "6923969d-c235-4494-bdcf-85c47dc0da04","channel": "PORTMGM","user": "PortabilityUser"}}');
        req.requestURI = '/services/apexrest/CheckEligPortaOut';
        req.httpMethod = 'POST';
        RestContext.request =req; 
        RestContext.response= res;
        INWIB2C_CheckEligPortaOut.Checkeligibilite();
    }
    
     static testMethod void testPOST3() {
        dataSetup();
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestBody =Blob.valueof('{"CSPortabilityOrder": {"id": "10,850,009","customerSegment": "B2C","customerIdentityType": "","customerIdentityNumber": "","customerAccountID": "","PortedNumber": [{"mdn": 212612345679} ]}, "CSOperationInfo": { "uuid": "6923969d-c235-4494-bdcf-85c47dc0da04","channel": "PORTMGM","user": "PortabilityUser"}}');
        req.requestURI = '/services/apexrest/CheckEligPortaOut';
        req.httpMethod = 'POST';
        RestContext.request =req; 
        RestContext.response= res;
        INWIB2C_CheckEligPortaOut.Checkeligibilite();
    }
   

}