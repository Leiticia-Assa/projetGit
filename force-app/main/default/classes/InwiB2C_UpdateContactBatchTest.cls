@isTest
public class InwiB2C_UpdateContactBatchTest {
		@isTest(SeeAllData=true)
        public static void UpdateContactBatchTest() {
        /* Begin JBE */
        Test.startTest();
            List<Contact> ListContactToUpdate = [ SELECT id, InwiB2C_Type_CIN__c from Contact limit 1];
            for (Contact con : ListContactToUpdate) {
                con.InwiB2C_Type_CIN__c = 'Carte d\'Identit? Nationale';
            }
            update ListContactToUpdate;
            Id bacthId2 = Database.executeBatch( new InwiB2C_UpdateContactBatch() , 10 );
         Test.stopTest();
    }
}