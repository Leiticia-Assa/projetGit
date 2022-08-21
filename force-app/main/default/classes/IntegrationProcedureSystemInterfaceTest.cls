@isTest

public class IntegrationProcedureSystemInterfaceTest

{

    @testSetup

    public static void testDataSetup()

    {

        //Account creation

        Account acc = new Account();

        acc.Name = 'TestAcc';

        insert acc;

        //Product2 creation

        Product2 prod = new Product2();

        prod.Name= 'TestProd';

        insert prod;

       

        //PricebookEntry creation

        PricebookEntry pricebkEntry = new PricebookEntry();

        pricebkEntry.Pricebook2Id = Test.getStandardPricebookId();

        pricebkEntry.UnitPrice =99.99;

        pricebkEntry.Product2Id = prod.Id;

        pricebkEntry.vlocity_cmt__RecurringPrice__c = 100;

        pricebkEntry.UseStandardPrice = false;

        insert pricebkEntry;

       

        //Order creation creation

        Order ord = new Order();

        ord.AccountId = acc.Id;

        ord.Status ='Draft';

        ord.EffectiveDate = System.today();

        ord.Pricebook2Id = Test.getStandardPricebookId();

        insert ord;

       

        //DRBundle creation

        vlocity_cmt__DRBundle__c drBundle = new               vlocity_cmt__DRBundle__c();

        drBundle.Name ='test';

        drBundle.vlocity_cmt__DRMapName__c ='testMap';

        drBundle.vlocity_cmt__InterfaceObject__c = 'test';

        insert drBundle;

       

        //OrchestrationPlan creation

        vlocity_cmt__OrchestrationPlan__c orchPlan = new vlocity_cmt__OrchestrationPlan__c();

        orchPlan.vlocity_cmt__OrderId__c = ord.Id;

        insert orchPlan;

        Product2 p = new Product2 ();

          p.Name = 'TestProd';

          p.CurrencyIsoCode ='MAD';

          p.IsActive = true;

          p.ProductCode = 'INWI_OFFERING_MSISDN_STANDARD';

          p.vlocity_cmt__AttributeMetadata__c = 'Test B';

        insert p;

        Id pbId = Test.getStandardPricebookId();

        PriceBookEntry pe = new PriceBookEntry(PriceBook2Id = pbId, Product2Id = p.id, UnitPrice = 100, IsActive = true);

        insert pe;

        Order ordA = new Order(Pricebook2Id = pbId ,  AccountId = acc.Id, EffectiveDate = date.today(), Status = 'Draft');

        Insert ordA;

          OrderItem orderItem = new OrderItem();

        orderItem.Product2Id = p.Id;     

        orderItem.vlocity_cmt__JSONAttribute__c = 'Test B';

        orderItem.OrderId = ordA.Id;

        OrderItem.vlocity_cmt__AttributeSelectedValues__c = 'Test C';

        orderItem.PricebookEntryId = pe.Id;

        orderItem.Quantity = 1;

        orderItem.vlocity_cmt__LineNumber__c = '0001';

        orderItem.UnitPrice = 100;

        orderItem.vlocity_cmt__ProvisioningStatus__c = 'New';

        orderItem.Product2 = p;

        Insert orderItem;

        //OrchestrationItem creation

        vlocity_cmt__OrchestrationItem__c orchItem = new vlocity_cmt__OrchestrationItem__c();

        orchItem.Name = 'TestOrchItem';

        orchItem.vlocity_cmt__OrchestrationPlanId__c = orchPlan.Id;

        orchItem.vlocity_cmt__VlocityDataRaptorBundleId__c = drBundle.Id;

        orchItem.vlocity_cmt__RequestItemsVlocityDataRaptorBundleId__c = drBundle.Id;

        orchItem.vlocity_cmt__OrderItemsNodeName__c ='test';

        orchItem.vlocity_cmt__AttributesEncodingStyle__c = 'Flat';

        orchItem.vlocity_cmt__RequestItemsEncodingStyle__c = 'Flat';

        orchItem.vlocity_cmt__OrderItemId__c = orderItem.Id;

        insert orchItem;

   }

   

