@isTest
public class InwiB2C_CallRehabilitationVIPTest {
@isTest(SeeAllData=true)
        public static void InwiB2C_CallRehabilitationVIPTest() {
       
        Test.startTest(); 
        List<String> Ids = new List <String>();   
             List<INWIB2C_HIST_ACTION_LINE__c> ListActionsToInsert = [ SELECT Id,inwiB2C_SubscriptionId__r.inwiB2C_Statut__c,inwiB2C_SubscriptionId__c,inwiB2C_TypeModification__c,createddate
          From INWIB2C_HIST_ACTION_LINE__c 
          Where inwiB2C_TypeModification__c = 'InwiB2C_suspensionDeFacturation'
          And inwiB2C_SubscriptionId__r.inwiB2C_Statut__c = 'InwiB2C_SuspendueFacturation' limit 1];
            for(INWIB2C_HIST_ACTION_LINE__c act: ListActionsToInsert ){
                system.debug('inwiB2C_SubscriptionId__c'+act.inwiB2C_SubscriptionId__c);
                Ids.Add(act.inwiB2C_SubscriptionId__c);
            }
          
            InwiB2C_CallRehabilitationVIP.CallVIP(Ids);
            Test.stopTest();
    }
}