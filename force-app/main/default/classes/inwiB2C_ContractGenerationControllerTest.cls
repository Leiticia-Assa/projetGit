@isTest
public class inwiB2C_ContractGenerationControllerTest {
	@isTest(SeeAllData=true)
    static void validateStandardController(){
          
        Account testAccount = new Account();
        testAccount.Name='Test Account';
        insert testAccount;
        
        Product2 prod = new Product2(Name = 'Laptop X200', 
                                     Family = 'Hardware',
                                     ProductCode='INWIB2C_OFFERING_SIM'
                                   );
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
        
String JsonAttr = '{"INWIB2C_ACAT_MOBILE":[{"$$AttributeDefinitionStart$$":null,"objectid__c":"01t250000063AbgAAE","attributeid__c":"a0X25000003WKyuEAG","attributecategoryid__c":"a0W25000003M2TZEA0","categorycode__c":"INWIB2C_ACAT_MOBILE","categoryname__c":"Mobile","attributeuniquecode__c":"INWIB2C_ATT_RT_ROAMING_VOIX_SMS","attributeconfigurable__c":true,"attributedisplaysequence__c":"80","attributefilterable__c":true,"attributecloneable__c":true,"isactive__c":true,"attributedisplayname__c":"Roaming","displaysequence__c":"null","categorydisplaysequence__c":10,"customconfiguitemplate__c":null,"formatmask__c":null,"hasrule__c":false,"isconfigurable__c":true,"ishidden__c":false,"valueinnumber__c":null,"objecttype__c":"Product2","querycode__c":null,"isreadonly__c":false,"isnottranslatable__c":false,"isquerydriven__c":false,"querylabel__c":null,"id":"a0U25000003mpeWEAQ","isrequired__c":false,"rulemessage__c":null,"uidisplaytype__c":"Radiobutton","value__c":"Roaming Voix+SMS","valuedatatype__c":"Picklist","valuedescription__c":null,"attributegrouptype__c":null,"attributeRunTimeInfo":{"dataType":"Picklist","uiDisplayType":"Radiobutton","default":[{"value":"Roaming Voix+SMS","sequence":10,"id":"f33ec679-fb6f-730b-772a-6eb22ab1fc9b","displayText":"Roaming Voix+SMS"}],"values":[{"value":"Roaming Voix+SMS","sequence":10,"id":"f33ec679-fb6f-730b-772a-6eb22ab1fc9b","displayText":"Roaming Voix+SMS"},{"value":"Roaming Voix+SMS+Data","sequence":20,"id":"d97b0953-68d9-fc93-fc8a-ef12ac3070a6","displayText":"Roaming Voix+SMS+Data"}],"selectedItem":{"value":"Roaming Voix+SMS","sequence":10,"id":"f33ec679-fb6f-730b-772a-6eb22ab1fc9b","displayText":"Roaming Voix+SMS"}},"$$AttributeDefinitionEnd$$":null}]}';
        
        OrderItem newOrderitem = new OrderItem(Product2Id = prod.Id, vlocity_cmt__JSONAttribute__c = JsonAttr, PriceBookEntryId=customPrice.Id, OrderId=neworder.Id, Quantity=1, UnitPrice=customPrice.UnitPrice, ServiceDate=Date.Today());
        insert newOrderitem;
        
        //List<String> listIdOrder = new List<String>();
        //listIdOrder.add(neworder.Id);
        
        //List<Order> OrdersList = [select id from Order where id in :listIdOrder]; 
        //Test.setMock(HttpCalloutMock.class, new INWIB2C_SMSCalloutMock()); 
        PageReference pageRef = Page.inwiB2C_ContractGeneration;
        Test.setCurrentPage(pageRef);
        Test.StartTest(); 
            
              List<Order> OrderTarget = [select id from Order where id in (select OrderId from orderitem where quantity > 0) limit 1];
        //ApexPages.standardSetController sc = new ApexPages.standardSetController(OrdersList);
        
        ApexPages.currentPage().getParameters().put('orderid', String.valueOf(OrderTarget[0].Id));
        ApexPages.currentPage().getParameters().put('isvivs', String.valueOf(true));
        
        inwiB2C_ContractGenerationController testcall = new inwiB2C_ContractGenerationController();
        //testcall.inwiB2C_ContractGenerationController(sc);
        inwiB2C_ContractGenerationController.formatDate(Date.today());
        
        Test.StopTest();
      }
    
    	@isTest(SeeAllData=true)
    static void validateStandardController2(){
        
        //List<Contract> ListContract = [SELECT id FROM Contract where InwiB2C_Subscription_contract__r.inwib2c_type_offre__c != null and inwib2c_date_de_naissance__c != null and inwib2c_address__r.name != null limit 1];
        List<Contract> ListContract = [SELECT id FROM Contract where inwib2c_date_de_naissance__c != null and inwib2c_address__r.name != null limit 1];
        PageReference pageRef = Page.inwiB2C_ContractGeneration;
        Test.setCurrentPage(pageRef);
        Test.StartTest(); 
        ApexPages.standardSetController sc = new ApexPages.standardSetController(Database.getQueryLocator([SELECT Id FROM Order limit 2]));
        ApexPages.currentPage().getParameters().put('isvivs', String.valueOf(true));
        ApexPages.currentPage().getParameters().put('contractid', String.valueOf(ListContract[0].Id));
        ApexPages.currentPage().getParameters().put('dealer', String.valueOf(true));
        
        inwiB2C_ContractGenerationController testcall = new inwiB2C_ContractGenerationController();
        Test.StopTest();
      }
    
        	@isTest(SeeAllData=true)
    static void validateStandardController3(){
        
        List<Contract> ListContract = [SELECT id FROM Contract where inwib2c_date_de_naissance__c != null and inwib2c_address__r.name != null limit 1];
        
        PageReference pageRef = Page.inwiB2C_ContractGeneration;
        Test.setCurrentPage(pageRef);
        Test.StartTest(); 
        ApexPages.standardSetController sc = new ApexPages.standardSetController(Database.getQueryLocator([SELECT Id FROM Order limit 2]));
        ApexPages.currentPage().getParameters().put('isvivs', String.valueOf(false));
        ApexPages.currentPage().getParameters().put('contractid', String.valueOf(ListContract[0].Id));
        ApexPages.currentPage().getParameters().put('articleNonSerailise', String.valueOf('TEST'));
        ApexPages.currentPage().getParameters().put('dealer', String.valueOf(false));
        inwiB2C_ContractGenerationController testcall = new inwiB2C_ContractGenerationController();
        Test.StopTest();
      }
    
}