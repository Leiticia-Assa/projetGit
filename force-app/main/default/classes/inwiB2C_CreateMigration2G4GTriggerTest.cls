@isTest
public class inwiB2C_CreateMigration2G4GTriggerTest {
    
        public static testMethod void CreateMigration2G4GTriggerTest() {
            
        InwiB2C_Migration2G4G__c NewMigrationRequest = new InwiB2C_Migration2G4G__c (InwiB2C_mdn2G__c='0112334422',InwiB2C_puk__c='26364298',InwiB2C_imsi__c='604050400057353', InwiB2C_ICC__c='892128510050204384', InwiB2C_codeArticle__c ='000012345', InwiB2C_ki__c='892128510050204384', InwiB2C_ocsId__c='IN2');  
        Insert NewMigrationRequest;
        List<InwiB2C_Migration2G4GEvt__e> eventItems = new List<InwiB2C_Migration2G4GEvt__e>();
        InwiB2C_Migration2G4GEvt__e eventItem = new InwiB2C_Migration2G4GEvt__e(inwiB2C_Step__c='Creation',inwiB2C_Migrationid__c='Migrationid',inwiB2C_mdn4G__c='0122334455');     
        eventItems.add(eventItem) ;
        
        InwiB2C_Migration2G4GEvt__e eventItem1 = new InwiB2C_Migration2G4GEvt__e(inwiB2C_Step__c='Changement2G',InwiB2C_mdn2G__c='0112334422',inwiB2C_Migrationid__c=NewMigrationRequest.Id,InwiB2C_puk__c='26364298',InwiB2C_imsi__c='604050400057353', InwiB2C_ICC__c='892128510050204384', InwiB2C_codeArticle__c ='000012345', InwiB2C_ki__c='892128510050204384', InwiB2C_ocsId__c='IN2');     
        eventItems.add(eventItem1) ;
        
        Test.startTest();
        List<Database.SaveResult> results = EventBus.publish(eventItems);
        Test.stopTest();
        
        System.assertEquals(eventItem1.inwiB2C_step__c, 'Changement2G');
        
    }

}