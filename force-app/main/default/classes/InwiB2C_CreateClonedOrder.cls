// JBE - BEGIN
global class InwiB2C_CreateClonedOrder {

    @future (callout=true)
    Public static void CloneOrder(String inMap)
    { 
        System.debug('inside myMethod...'); //do your callout logic here... System.debug('exiting myMethod...');
        Map <String, Object> outMap = new Map <String, Object> ();
        Map <String, Object> options = new Map <String, Object> ();
        Map <String, Object> inputMap = (Map <String, Object>)JSON.deserializeUntyped(inMap);
        system.debug(inMap);

        /*
        String OrderIdMdt;

        String AccountId = (String) inputMap.get('inwiB2C_CustomerId__c');
        String ContractId = (String) inputMap.get('inwiB2C_ContratId__c');
        String createContractId = (String) inputMap.get('inwiB2C_IdCreateContractBulk__c');
        system.debug('ACCOUNT ID : '+ AccountId + ' Contract ID : '+ ContractId + ' createContractId: '+ createContractId);

        // Jawad - Get Account's segment to define it's a dealer or not
        String accountSegment = [Select Inwib2c_Segment_march__c from Account where Id =:AccountId limit 1].Inwib2c_Segment_march__c;
        if (accountSegment == 'Dealer'){
            OrderIdMdt = [Select MasterLabel, OrderId__c, Label from InwiB2C_IdOrderToClone__mdt where label = 'OrderIdDealer' limit 1].OrderId__c;
        }
        else{
            OrderIdMdt = [Select MasterLabel, OrderId__c, Label from InwiB2C_IdOrderToClone__mdt where label = 'OrderId' limit 1].OrderId__c;
        }

        List<OrderItem> NewOrderItems= new List<OrderItem>(); 
        //Get the generic order 
        List<Order> GenericOrder= [SELECT Pricebook2Id, vlocity_cmt__FulfilmentStatus__c, vlocity_cmt__IsChangesAllowed__c, vlocity_cmt__PriceListId__c, vlocity_cmt__SubmittedToOmDate__c,inwib2c_TypeDeLaCommande__c,inwib2c_Partenaire__c, inwib2c_Distributeur__c, inwib2c_ModeDePaiement__c, inwiB2C_Statut__c, accountid, status, EffectiveDate, inwiB2C_Canal__c,vlocity_cmt__CartIdentifier__c,ContractId,InwiB2C_Offre__c from order where id = :OrderIdMdt limit 1];
        
        //Clone order from the generic Order
        Order newOrder = GenericOrder[0].clone(false, true, false, true);

        //Update OrderFields before checkout
        //newOrder.Status = 'Activated';
        newOrder.inwiB2C_Statut__c = 'inwiB2C_EnCours';
        newOrder.EffectiveDate = date.today();

        if (AccountId != null && ContractId != null)
        {
            try{
            newOrder.AccountId = AccountId;
            newOrder.ContractId = ContractId;
            }
            catch(Exception e){
                System.debug('An unexpected error has occurred: ' + e.getMessage());
            }
        }
        newOrder.inwiB2C_Canal__c = 'inwiB2C_USSD';

        insert newOrder;
        system.debug('Order Id : '+newOrder.id);
        inwiB2C_CreateContractBulk__c createContractBulk = new inwiB2C_CreateContractBulk__c();
        createContractBulk.id = createContractId;
        createContractBulk.inwiB2C_IdOrder__c = newOrder.id;
        createContractBulk.inwiB2C_StatutDeTraitement__c = 'inwiB2C_Termine';
        update createContractBulk;
        //Update OrderFields
        
        //Clone OrderItem from the generic orderitem - tic tac offer
        //List<OrderItem> GenericOrderItems = [select vlocity_cmt__ParentItemId__c,vlocity_cmt__LineNumber__c,AvailableQuantity, UnitPrice, Quantity, CurrencyIsoCode, Description, InwiB2C_MDN__c, inwib2c_TransactionCode__c, IsDeleted, IsNotAssetizable__c, ListPrice, OrderId, OriginalOrderItem.OriginalOrderItemId, PricebookEntry.Id,PricebookEntry.Product2.id from OrderItem  where orderid ='80125000002A2aPAAS' limit 20];
        List<OrderItem> GenericOrderItems = [select InwiB2C_MDN__c,vlocity_cmt__CatalogItemReferenceDateTime__c, vlocity_cmt__UsageQuantity__c,OrderId, vlocity_cmt__AssetReferenceId__c, Product2Id, PricebookEntryId, AvailableQuantity, Quantity, CurrencyIsoCode, UnitPrice, ListPrice, TotalPrice, Description, OrderItemNumber, vlocity_cmt__Action__c, vlocity_cmt__BillingAccountId__c, vlocity_cmt__CpqCardinalityMessage__c, vlocity_cmt__CurrencyPaymentMode__c, vlocity_cmt__EffectiveOneTimeLoyaltyTotal__c, vlocity_cmt__EffectiveOneTimeTotal__c, vlocity_cmt__EffectiveQuantity__c, vlocity_cmt__EffectiveRecurringTotal__c, vlocity_cmt__InCartQuantityMap__c, vlocity_cmt__IsEditable__c, vlocity_cmt__IsProductTrackAgreement__c, vlocity_cmt__JSONAttribute__c,  vlocity_cmt__LineNumber__c, vlocity_cmt__MonthlyTotal__c, vlocity_cmt__OneTimeCalculatedPrice__c, vlocity_cmt__OneTimeCharge__c, vlocity_cmt__OneTimeLoyaltyPrice__c, vlocity_cmt__OneTimeLoyaltyTotal__c, vlocity_cmt__OneTimeManualDiscount__c, vlocity_cmt__OneTimeTotal__c, vlocity_cmt__OverageUOM__c, vlocity_cmt__ParentItemId__c, vlocity_cmt__PricingLogData__c, vlocity_cmt__Product2Id__c, vlocity_cmt__ProductHierarchyPath__c, vlocity_cmt__ProvisioningStatus__c, vlocity_cmt__RecurringCalculatedPrice__c, vlocity_cmt__RecurringCharge__c,  vlocity_cmt__RecurringManualDiscount__c, vlocity_cmt__RecurringTotal__c, vlocity_cmt__RelationshipType__c, vlocity_cmt__RootItemId__c, vlocity_cmt__SequenceNumber__c, vlocity_cmt__ServiceAccountId__c, vlocity_cmt__IsChangesAccepted__c, vlocity_cmt__IsChangesAllowed__c, IsNotAssetizable__c from orderitem where orderid = :OrderIdMdt limit 20];
       
        for (OrderItem Item : GenericOrderItems)
        {
            OrderItem newOrderItem = new OrderItem();
            newOrderItem = Item.clone(false, true, false, true);
            newOrderItem.OrderId = newOrder.Id;
            newOrderItem.vlocity_cmt__AssetReferenceId__c = null;
            newOrderItem.vlocity_cmt__BillingAccountId__c = AccountId;
            newOrderItem.vlocity_cmt__ServiceAccountId__c = AccountId;
            NewOrderItems.add(newOrderItem);
            system.debug('ORDER ITEM : ' + newOrder.Id);
        }
        Insert NewOrderItems;

        Map<String, Id> MapOrderItemsLevels = new Map<String, Id>();
        String OrderItemParentId;
        
        for (OrderItem NewOrderItem : NewOrderItems)
        {
            MapOrderItemsLevels.put(NewOrderItem.vlocity_cmt__LineNumber__c,NewOrderItem.Id );
            
        }
        OrderItemParentId = MapOrderItemsLevels.get('0001');
        List<OrderItem> UpdatedOrderItems = new List<OrderItem>();
        for (OrderItem NewOrderItem : NewOrderItems)
        {
            //LEVEL 1 - Nothing to do
            if(NewOrderItem.vlocity_cmt__LineNumber__c.length()!= 4)
            {
                //LEVEL 2
                if (NewOrderItem.vlocity_cmt__LineNumber__c.length()== 9)
                {
                    NewOrderItem.vlocity_cmt__ParentItemId__c = MapOrderItemsLevels.get(NewOrderItem.vlocity_cmt__LineNumber__c.substring(0,4));
                }

                //LEVEL 3
                if (NewOrderItem.vlocity_cmt__LineNumber__c.length()== 14)
                {
                    NewOrderItem.vlocity_cmt__ParentItemId__c = MapOrderItemsLevels.get(NewOrderItem.vlocity_cmt__LineNumber__c.substring(0,9));
                }
            }
            NewOrderItem.vlocity_cmt__RootItemId__c = OrderItemParentId;
            UpdatedOrderItems.add(newOrderItem);
        }
        update UpdatedOrderItems;
        */

        //outMap.put('orderId',newOrder.Id) ;

        // LDA optimization update OrderItem attributes Start
        // get Template Order based on account segment
        String AccountId = (String) inputMap.get('inwiB2C_CustomerId__c');
        // JBE - 20211211 - Adding updateattribute and checkout flags
        Boolean updateAttributeFlag = (Boolean) inputMap.get('inwiB2C_UpdateAttribute__c');
        Boolean checkoutFlag = (Boolean) inputMap.get('inwiB2C_CheckOut__c');
        
        String accountSegment = [Select Inwib2c_Segment_march__c from Account where Id =:AccountId limit 1].Inwib2c_Segment_march__c;
        String OrderIdMdt;
        if (accountSegment == 'Dealer'){
            OrderIdMdt = [Select MasterLabel, OrderId__c, Label from InwiB2C_IdOrderToClone__mdt where label = 'OrderIdDealer' limit 1].OrderId__c;
        }
        else{
            OrderIdMdt = [Select MasterLabel, OrderId__c, Label from InwiB2C_IdOrderToClone__mdt where label = 'OrderId' limit 1].OrderId__c;
        }

        // Get Template OrderItems
        List<OrderItem> GenericOrderItems = [select Product2Id, PricebookEntryId, vlocity_cmt__JSONAttribute__c,  vlocity_cmt__PricingLogData__c from orderitem where orderid = :OrderIdMdt limit 20];

        // get current OrderId
        String currentOrderId = (String) inputMap.get('inwiB2C_orderId__c');
        //Get current OrderItems
        List<OrderItem> currentOrderItemsList = [select Id, Product2Id, PricebookEntryId, vlocity_cmt__JSONAttribute__c,  vlocity_cmt__PricingLogData__c from orderitem where orderid = :currentOrderId limit 20];

        //Build map of Template OrderItems with ProductId as Key
        Map<String, OrderItem> genericOrderItemsMap = new Map<String, OrderItem> ();
        for (OrderItem genericOT: GenericOrderItems){
            
            genericOrderItemsMap.put(genericOT.Product2Id, genericOT);
        }

        // Loop through current OrderItems to update JSON attributes and Pricing Log
        if(!Test.isRunningTest()) {
        for (OrderItem currentOrderItem: currentOrderItemsList){
            currentOrderItem.vlocity_cmt__JSONAttribute__c = genericOrderItemsMap.get(currentOrderItem.Product2Id).vlocity_cmt__JSONAttribute__c;
            currentOrderItem.vlocity_cmt__PricingLogData__c = genericOrderItemsMap.get(currentOrderItem.Product2Id).vlocity_cmt__PricingLogData__c;
            
        }
        }

        update currentOrderItemsList;

        // LDA optimization update Order Item attributes END


        // JBE - 20211112 - Update Cart Attributes if the flag is true
        if (updateAttributeFlag == true )
        {
            String procedureName = 'inwib2c_inwib2c_updateCartAttributes';
            //inputMap.put('inwiB2C_orderId__c', newOrder.Id);
            /* Call the IP via runIntegrationService, and save the output to ipOutput */
            outMap = (Map<String, Object>) vlocity_cmt.IntegrationProcedureService.runIntegrationService(procedureName, inputMap, options);
            System.debug('IP Output updateCartProduct: ' + outMap);
        }
        /* Checkout the order */
        // LDA - 20211211 - Adding direct creation of Subscriptions- START
        if (checkoutFlag == true )
        {
            checkOutOrder((String) inputMap.get('inwiB2C_orderId__c'));
        }
        // LDA - 20211211 - Adding direct creation of Subscriptions- END




        /*inwiB2C_APICreateOrder__e eventCreateOrder = new inwiB2C_APICreateOrder__e();

        eventCreateOrder.inwiB2C_orderId__c =  newOrder.Id;
        eventCreateOrder.inwiB2C_step__c = 'checkOut';

        Database.SaveResult results = EventBus.publish(eventCreateOrder);
        */
    }

    //@future(callout=true)
    public static void checkOutOrder(String OrderId)
    {   
        Map<String, Object> ipInput = new Map<String, Object> ();
        Map<String, Object> outputMap = new Map<String, Object> ();
        Map<String, Object> optionsMap = new Map<String, Object> ();
        ipInput.put('inwiB2C_orderId__c', OrderId);
        System.debug('ipInput inwib2c_CheckoutOrderAPI' );
        System.debug(ipInput);
        //Update OrderFields before checkout
        List<Order> ClonedOrder = [SELECT ID from order where id = :OrderId limit 1 FOR UPDATE];
        ClonedOrder[0].inwiB2C_Statut__c = 'inwiB2C_Activation';
        update ClonedOrder;
        //optionsMap.put('useQueueableApexRemoting',true);
        //optionsMap.put('queueableChainable',true);
        //outputMap = (Map <String, Object>) vlocity_cmt.IntegrationProcedureService.runIntegrationService('inwib2c_CheckoutOrderAPI', ipInput, optionsMap);
        outputMap = (Map <String, Object>) vlocity_cmt.IntegrationProcedureService.runIntegrationService('inwib2c_inwib2c_checkoutAPI', ipInput, optionsMap);
        System.debug('IP Output CheckoutSyncAssetSMO: ' + outputMap);
        //ClonedOrder[0].Status = 'Activated';
    }
}
// JBE - END