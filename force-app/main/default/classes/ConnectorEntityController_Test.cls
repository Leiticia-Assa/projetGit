@isTest
private class ConnectorEntityController_Test {

    static testMethod void myUnitTest() {
        Task a = new Task();
        a.Subject = 'test';
        a.CallType = 'Inbound';
        ConnectorEntityController.createTask(a, 'Email', 'test@inwi.ma');
        // Debut: TLA Upload package 22012021

        Account acct = new Account();

        acct.name = 'Test';

        insert acct;

        vlocity_cmt__Subscription__c subs = new vlocity_cmt__Subscription__c ();
        subs.vlocity_cmt__AccountId__c = acct.id;
        subs.Inwib2c_Num_ro_de_la_ligne__c = '0601010101';
        subs.vlocity_cmt__SubscriptionNumber__c = 'AAZERQZERQZE';

        insert subs;

        // LDA: check get Account Id from MDN
        Id acid = ConnectorEntityController.GetAccountId('0601010101');

        System.assertEquals(acct.id, acid);



        String Vloc = ConnectorEntityController.createVlocityInteraction(acid, 'ctiIteractionNumber', 'ctiMDN', 'ctiSource', 'ctiEmailSource', 'ctiFacebookId', 'ctiTwitterId');
        String GetU = ConnectorEntityController.GetResourceURL('namespace', 'resourceName');
        // Fin: TLA Upload package 22012021
        Case c = new Case();
        c.Subject = 'test';
        ConnectorEntityController.createCase(c, 'Email', 'test@inwi.ma');

        String ou = ConnectorEntityController.ERCOmniUtilsPath;
        String iwss = ConnectorEntityController.ERCiwsscriptomniPath;
        String su = ConnectorEntityController.ERCsyncUtilsPath;
    }
}