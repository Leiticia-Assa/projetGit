//LDA BEGIN
public with sharing class inwiB2C_openLegacy360 {
    // Oxygene URLs
    @AuraEnabled
    public static  String  getCustOxygeneURLParam(ID AccountId){
        Account account = [SELECT ID, Name, AccountNumber FROM  Account WHERE ID = :AccountId];
        inwiB2COxygeneRedirect__mdt params = [SELECT inwiB2C_AES_Key__c, InwiB2C_AES_Vector__c, inwiB2C_BaseURL__c FROM inwiB2COxygeneRedirect__mdt LIMIT 1];
        Blob key = Blob.valueOf(params.inwiB2C_AES_Key__c);
        Blob myIv = Blob.valueOf(params.InwiB2C_AES_Vector__c);
        Blob data = Blob.valueOf(account.AccountNumber);
        Blob encryptedCustId = Crypto.encrypt('AES128', key, myIv, data);
        String encryptedCustIdStr = EncodingUtil.Base64Encode(encryptedCustId);
        //System.debug(encryptedCustIdStr);
        String urlParams = params.inwiB2C_BaseURL__c + '?operation=getCustomerView360&customerId=' + encryptedCustIdStr;
        return urlParams;
    }
    @AuraEnabled
    public static  String getSubscriptionOxygeneURLParam(ID subscriptionId){
        vlocity_cmt__Subscription__c subscription = [SELECT vlocity_cmt__AccountId__c, Inwib2c_Num_ro_de_la_ligne__c FROM vlocity_cmt__Subscription__c WHERE ID = :subscriptionId];
        Account account = [SELECT ID, Name, AccountNumber FROM  Account where ID = :subscription.vlocity_cmt__AccountId__c];
        inwiB2COxygeneRedirect__mdt params = [SELECT inwiB2C_AES_Key__c, InwiB2C_AES_Vector__c, inwiB2C_BaseURL__c FROM inwiB2COxygeneRedirect__mdt LIMIT 1];
        Blob key = Blob.valueOf(params.inwiB2C_AES_Key__c);
        Blob myIv = Blob.valueOf(params.InwiB2C_AES_Vector__c);
        Blob custIdBlob = Blob.valueOf(account.AccountNumber);
        Blob encryptedCustId = Crypto.encrypt('AES128', key, myIv, custIdBlob);
        //System.debug(account.AccountNumber);
        String encryptedCustIdStr = EncodingUtil.Base64Encode(encryptedCustId);
        //System.debug(encryptedCustIdStr);
        //ZME 20.11.2020 BEGIN
        //Blob mdnBlob = Blob.valueOf(subscription.Inwib2c_Num_ro_de_la_ligne__c.toPlainString());
        Blob mdnBlob = Blob.valueOf(subscription.Inwib2c_Num_ro_de_la_ligne__c);
        //ZME 20.11.2020 END
        Blob encryptedMDN = Crypto.encrypt('AES128', key, myIv, mdnBlob);
        //System.debug(subscription.Inwib2c_Num_ro_de_la_ligne__c);
        String encryptedMDNStr = EncodingUtil.Base64Encode(encryptedMDN);
        //System.debug(encryptedMDNStr);
        String urlParams = params.inwiB2C_BaseURL__c + '?operation=getLineView360&customerId=' + encryptedCustIdStr + '&numberLine=' + encryptedMDNStr;
        return urlParams;   
    }
    @AuraEnabled
    public static String  getBillAcctOxygeneURLParam(ID billAcctId){
        Account billAcct = [SELECT ID, Name, AccountNumber, ParentId FROM  Account where ID = :billAcctId];
        Account account = [SELECT ID, Name, AccountNumber FROM  Account where ID = :billAcct.ParentId];
        inwiB2COxygeneRedirect__mdt params = [SELECT inwiB2C_AES_Key__c, InwiB2C_AES_Vector__c, inwiB2C_BaseURL__c FROM inwiB2COxygeneRedirect__mdt LIMIT 1];
        Blob key = Blob.valueOf(params.inwiB2C_AES_Key__c);
        Blob myIv = Blob.valueOf(params.InwiB2C_AES_Vector__c);
        Blob custIdBlob = Blob.valueOf(account.AccountNumber);
        Blob encryptedCustId = Crypto.encrypt('AES128', key, myIv, custIdBlob);
        String encryptedCustIdStr = EncodingUtil.Base64Encode(encryptedCustId);
        //System.debug(encryptedCustIdStr);
        Blob billAcctIdBlob = Blob.valueOf(billAcct.AccountNumber);
        Blob encryptedBillAcct = Crypto.encrypt('AES128', key, myIv, billAcctIdBlob);
        String encryptedBillAcctStr = EncodingUtil.Base64Encode(encryptedBillAcct);
        //System.debug(encryptedBillAcctStr);
        String urlParams = params.inwiB2C_BaseURL__c + '?operation=getAccountView360&customerId=' + encryptedCustIdStr + '&accountId=' + encryptedBillAcctStr;
        return urlParams;
    }
    // PeopleSoft URLs
    @AuraEnabled
    public static  String  getCustPeopleSoftURLParam(ID AccountId){
        Account account = [SELECT ID, Name, AccountNumber FROM  Account WHERE ID = :AccountId];
        inwiB2CPeopleSoftRedirect__mdt params = [SELECT inwiB2C_BaseURL__c FROM inwiB2CPeopleSoftRedirect__mdt LIMIT 1];
        String urlParams = params.inwiB2C_BaseURL__c + 'M_CTI_360_POPUP.M_CTI_360_POPUP.GBL?CU_B2C_CODE=' + account.AccountNumber;
        return urlParams;
    }
    @AuraEnabled
    public static  String getSubscriptionPeopleSofURLParam(ID subscriptionId){
        vlocity_cmt__Subscription__c subscription = [SELECT vlocity_cmt__AccountId__c, Inwib2c_Num_ro_de_la_ligne__c FROM vlocity_cmt__Subscription__c WHERE ID = :subscriptionId];
        inwiB2CPeopleSoftRedirect__mdt params = [SELECT inwiB2C_BaseURL__c FROM inwiB2CPeopleSoftRedirect__mdt LIMIT 1];
        String urlParams = params.inwiB2C_BaseURL__c + 'M_EXTRANET_PARC_MENU.M_EXTRANET_PARC.GBL?&languageCd=FRA&SETID=COM01&M_LINE_ID=' + subscription.Inwib2c_Num_ro_de_la_ligne__c;
        return urlParams;
    }
    @AuraEnabled
    public static String  getBillAcctPeopleSofURLParam(ID billAcctId){
        Account billAcct = [SELECT ID, Name, AccountNumber, ParentId FROM  Account where ID = :billAcctId];
        inwiB2CPeopleSoftRedirect__mdt params = [SELECT inwiB2C_BaseURL__c FROM inwiB2CPeopleSoftRedirect__mdt LIMIT 1];
        String urlParams = params.inwiB2C_BaseURL__c + 'COMMUNICATIONS.RBT_ACCOUNT_CMP.COM?&SETID=COM01&ACTION=U&RBTACCTID=' + billAcct.AccountNumber;
        return urlParams;
    }
}
//LDA END