    @isTest

    public static void testIPSI()

    {

        //Query on the Orchestration created in Testsetup

        vlocity_cmt__OrchestrationItem__c orchItemQuery = [Select Id, Name, vlocity_cmt__OrchestrationPlanId__c, vlocity_cmt__OrderItemId__c,

                                                           vlocity_cmt__OrderItemId__r.OrderId, vlocity_cmt__VlocityDataRaptorBundleId__c,vlocity_cmt__VlocityDataRaptorBundleId__r.Name,

                                                           vlocity_cmt__VlocityDataRaptorBundleId__r.Id, vlocity_cmt__RequestItemsVlocityDataRaptorBundleId__c,

                                                           vlocity_cmt__RequestItemsVlocityDataRaptorBundleId__r.Id, vlocity_cmt__RequestItemsVlocityDataRaptorBundleId__r.Name,

                                                           vlocity_cmt__OrderItemsNodeName__c, vlocity_cmt__AttributesEncodingStyle__c, vlocity_cmt__RequestItemsEncodingStyle__c

                                                           from vlocity_cmt__OrchestrationItem__c

                                                           where Name ='TestOrchItem' ];

        Id orderItemId = [SELECT Id FROM OrderItem LIMIT 1].Id;

        Test.startTest();

        IntegrationProcedureSystemInterface ipsi = new IntegrationProcedureSystemInterface();

        ipsi.startBatch('https://dummy.com', 'Inwi_InwiB2C_Confirmeportability_IN');

        ipsi.executeItem('https://dummy.com', 'Inwi_InwiB2C_Confirmeportability_IN',orchItemQuery);

        ipsi.endBatch('https://dummy.com', 'Inwi_InwiB2C_Confirmeportability_IN');

        Test.stopTest();

    }

   

    

    @isTest

    public static void testIPSIB()

    {

        //Query on the Orchestration created in Testsetup

        vlocity_cmt__OrchestrationItem__c orchItemQuery = [Select Id, Name, vlocity_cmt__OrchestrationPlanId__c, vlocity_cmt__OrderItemId__c,

                                                           vlocity_cmt__OrderItemId__r.OrderId, vlocity_cmt__VlocityDataRaptorBundleId__c,vlocity_cmt__VlocityDataRaptorBundleId__r.Name,

                                                           vlocity_cmt__VlocityDataRaptorBundleId__r.Id, vlocity_cmt__RequestItemsVlocityDataRaptorBundleId__c,

                                                           vlocity_cmt__RequestItemsVlocityDataRaptorBundleId__r.Id, vlocity_cmt__RequestItemsVlocityDataRaptorBundleId__r.Name,

                                                           vlocity_cmt__OrderItemsNodeName__c, vlocity_cmt__AttributesEncodingStyle__c, vlocity_cmt__RequestItemsEncodingStyle__c

                                                           from vlocity_cmt__OrchestrationItem__c

                                                           where Name ='TestOrchItem' ];

        Id orderItemId = [SELECT Id FROM OrderItem LIMIT 1].Id;

        orchItemQuery.vlocity_cmt__OrderItemId__c = null;  

        update orchItemQuery;

        Test.startTest();

        IntegrationProcedureSystemInterface ipsi = new IntegrationProcedureSystemInterface();

        ipsi.startBatch('https://dummy.com', 'Inwi_InwiB2C_Confirmeportability_IN');

        ipsi.executeItem('https://dummy.com', 'Inwi_InwiB2C_Confirmeportability_IN',orchItemQuery);

        ipsi.endBatch('https://dummy.com', 'Inwi_InwiB2C_Confirmeportability_IN');

        Test.stopTest();

    }
    

}