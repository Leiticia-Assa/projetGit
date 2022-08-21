//LDA BEGIN
@isTest
public class inwiB2C_openLegacy360Test {
    @isTest
    static void getCustOxygeneURLParamTest(){
        inwiB2COxygeneRedirect__mdt params = [SELECT inwiB2C_AES_Key__c, InwiB2C_AES_Vector__c, inwiB2C_BaseURL__c FROM inwiB2COxygeneRedirect__mdt LIMIT 1];
        Account testAccount  = new Account ();
        testAccount.Name = 'TestOxygeneParam';
        testAccount.AccountNumber = '123456';
        Insert testAccount;
        String resultURL = inwiB2C_openLegacy360.getCustOxygeneURLParam(testAccount.Id);
        System.assertEquals(params.inwiB2C_BaseURL__c + '?operation=getCustomerView360&customerId=OQIrKk7vMuuOY+r13pg4xQ==', resultURL);
    }
    
    @isTest
    static void getSubscriptionOxygeneURLParam(){
        inwiB2COxygeneRedirect__mdt params = [SELECT inwiB2C_AES_Key__c, InwiB2C_AES_Vector__c, inwiB2C_BaseURL__c FROM inwiB2COxygeneRedirect__mdt LIMIT 1];
        Account testAccount  = new Account ();
        testAccount.Name = 'TestOxygeneParam';
        testAccount.AccountNumber = '123456';
        Insert testAccount;
        vlocity_cmt__Subscription__c testSubscription = new vlocity_cmt__Subscription__c();
        testSubscription.vlocity_cmt__AccountId__c = testAccount.Id;
        testSubscription.Inwib2c_Num_ro_de_la_ligne__c = '212600000021';
        testSubscription.vlocity_cmt__SubscriptionNumber__c = 	'212600000021';
        Insert testSubscription;
        String resultURL = inwiB2C_openLegacy360.getSubscriptionOxygeneURLParam(testSubscription.Id);
        System.assertEquals(params.inwiB2C_BaseURL__c + '?operation=getLineView360&customerId=OQIrKk7vMuuOY+r13pg4xQ==&numberLine=IrIfuVXxcxf030+1mWpkoA==' , resultURL);
    }
    
    @isTest
    static void getBillAcctOxygeneURLParam(){
        inwiB2COxygeneRedirect__mdt params = [SELECT inwiB2C_AES_Key__c, InwiB2C_AES_Vector__c, inwiB2C_BaseURL__c FROM inwiB2COxygeneRedirect__mdt LIMIT 1];
        Account testAccount  = new Account ();
        testAccount.Name = 'TestOxygeneParam';
        testAccount.AccountNumber = '123456';
        Insert testAccount;
        Account testBillAcct = new Account();
        testBillAcct.Name = 'Test Bill Account Param';
        testBillAcct.ParentId = testAccount.Id;
        testBillAcct.AccountNumber = '123123';
        Insert testBillAcct;
        String resultURL = inwiB2C_openLegacy360.getBillAcctOxygeneURLParam(testBillAcct.Id);
        System.assertEquals(params.inwiB2C_BaseURL__c + '?operation=getAccountView360&customerId=OQIrKk7vMuuOY+r13pg4xQ==&accountId=XiYb90kdZt6yxtWWjuIKPw==' , resultURL);
    }
    @isTest
    static void getCustPeopleSoftURLParamTest(){
        inwiB2CPeopleSoftRedirect__mdt params = [SELECT inwiB2C_BaseURL__c FROM inwiB2CPeopleSoftRedirect__mdt LIMIT 1];
        Account testAccount  = new Account ();
        testAccount.Name = 'TestOxygeneParam';
        testAccount.AccountNumber = '123456';
        Insert testAccount;
        String resultURL = inwiB2C_openLegacy360.getCustPeopleSoftURLParam(testAccount.Id);
        System.assertEquals(params.inwiB2C_BaseURL__c + 'M_CTI_360_POPUP.M_CTI_360_POPUP.GBL?CU_B2C_CODE=123456', resultURL);
    }
    
    @isTest
    static void getSubscriptionPeopleSofURLParamTest(){
        inwiB2CPeopleSoftRedirect__mdt params = [SELECT inwiB2C_BaseURL__c FROM inwiB2CPeopleSoftRedirect__mdt LIMIT 1];
        Account testAccount  = new Account ();
        testAccount.Name = 'TestOxygeneParam';
        testAccount.AccountNumber = '123456';
        Insert testAccount;
        vlocity_cmt__Subscription__c testSubscription = new vlocity_cmt__Subscription__c();
        testSubscription.vlocity_cmt__AccountId__c = testAccount.Id;
        testSubscription.Inwib2c_Num_ro_de_la_ligne__c = '212600000021';
        testSubscription.vlocity_cmt__SubscriptionNumber__c = 	'212600000021';
        Insert testSubscription;
        String resultURL = inwiB2C_openLegacy360.getSubscriptionPeopleSofURLParam(testSubscription.Id);
        System.assertEquals(params.inwiB2C_BaseURL__c + 'M_EXTRANET_PARC_MENU.M_EXTRANET_PARC.GBL?&languageCd=FRA&SETID=COM01&M_LINE_ID=212600000021' , resultURL);
    }
    
    @isTest
    static void getBillAcctPeopleSofURLParamTest(){
        inwiB2CPeopleSoftRedirect__mdt params = [SELECT inwiB2C_BaseURL__c FROM inwiB2CPeopleSoftRedirect__mdt LIMIT 1];
        Account testAccount  = new Account ();
        testAccount.Name = 'TestOxygeneParam';
        testAccount.AccountNumber = '123456';
        Insert testAccount;
        Account testBillAcct = new Account();
        testBillAcct.Name = 'Test Bill Account Param';
        testBillAcct.ParentId = testAccount.Id;
        testBillAcct.AccountNumber = '123123';
        Insert testBillAcct;
        String resultURL = inwiB2C_openLegacy360.getBillAcctPeopleSofURLParam(testBillAcct.Id);
        System.assertEquals(params.inwiB2C_BaseURL__c + 'COMMUNICATIONS.RBT_ACCOUNT_CMP.COM?&SETID=COM01&ACTION=U&RBTACCTID=123123' , resultURL);
    }
}
//LDA END