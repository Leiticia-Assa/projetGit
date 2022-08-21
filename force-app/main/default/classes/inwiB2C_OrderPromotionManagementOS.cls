global with sharing class inwiB2C_OrderPromotionManagementOS implements vlocity_cmt.VlocityOpenInterface{
    global Boolean invokeMethod(String methodName, Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options){

        Boolean result = true;

        try{

            if (methodName.equals('getOrderEligiblePromotions')){
                getOrderEligiblePromotions(inputMap, outMap, options);

                // your implementation, use outMap to send response back to OmniScript

            } else if (methodName.equals('applyPromotions')){
                applyPromotions(inputMap, outMap, options);

                // your implementation, use outMap to send response back to OmniScript

            }

        } catch (Exception e){

            result = false;

        }

        return result;
    }

    class inwiB2C_PromotionEligibility{
        //Id promotion;
        Boolean eligible;
        String inclusionType;
    }

    public static void getOrderEligiblePromotions(Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options){

        Id orderItemId = (String) inputMap.get('orderItemId');

        // Get Order - Type is Order Item because of the SOQL statement
        OrderItem currentOrder = [SELECT orderId, order.OrderNumber, vlocity_cmt__RootItemId__c, order.inwiB2C_Canal__c, order.inwiB2C_TypeActeDeGestion__c, order.inwib2c_TypeDeLaCommande__c, order.AccountId, vlocity_cmt__JSONAttribute__c
                                  FROM orderItem
                                  WHERE id = :orderItemId];

        // Get children
        List<OrderItem> currentOrderItemList = [select id, Product2.ProductCode, vlocity_cmt__JSONAttribute__c
                                                from orderItem
                                                where vlocity_cmt__RootItemId__c = :orderItemId];


        //LDA start: Build Map of Map for all orderitem attributes

        Map<String, Object> orderItemAttributes = new Map<String, Object>();

        for (OrderItem item : currentOrderItemList){
            if (item.vlocity_cmt__JSONAttribute__c != null){

                Map<String, Object> rootJsonAttribute = (Map<String, Object>)JSON.deserializeUntyped(item.vlocity_cmt__JSONAttribute__c);
                List<Object> INWIB2C_ACAT_MOBILE = (List<Object>)rootJsonAttribute.get('INWIB2C_ACAT_MOBILE');

                Map<String, String> attributeMap = new Map<String, String>();

                for (Object attribute : INWIB2C_ACAT_MOBILE){
                    Map<String, Object> itemAttributeMap = (Map<String, Object>)attribute;
                    Map<String, Object> attributeRunTimeInfo = (Map<String, Object>)itemAttributeMap.get('attributeRunTimeInfo');
                    String dataTypeProperty = (String) attributeRunTimeInfo.get('dataType');
                    String attributeCode = (String) itemAttributeMap.get('attributeuniquecode__c');

                    String attributeValue;
                    if (('Picklist').equals(dataTypeProperty)){

                        Map<String, Object> selectedItem = (Map<String, Object>)attributeRunTimeInfo.get('selectedItem');

                        if (selectedItem != null){
                            attributeValue = (String) selectedItem.get('value');
                        }

                    } else if (('Checkbox').equals(dataTypeProperty)){

                        attributeValue = (Boolean) attributeRunTimeInfo.get('value') ? 'true' : 'false';

                    } else if (('Number').equals(dataTypeProperty)){

                        Integer intAttributeValue = Integer.valueof(attributeRunTimeInfo.get('value'));

                        attributeValue = intAttributeValue == null ? null : intAttributeValue.format();

                    } else{

                        attributeValue = (String) attributeRunTimeInfo.get('value');

                    }

                    if (attributeValue != null){
                        attributeMap.put(attributeCode, attributeValue);
                    }


                }

                if (attributeMap != null && attributeMap.size() > 0){
                    orderItemAttributes.put(item.Product2.ProductCode, attributeMap);
                }


            }


        }

        system.debug(orderItemAttributes.size());

        List<InwiB2C_Promotion__c> allPromotionList = [SELECT id, name, inwiB2C_code_promotion__c, inwiB2C_Code_Produit__c, inwiB2C_Libelle_promotion__c, InwiB2C_Type_promotion__c
                                                       FROM InwiB2C_Promotion__c
                                                       WHERE InwiB2C_date_Debut__c <= TODAY and inwiB2C_date_fin__c >= TODAY];


        /** LDA
         * Récupération des applied Products + code produit entete des promotions 'promotionList'
         * ne garder  que les promotions qui ont au moins un produit dans les order items ***/
        List<Id> allPromotionListIds = new List<Id>();
        for (InwiB2C_Promotion__c promotion : allPromotionList){
            allPromotionListIds.add(promotion.id);
        }

        // get all applied products
        List<inwiB2C_Applied_Product__c> allAppliedProducts = [select id, inwiB2C_Code_Produit__c, inwiB2C_Promotion_discount__c
                                                               from inwiB2C_Applied_Product__c
                                                               where IsDeleted = false and inwiB2C_Promotion_discount__c in:allPromotionListIds];
        System.debug('allAppliedProducts');
        System.debug(allAppliedProducts.size());
        System.debug(allAppliedProducts);

        // Generate map <idpromotion, string of all product)
        Map<id, String> promotionAllAppliedProduct = new Map<id, String>();
        for (InwiB2C_Promotion__c promotion : allPromotionList){
            String allPromotionProductCode = '';
            if (promotion.inwiB2C_Code_Produit__c != null && promotion.inwiB2C_Code_Produit__c != ''){
                allPromotionProductCode = allPromotionProductCode + promotion.inwiB2C_Code_Produit__c;
            }

            for (inwiB2C_Applied_Product__c appliedProductItem : allAppliedProducts){
                if (appliedProductItem.inwiB2C_Promotion_discount__c == promotion.id){
                    allPromotionProductCode = allPromotionProductCode + appliedProductItem.inwiB2C_Code_Produit__c;
                }
            }
            promotionAllAppliedProduct.put(promotion.id, allPromotionProductCode);
            System.debug('promotionAllAppliedProduct');
            System.debug(promotion.name);
            System.debug(allPromotionProductCode);
        }

        // Filter to get only valable promotion
        List<InwiB2C_Promotion__c> promotionList = new List<InwiB2C_Promotion__c>();
        for (InwiB2C_Promotion__c promotion : allPromotionList){
            String productCodes = promotionAllAppliedProduct.get(promotion.id);
            System.debug('productCodes');
            System.debug(promotion.name);
            System.debug(productCodes);
            for (OrderItem item : currentOrderItemList){
                if (productCodes.contains(item.Product2.ProductCode)){
                    promotionList.add(promotion);
                    break;
                }
            }
        }

        System.debug('promotionList');
        System.debug(promotionList);


        List<Id> promotionIdList = new List<Id>();
        Map<id, InwiB2C_Promotion__c> promotionMap = new Map<id, InwiB2C_Promotion__c>();

        for (InwiB2C_Promotion__c promotion : promotionList){
            promotionIdList.add(promotion.id);
            promotionMap.put(promotion.id, promotion);

        }


        //missing check on Type Acte de Gestion
        List<inwiB2C_scop_determinant__c> scopeDeterminantList = [SELECT id, Name, InwiB2C_Type_d_inclution__c, InwiB2C_type_acte_de_gestion__c, inwiB2C_Canal__c, inwiB2C_Promotion_discount__c
                                                                  FROM inwiB2C_scop_determinant__c
                                                                  WHERE inwiB2C_Promotion_discount__c in:promotionIdList and inwiB2C_Canal__c = :currentOrder.order.inwiB2C_Canal__c];

        List<Id> scopeDeterminantIdList = new List<Id>();

        for (inwiB2C_scop_determinant__c scopeDeterminant : scopeDeterminantList){
            scopeDeterminantIdList.add(scopeDeterminant.id);

        }

        Map<Id, Boolean> scopeDeterminantBooleanMap = new Map<Id, Boolean>();
        Map<Id, inwiB2C_scop_determinant__c> scopeDeterminantMap = new Map<Id, inwiB2C_scop_determinant__c>();

        for (inwiB2C_scop_determinant__c scopeDeterminant : scopeDeterminantList){
            scopeDeterminantBooleanMap.put(scopeDeterminant.Id, true);
            scopeDeterminantMap.put(scopeDeterminant.Id, scopeDeterminant);
        }

        List<inwiB2C_determinant__c> determinantList = [SELECT id, name, inwiB2C_scope__c, inwiB2C_Code_Produit__c, inwiB2C_code_attribute__c, inwiB2C_Valeur_attribut__c, inwiB2C_field__c, inwiB2C_value__c, inwiB2C_scope_determinant__c
                                                        FROM inwiB2C_determinant__c
                                                        WHERE inwiB2C_scope_determinant__c in:scopeDeterminantIdList];

        // Build  SOQL statements

        String accountFields = null;
        String orderFields = null;

        Boolean needAsset = false;

        // need to add check to avoid multiple occurences of the same field

        // Build SOQL statements for each type of data scope

        List<String> clientFieldList = new List<String>();
        List<String> orderFieldList = new List<String>();

        for (inwiB2C_determinant__c determinant : determinantList){

            switch on determinant.inwiB2C_scope__c{
                when 'inwiB2C_Infos_client'{

                    if (!clientFieldList.contains(determinant.inwiB2C_field__c)){
                        clientFieldList.add(determinant.inwiB2C_field__c);
                        if (accountFields == null){

                            accountFields = determinant.inwiB2C_field__c;

                        } else{
                            accountFields += (',' + determinant.inwiB2C_field__c);

                        }

                    }


                }
                when 'inwiB2C_Order'{

                    if (!orderFieldList.contains(determinant.inwiB2C_field__c)){
                        orderFieldList.add(determinant.inwiB2C_field__c);
                        if (orderFields == null){

                            orderFields = determinant.inwiB2C_field__c;

                        } else{
                            orderFields += (',' + determinant.inwiB2C_field__c);

                        }
                    }


                }

                when 'inwiB2C_Assets'{

                    needAsset = true;

                }

            }


        }

        String accountSOQL = 'SELECT ' + accountFields + ' FROM account WHERE ID = \'' + currentOrder.order.AccountId + '\'';
        String orderSOQL = 'SELECT ' + orderFields + ' FROM order WHERE ID = \'' + currentOrder.orderid + '\'';


        System.debug(accountSOQL);
        System.debug(orderSOQL);

        sObject accountData;
        sObject orderData;

        if (clientFieldList.size() > 0){
            accountData = Database.query(accountSOQL);
        }

        if (orderFieldList.size() > 0){
            orderData = Database.query(orderSOQL);
        }

        List<vlocity_cmt__Subscription__c> subscriptionList;

        List<String> existingSubscriptionOfferList = new List<String>();

        if (needAsset){
            subscriptionList = [SELECT id, Inwib2c_Offre__c
                                FROM vlocity_cmt__Subscription__c
                                WHERE inwiB2C_Statut__c = 'InwiB2C_Active' and vlocity_cmt__AccountId__c = :currentOrder.order.AccountId];

            for (vlocity_cmt__Subscription__c subscription : subscriptionList){
                existingSubscriptionOfferList.add(subscription.Inwib2c_Offre__c);
            }
        }


        System.debug('existingSubscriptionOfferList');
        System.debug(existingSubscriptionOfferList.size());
        
        System.debug('Before loop');
        // Implement Determinant checks
        for (inwiB2C_determinant__c determinant : determinantList){
            System.debug('in loob');

            switch on determinant.inwiB2C_scope__c{
                when 'inwiB2C_Infos_client'{
                    System.debug('in inwiB2C_Infos_client');

                    String accountField;
                    Sobject relObjChild, relObjGrandChild;
                    String[] fieldStructure = determinant.inwiB2C_field__c.split('\\.');

                    System.debug('fieldStructure size : ' + fieldStructure.size());

                    if (fieldStructure.size() == 1){
                        accountField = String.valueOf(accountData.get(determinant.inwiB2C_field__c));

                    } else if (fieldStructure.size() == 2){
                        relObjChild = accountData.getSObject(fieldStructure[0]);

                        accountField = String.valueOf(relObjChild.get(fieldStructure[1]));

                    } else if (fieldStructure.size() == 3){
                        relObjChild = accountData.getSObject(fieldStructure[0]);
                        relObjGrandChild = relObjChild.getSObject(fieldStructure[1]);

                        accountField = String.valueOf(relObjGrandChild.get(fieldStructure[2]));

                    }

                    System.debug('in info client : ' + accountField);


                    if (accountField != null && accountField.equals(determinant.inwiB2C_value__c)){
                        Boolean oldEligibility = scopeDeterminantBooleanMap.get(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.remove(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.put(determinant.inwiB2C_scope_determinant__c, oldEligibility && true);

                    } else{
                        Boolean oldEligibility = scopeDeterminantBooleanMap.get(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.remove(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.put(determinant.inwiB2C_scope_determinant__c, oldEligibility && false);
                    }

                }
                when 'inwiB2C_Order'{
                    System.debug('in inwiB2C_Order');
                    String orderField;
                    Sobject relObjChild, relObjGrandChild;
                    String[] fieldStructure = determinant.inwiB2C_field__c.split('\\.');

                    System.debug('fieldStructure size : ' + fieldStructure.size());

                    if (fieldStructure.size() == 1){
                        orderField = String.valueOf(orderData.get(determinant.inwiB2C_field__c));

                    } else if (fieldStructure.size() == 2){
                        relObjChild = orderData.getSObject(fieldStructure[0]);

                        orderField = String.valueOf(relObjChild.get(fieldStructure[1]));

                    } else if (fieldStructure.size() == 3){
                        relObjChild = orderData.getSObject(fieldStructure[0]);
                        relObjGrandChild = relObjChild.getSObject(fieldStructure[1]);

                        orderField = String.valueOf(relObjGrandChild.get(fieldStructure[2]));

                    }

                    System.debug('in info client : ' + orderField);


                    if (orderField != null && orderField.equals(determinant.inwiB2C_value__c)){
                        Boolean oldEligibility = scopeDeterminantBooleanMap.get(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.remove(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.put(determinant.inwiB2C_scope_determinant__c, oldEligibility && true);

                    } else{
                        Boolean oldEligibility = scopeDeterminantBooleanMap.get(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.remove(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.put(determinant.inwiB2C_scope_determinant__c, oldEligibility && false);
                    }

                }
                when 'inwiB2C_Order_item'{
                    System.debug('in inwiB2C_Order_item');

                    Map<String, String> attributeMap = (Map<String, String>)orderItemAttributes.get(determinant.inwiB2C_Code_Produit__c);

                    if (attributeMap != null){

                        String value = attributeMap.get(determinant.inwiB2C_code_attribute__c);

                        if (value != null && value.equals(determinant.inwiB2C_Valeur_attribut__c)){
                            Boolean oldEligibility = scopeDeterminantBooleanMap.get(determinant.inwiB2C_scope_determinant__c);
                            scopeDeterminantBooleanMap.remove(determinant.inwiB2C_scope_determinant__c);
                            scopeDeterminantBooleanMap.put(determinant.inwiB2C_scope_determinant__c, oldEligibility && true);

                        } else{

                            Boolean oldEligibility = scopeDeterminantBooleanMap.get(determinant.inwiB2C_scope_determinant__c);
                            scopeDeterminantBooleanMap.remove(determinant.inwiB2C_scope_determinant__c);
                            scopeDeterminantBooleanMap.put(determinant.inwiB2C_scope_determinant__c, oldEligibility && false);

                        }

                    } else{

                        Boolean oldEligibility = scopeDeterminantBooleanMap.get(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.remove(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.put(determinant.inwiB2C_scope_determinant__c, oldEligibility && false);

                    }


                }
                when 'inwiB2C_Assets'{
                    Boolean oldEligibility = scopeDeterminantBooleanMap.get(determinant.inwiB2C_scope_determinant__c);
                    boolean exist = false;
                    for (String item : existingSubscriptionOfferList){
                        if (determinant.inwiB2C_Code_Produit__c.contains(item)){
                            exist = true;
                            break;
                        }
                    }

                    scopeDeterminantBooleanMap.remove(determinant.inwiB2C_scope_determinant__c);
                    scopeDeterminantBooleanMap.put(determinant.inwiB2C_scope_determinant__c, oldEligibility && exist);

                    // if (existingSubscriptionOfferList.contains(determinant.inwiB2C_Code_Produit__c)){
                    //     Boolean oldEligibility = scopeDeterminantBooleanMap.get(determinant.inwiB2C_scope_determinant__c);
                    //     scopeDeterminantBooleanMap.remove(determinant.inwiB2C_scope_determinant__c);
                    //     scopeDeterminantBooleanMap.put(determinant.inwiB2C_scope_determinant__c, oldEligibility && true);
                    // } else{
                    //     Boolean oldEligibility = scopeDeterminantBooleanMap.get(determinant.inwiB2C_scope_determinant__c);
                    //     scopeDeterminantBooleanMap.remove(determinant.inwiB2C_scope_determinant__c);
                    //     scopeDeterminantBooleanMap.put(determinant.inwiB2C_scope_determinant__c, oldEligibility && false);

                    // }

                }

            }
        }


        system.debug(scopeDeterminantBooleanMap);

        Map<Id, inwiB2C_PromotionEligibility> promotionEligibilityMap = new Map<Id, inwiB2C_PromotionEligibility>();

        for (id scopeDeterminantId : scopeDeterminantBooleanMap.keySet()){
            if (scopeDeterminantBooleanMap.get(scopeDeterminantId)){
                inwiB2C_scop_determinant__c scoprDeterminant = scopeDeterminantMap.get(scopeDeterminantId);
                id promotionId = scoprDeterminant.inwiB2C_Promotion_discount__c;
                if (promotionEligibilityMap.containsKey(promotionId)){
                    inwiB2C_PromotionEligibility promotionEligibility = promotionEligibilityMap.get(promotionId);
                    if ('Cochable'.equals(promotionEligibility.inclusionType) && 'included'.equals(scoprDeterminant.InwiB2C_Type_d_inclution__c)){
                        promotionEligibility.inclusionType = scoprDeterminant.InwiB2C_Type_d_inclution__c;
                    }


                } else{

                    inwiB2C_PromotionEligibility promotionEligibility = new inwiB2C_PromotionEligibility();
                    promotionEligibility.eligible = true;
                    promotionEligibility.inclusionType = scoprDeterminant.InwiB2C_Type_d_inclution__c;
                    promotionEligibilityMap.put(promotionId, promotionEligibility);

                }
            }
        }

        system.debug(promotionEligibilityMap.toString());

        List<Object> eligiblePromotionList = new List<Object>();

        for (id promotionId : promotionEligibilityMap.keySet()){
            Map<String, Object> eligiblePromotion = new Map<String, Object>();

            System.debug('promotionId' + promotionId);

            eligiblePromotion.put('promotionId', promotionId);
            eligiblePromotion.put('eligible', promotionEligibilityMap.get(promotionId).eligible);
            eligiblePromotion.put('inclusionType', promotionEligibilityMap.get(promotionId).inclusionType);
            eligiblePromotion.put('promotionLabel', promotionMap.get(promotionId).inwiB2C_Libelle_promotion__c);

            eligiblePromotionList.add(eligiblePromotion);

            System.debug('in loop' + eligiblePromotion);

        }

        outMap.put('promotions', eligiblePromotionList);
    }

    public static void applyPromotions(Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options){
        System.debug('START applyPromotions');
        //
        Map<String, Object> deserialized = (Map<String, Object>)inputMap.get('promotionIdList');
        List<String> promotionIdList = new List<String>();
        for (Object instance : (List<Object>)deserialized.get('data')){
            Map<String, Object> instanceMap = (Map<String, Object>)instance;
            promotionIdList.add((String) instanceMap.get('promotionId'));
        }

        //
        //List<String> promotionIdList = (List<String>)inputMap.get('promotionIdList');
        Id orderItemId = (String) inputMap.get('orderItemId');

        System.debug(orderItemId);
        System.debug(promotionIdList);

        // Get Order - Type is Order Item because of the SOQL statement
        OrderItem currentOrder = [SELECT orderId, order.OrderNumber, vlocity_cmt__RootItemId__c, order.inwiB2C_Canal__c, order.inwiB2C_TypeActeDeGestion__c, order.inwib2c_TypeDeLaCommande__c, order.AccountId, vlocity_cmt__JSONAttribute__c
                                  FROM orderItem
                                  WHERE id = :orderItemId];

        // Get children
        List<OrderItem> currentOrderItemList = [SELECT id, Product2.ProductCode, vlocity_cmt__JSONAttribute__c, InwiB2C_FMS__c, InwiB2C_FMS_Total_OrderItem__c, UnitPrice, vlocity_cmt__UsageUnitPrice__c, InwiB2C_FMD__c, vlocity_cmt__RecurringCalculatedPrice__c, vlocity_cmt__RecurringCharge__c, vlocity_cmt__RecurringCost__c, vlocity_cmt__RecurringCostTotal__c, vlocity_cmt__RecurringDiscountPrice__c, vlocity_cmt__RecurringManualDiscount__c, vlocity_cmt__RecurringTotal__c
                                                FROM orderItem
                                                WHERE vlocity_cmt__RootItemId__c = :orderItemId];


        Map<String, String> orderItemAttributesMap = new Map<String, String>();
        Map<String, OrderItem> orderItemByProducCodesMap = new Map<String, OrderItem>();


        String allProductCode = '';
        for (OrderItem item : currentOrderItemList){
            System.debug('loop----');
            System.debug(item.Product2.ProductCode);
            if (item.vlocity_cmt__JSONAttribute__c != null){

                orderItemAttributesMap.put(item.Product2.ProductCode, item.vlocity_cmt__JSONAttribute__c);

            }
            orderItemByProducCodesMap.put(item.Product2.ProductCode, item);
            allProductCode = allProductCode + item.Product2.ProductCode;

        }

        System.debug('orderItemAttributesMap');
        System.debug(orderItemAttributesMap);
        System.debug('orderItemByProducCodesMap');
        System.debug(orderItemByProducCodesMap);

        List<inwiB2C_promotion_result__c> promotionResultList = [SELECT id, Name, inwiB2C_Result_type__c, inwiB2C_code_attribute__c, inwiB2C_valeur_attribut__c, inwiB2C_type_de_prix__c, inwiB2C_percent__c, inwiB2C_Promotion_discount__c, inwiB2C_Promotion_discount__r.inwiB2C_Code_Produit__c
                                                                 FROM inwiB2C_promotion_result__c
                                                                 WHERE inwiB2C_Promotion_discount__c in:promotionIdList];
        System.debug('promotionResultList');
        System.debug(promotionResultList);

        List<inwiB2C_Applied_Product__c> allAppliedProducts = [SELECT id, inwiB2C_Code_Produit__c, inwiB2C_Promotion_discount__c
                                                               FROM inwiB2C_Applied_Product__c
                                                               WHERE IsDeleted = false and inwiB2C_Promotion_discount__c in:promotionIdList];
        System.debug('allAppliedProducts');
        System.debug(allAppliedProducts);
        System.debug(allAppliedProducts.size());

        List<Map<String, Object>> outputList = new List<Map<String, Object>>();

        for (inwiB2C_promotion_result__c promotionResult : promotionResultList){
            Map<String, Object> outputItem = new Map<String, Object>();
            outputItem.put('promotionId', promotionResult.inwiB2C_Promotion_discount__c);

            if ('inwiB2C_Action'.equals(promotionResult.inwiB2C_Result_type__c)){
                System.debug('in inwiB2C_Action');
                OrderItem orderItem = orderItemByProducCodesMap.get(promotionResult.inwiB2C_Promotion_discount__r.inwiB2C_Code_Produit__c);
                if (orderItem != null){
                    if (orderItem.vlocity_cmt__JSONAttribute__c != null){
                        orderItem.vlocity_cmt__JSONAttribute__c = INWIB2C_INWIJSONAttributeUtilities.updateAttributeValueFromJSON(orderItem.vlocity_cmt__JSONAttribute__c, promotionResult.inwiB2C_code_attribute__c, promotionResult.inwiB2C_valeur_attribut__c);
                        outputItem.put('orderItemId', orderItem.id);
                        outputList.add(outputItem);
                    }
                } else{
                    for (inwiB2C_Applied_Product__c itemAppliedProduct : allAppliedProducts){
                        if (itemAppliedProduct.inwiB2C_Promotion_discount__c == promotionResult.inwiB2C_Promotion_discount__c && allProductCode.contains(itemAppliedProduct.inwiB2C_Code_Produit__c)){
                            OrderItem orderItemFromAppliedProduct = orderItemByProducCodesMap.get(itemAppliedProduct.inwiB2C_Code_Produit__c);
                            if (orderItemFromAppliedProduct != null){
                                if (orderItemFromAppliedProduct.vlocity_cmt__JSONAttribute__c != null){
                                    orderItemFromAppliedProduct.vlocity_cmt__JSONAttribute__c = INWIB2C_INWIJSONAttributeUtilities.updateAttributeValueFromJSON(orderItemFromAppliedProduct.vlocity_cmt__JSONAttribute__c, promotionResult.inwiB2C_code_attribute__c, promotionResult.inwiB2C_valeur_attribut__c);
                                    outputItem.put('orderItemId', orderItemFromAppliedProduct.id);
                                    outputList.add(outputItem);
                                }
                                break;
                            }
                        }
                    }
                }


            } else if ('inwiB2C_Discount'.equals(promotionResult.inwiB2C_Result_type__c)){
                System.debug('in inwiB2C_Discount');
                switch on promotionResult.inwiB2C_type_de_prix__c{
                    when 'FMS'{
                        System.debug('in FMS');
                        OrderItem orderItem = orderItemByProducCodesMap.get(promotionResult.inwiB2C_Promotion_discount__r.inwiB2C_Code_Produit__c);
                        System.debug('in FMS **' + promotionResult.inwiB2C_Promotion_discount__r.inwiB2C_Code_Produit__c);
                        if (orderItem != null){
                            System.debug('in FMS orderItem');
                            orderItem.InwiB2C_FMS__c = orderItem.InwiB2C_FMS__c * (100-promotionResult.inwiB2C_percent__c) / 100;
                            outputItem.put('orderItemId', orderItem.id);
                            outputList.add(outputItem);
                        } else{
                            System.debug('in FMS itemAppliedProduct');
                            for (inwiB2C_Applied_Product__c itemAppliedProduct : allAppliedProducts){
                                if (itemAppliedProduct.inwiB2C_Promotion_discount__c == promotionResult.inwiB2C_Promotion_discount__c && allProductCode.contains(itemAppliedProduct.inwiB2C_Code_Produit__c)){
                                    System.debug('in FMS itemAppliedProduct + ' + itemAppliedProduct.inwiB2C_Code_Produit__c);
                                    OrderItem orderItemFromAppliedProduct = orderItemByProducCodesMap.get(itemAppliedProduct.inwiB2C_Code_Produit__c);
                                    System.debug('in FMS itemAppliedProduct +++ ' + orderItemFromAppliedProduct.id);
                                    if (orderItemFromAppliedProduct != null){
                                        orderItemFromAppliedProduct.InwiB2C_FMS__c = orderItemFromAppliedProduct.InwiB2C_FMS__c * (100-promotionResult.inwiB2C_percent__c) / 100;
                                        outputItem.put('orderItemId', orderItemFromAppliedProduct.id);
                                        outputList.add(outputItem);
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    when 'FMD'{

                    }
                    when 'One time'{

                    }
                    when 'recurring price'{

                        OrderItem orderItem = orderItemByProducCodesMap.get(promotionResult.inwiB2C_Promotion_discount__r.inwiB2C_Code_Produit__c);
                        if (orderItem != null){
                            orderItem.vlocity_cmt__RecurringCharge__c = orderItem.vlocity_cmt__RecurringCharge__c * (100-promotionResult.inwiB2C_percent__c) / 100;
                            outputItem.put('orderItemId', orderItem.id);
                            outputList.add(outputItem);
                        } else{
                            for (inwiB2C_Applied_Product__c itemAppliedProduct : allAppliedProducts){
                                if (itemAppliedProduct.inwiB2C_Promotion_discount__c == promotionResult.inwiB2C_Promotion_discount__c && allProductCode.contains(itemAppliedProduct.inwiB2C_Code_Produit__c)){
                                    OrderItem orderItemFromAppliedProduct = orderItemByProducCodesMap.get(itemAppliedProduct.inwiB2C_Code_Produit__c);
                                    if (orderItemFromAppliedProduct != null){
                                        orderItemFromAppliedProduct.vlocity_cmt__RecurringCharge__c = orderItemFromAppliedProduct.vlocity_cmt__RecurringCharge__c * (100-promotionResult.inwiB2C_percent__c) / 100;
                                        outputItem.put('orderItemId', orderItemFromAppliedProduct.id);
                                        outputList.add(outputItem);
                                        break;
                                    }
                                }
                            }
                        }

                    }
                }


            }
        }

        outMap.put('result', outputList);
        System.debug('outMap');
        System.debug(outMap);
        update currentOrderItemList;
    }

}