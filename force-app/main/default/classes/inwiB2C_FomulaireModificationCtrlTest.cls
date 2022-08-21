@isTest
public class inwiB2C_FomulaireModificationCtrlTest {
	@isTest(SeeAllData=true)
    static void validateStandardController(){
          
        Account testAccount = new Account();
        testAccount.Name='Test Account';
        insert testAccount;
        
        Product2 prod = new Product2(Name = 'Laptop X200', 
                                     Family = 'Hardware',
                                     ProductCode='INWIB2C_OFFERING_SIM');
        insert prod;
        
        Id pricebookId = Test.getStandardPricebookId();
        
        PricebookEntry standardPrice = new PricebookEntry(
            Pricebook2Id = pricebookId, Product2Id = prod.Id,
            UnitPrice = 10000, IsActive = true);
        insert standardPrice;
        
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        
        PricebookEntry customPrice = new PricebookEntry(
            Pricebook2Id = customPB.Id, Product2Id = prod.Id,
            UnitPrice = 12000, IsActive = true);
        insert customPrice;
        
        order neworder = new Order (Pricebook2Id = customPB.Id, inwiB2C_Statut__c ='inwiB2C_EnCours', EffectiveDate = Date.today().addDays(-1), inwib2c_TypeDeLaCommande__c = 'inwiB2C_Modification', Status = 'Draft', AccountId =testAccount.Id);
        insert neworder;
        List<String> listIdOrder = new List<String>();
        listIdOrder.add(neworder.Id);
        
        List<Order> OrdersList = [select id from Order where id in :listIdOrder]; 
        
        PageReference pageRef = Page.inwiB2C_ContractGeneration;
        Test.setCurrentPage(pageRef);
        Test.StartTest(); 
        
        ApexPages.currentPage().getParameters().put('orderid', String.valueOf(neworder.Id));
        ApexPages.currentPage().getParameters().put('fromos', 'option');
        
        inwiB2C_FomulaireModificationCtrl testcall = new inwiB2C_FomulaireModificationCtrl();
        
        Test.StopTest();
      }
    
    	@isTest(SeeAllData=true)
    static void validateStandardController2(){
          
        Account testAccount = new Account();
        testAccount.Name='Test Account';
        insert testAccount;
        
        Product2 prod = new Product2(Name = 'Laptop X200', 
                                     Family = 'Hardware',
                                     ProductCode='INWIB2C_OFFERING_SIM');
        insert prod;
        
        Id pricebookId = Test.getStandardPricebookId();
        
        PricebookEntry standardPrice = new PricebookEntry(
            Pricebook2Id = pricebookId, Product2Id = prod.Id,
            UnitPrice = 10000, IsActive = true);
        insert standardPrice;
        
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        
        PricebookEntry customPrice = new PricebookEntry(
            Pricebook2Id = customPB.Id, Product2Id = prod.Id,
            UnitPrice = 12000, IsActive = true);
        insert customPrice;
        
        order neworder = new Order (Pricebook2Id = customPB.Id, inwiB2C_Statut__c ='inwiB2C_EnCours', EffectiveDate = Date.today().addDays(-1), inwib2c_TypeDeLaCommande__c = 'inwiB2C_Modification', Status = 'Draft', AccountId =testAccount.Id);
        insert neworder;
        List<String> listIdOrder = new List<String>();
        listIdOrder.add(neworder.Id);
        
        List<Order> OrdersList = [select id from Order where id in :listIdOrder]; 
        
        PageReference pageRef = Page.inwiB2C_ContractGeneration;
        Test.setCurrentPage(pageRef);
        Test.StartTest(); 
        
        ApexPages.currentPage().getParameters().put('orderid', String.valueOf(neworder.Id));
        ApexPages.currentPage().getParameters().put('fromos', 'mdn');
        
        inwiB2C_FomulaireModificationCtrl testcall = new inwiB2C_FomulaireModificationCtrl();
        
        Test.StopTest();
      }
}