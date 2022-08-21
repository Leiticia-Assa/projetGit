@isTest
public class inwiB2C_CreateClientPSTriggerTest {

    public static testMethod void CreateClientPSTest() {

        /////////////////   
        List<inwiB2C_CreateClientPS_Evt__e> eventItems = new List<inwiB2C_CreateClientPS_Evt__e>();
        inwiB2C_CreateClientPS_Evt__e eventItem = new inwiB2C_CreateClientPS_Evt__e(inwiB2C_address__c='adress',inwiB2C_billingAdress__c=false,inwiB2C_email__c = 'test@test.com',inwiB2C_MDN__c = '0122334422',inwiB2C_familyName__c ='Benta',inwiB2C_legalName__c='Jawad', inwiB2C_identityNumber__c ='AW2211',inwiB2C_PREFERRED_CONTACT_CHANNEL__c='SMS');     
        eventItems.add(eventItem) ;
        

        Test.startTest();
        //List<Database.SaveResult> results = EventBus.publish(eventItems);
        Database.SaveResult res1 = EventBus.publish(eventItem);
        Test.stopTest();
       
        
       

}
    
}