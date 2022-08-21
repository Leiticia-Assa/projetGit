@isTest
public class inwiB2C_SubsMassProcessingTriggerTest {

    
    public static testMethod void SubsMassProcessingTriggerTest() {
        List<inwiB2C_SubsMassProcessingEvt__e> eventItems = new List<inwiB2C_SubsMassProcessingEvt__e>();
        inwiB2C_SubsMassProcessingEvt__e eventItem = new inwiB2C_SubsMassProcessingEvt__e(inwiB2C_step__c='SusRehabResil',inwiB2C_MDN__c='0177662233',inwiB2C_Action__c='SUSP',inwiB2C_SubMassId__c='MassProcessId');     
        eventItems.add(eventItem) ;
        
        inwiB2C_SubsMassProcessingEvt__e eventItem1 = new inwiB2C_SubsMassProcessingEvt__e(inwiB2C_step__c='Notification',inwiB2C_MDN__c='0177662222',inwiB2C_Action__c='SUSP',inwiB2C_SubMassId__c='MassProcessId');     
        eventItems.add(eventItem1) ;
        
        Test.startTest();
        List<Database.SaveResult> results = EventBus.publish(eventItems);
        Test.stopTest();
        
        System.assertEquals(eventItem1.inwiB2C_step__c, 'Notification');
        
    }
}