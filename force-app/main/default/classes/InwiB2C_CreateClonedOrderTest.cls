@isTest
public class InwiB2C_CreateClonedOrderTest {
    @isTest(seeAllData=true)
    public static void CloneOrderTestMeth() {

        Map<String,Object> outMap = new  Map<String,Object>();
        Map<String,Object> options = new  Map<String,Object>();
        Map<String,Object> inputMap = new  Map<String,Object>();
        //Get the id of the template order
        List<Order> ListOrderToClone = [SELECT id, accountid, contractid from Order where InwiB2C_Offre__c = 'Offre TicTac Sim Seule' and contractid !='' and accountid != '' limit 1];
        List<inwiB2C_CreateContractBulk__c> ListCreateContractObj = [SELECT id from inwiB2C_CreateContractBulk__c limit 1];
        //Insert the id in the metadata
        InwiB2C_IdOrderToClone__mdt newOrderId = new InwiB2C_IdOrderToClone__mdt(OrderId__c = ListOrderToClone[0].Id, Label= 'OrderId');
        
        inputMap.put('inwiB2C_CustomerId__c',ListOrderToClone[0].accountid);
        inputMap.put('inwiB2C_ContratId__c',ListOrderToClone[0].contractid);
        inputMap.put('inwiB2C_UpdateAttribute__c',true);
        inputMap.put('inwiB2C_CheckOut__c',true);
        inputMap.put('inwiB2C_IdCreateContractBulk__c',ListCreateContractObj[0].Id);
        inputMap.put('inwiB2C_orderId__c',ListOrderToClone[0].id );
        
        String InputString = Json.serialize(inputMap);
        
        //call the class to clone the order and its orderitems
        //InwiB2C_CreateClonedOrder ClassCloneTest = new InwiB2C_CreateClonedOrder();
        InwiB2C_CreateClonedOrder.CloneOrder(InputString);
        
                /*Account testAccount = new Account();
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
        
        order neworder = new Order (Pricebook2Id = customPB.Id, inwiB2C_Statut__c ='inwiB2C_EnCours', EffectiveDate = Date.today().addDays(-1), inwib2c_TypeDeLaCommande__c = 'inwiB2C_Acquisition', Status = 'Draft', AccountId =testAccount.Id);
        insert neworder;
        
        String JsonAttr = '{"INWIB2C_ACAT_MOBILE":[{ "$$AttributeDefinitionStart$$": null, "objectid__c": "01t2500000632KBAAY", "attributeid__c": "a0X25000003WKyfEAG", "attributecategoryid__c": "a0W25000003M2TZEA0", "categorycode__c": "INWIB2C_ACAT_MOBILE", "categoryname__c": "Mobile", "attributeuniquecode__c": "INWIB2C_ATT_RT_ICCID", "attributeconfigurable__c": true, "attributedisplaysequence__c": "35", "attributefilterable__c": true, "attributecloneable__c": true, "isactive__c": true, "attributedisplayname__c": "ICCID", "displaysequence__c": "null", "categorydisplaysequence__c": 10, "customconfiguitemplate__c": null, "formatmask__c": null, "hasrule__c": false, "isconfigurable__c": true, "ishidden__c": false, "valueinnumber__c": null, "objecttype__c": "Product2", "querycode__c": null, "isreadonly__c": false, "isnottranslatable__c": false, "isquerydriven__c": false, "querylabel__c": null, "id": "a0U25000003mmHzEAI", "isrequired__c": true, "rulemessage__c": null, "uidisplaytype__c": "Text", "value__c": null, "valuedatatype__c": "Text", "valuedescription__c": null, "attributegrouptype__c": null, "attributeRunTimeInfo": { "dataType": "Text", "uiDisplayType": "Text", "value": "892128510050200922" }, "$$AttributeDefinitionEnd$$": null },{ "$$AttributeDefinitionStart$$": null, "objectid__c": "01t2500000632KBAAY", "attributeid__c": "a0X25000003XKyNEAW", "attributecategoryid__c": "a0W25000003M2TZEA0", "categorycode__c": "INWIB2C_ACAT_MOBILE", "categoryname__c": "Mobile", "attributeuniquecode__c": "INWIB2C_ATT_RT_MODELE_CARTE_SIM", "attributeconfigurable__c": true, "attributedisplaysequence__c": "1", "attributefilterable__c": false, "attributecloneable__c": true, "isactive__c": true, "attributedisplayname__c": "Modèle Carte Sim", "displaysequence__c": "10", "categorydisplaysequence__c": 10, "customconfiguitemplate__c": null, "formatmask__c": null, "hasrule__c": false, "isconfigurable__c": true, "ishidden__c": false, "valueinnumber__c": 56165, "objecttype__c": "Product2", "querycode__c": null, "isreadonly__c": false, "isnottranslatable__c": false, "isquerydriven__c": false, "querylabel__c": null, "id": "a0U25000003mmnCEAQ", "isrequired__c": false, "rulemessage__c": null, "uidisplaytype__c": "Dropdown", "value__c": "000056165", "valuedatatype__c": "Picklist", "valuedescription__c": null, "attributegrouptype__c": null, "attributeRunTimeInfo": { "dataType": "Picklist", "uiDisplayType": "Dropdown", "default": [{ "displayText": "S.A SIM 4G BOUTIQUES PREPAID", "id": "87113dce-34ed-d476-7080-5782930ab5d9", "sequence": 10, "value": "000056165" } ], "values": [{ "displayText": "S.A SIM 4G BOUTIQUES PREPAID", "id": "87113dce-34ed-d476-7080-5782930ab5d9", "sequence": 10, "value": "000056165" } ], "selectedItem": { "displayText": "S.A SIM 4G BOUTIQUES PREPAID", "id": "87113dce-34ed-d476-7080-5782930ab5d9", "sequence": 10, "value": "000056165" } }, "$$AttributeDefinitionEnd$$": null }]}';
            
        OrderItem newOrderitem = new OrderItem(Product2Id = prod.Id, vlocity_cmt__JSONAttribute__c = JsonAttr, PriceBookEntryId=customPrice.Id, OrderId=neworder.Id, Quantity=1, UnitPrice=customPrice.UnitPrice, ServiceDate=Date.Today());
        insert newOrderitem;*/
       

    }
}