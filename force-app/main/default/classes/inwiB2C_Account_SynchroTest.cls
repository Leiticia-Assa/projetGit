@isTest
public class inwiB2C_Account_SynchroTest {
    @isTest(SeeAllData=true)
    static  void MethodTestPositive(){
 		
        Account testAccount = new Account();
        testAccount.Name='Test Account';
        testAccount.inwiB2C_managedInSF__c= true;
        insert testAccount;
        testAccount.Name='Test Account1';
        update testAccount;
        
        
    }
}