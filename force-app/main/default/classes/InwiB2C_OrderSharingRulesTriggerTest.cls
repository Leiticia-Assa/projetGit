@isTest
public class InwiB2C_OrderSharingRulesTriggerTest {

        
    public static testMethod void OrderSharingRulesTriggerTest() {
        Account testAccount = new Account();
        testAccount.Name='Test Account';
        insert testAccount;
        
        List<Order> ListOrders= new List<Order>();
        order neworder1 = new Order (inwiB2C_Statut__c ='inwiB2C_EnCours', EffectiveDate = Date.today().addDays(-1), inwib2c_TypeDeLaCommande__c = 'inwiB2C_Modification', Status = 'Draft', AccountId =testAccount.Id);
        ListOrders.add(neworder1);
        
        Test.startTest();
        insert neworder1;
        neworder1.inwiB2C_Statut__c = 'inwiB2C_Activation';
        //neworder1.inwiB2C_Statut__c = 'inwiB2C_NonConforme';
        Update neworder1;
        Test.stopTest();
        
        
        System.assertEquals(neworder1.inwib2c_TypeDeLaCommande__c, 'inwiB2C_Modification');
        
    }
    
}