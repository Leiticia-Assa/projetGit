public  class inwiB2C_OrderPromotionManagement {

    /* this is a development class to test logic. real called class is:
    *  inwiB2C_OrderPromotionManagementOS
    */

    class inwiB2C_PromotionEligibility{
        //Id promotion;
        Boolean eligible;
        String inclusionType;

    }

    public static List<InwiB2C_Promotion__c> getOrderEligiblePromotions(Id orderItemId){
        
        // Get Order - Type is Order Item because of the SOQL statement
        OrderItem currentOrder = [SELECT orderId, order.OrderNumber, vlocity_cmt__RootItemId__c ,  order.inwiB2C_Canal__c, order.inwiB2C_TypeActeDeGestion__c, order.inwib2c_TypeDeLaCommande__c, order.AccountId, vlocity_cmt__JSONAttribute__c FROM orderItem WHERE id = :orderItemId];
        
        // Get children
        List<OrderItem> currentOrderItemList = [select id, Product2.ProductCode, vlocity_cmt__JSONAttribute__c from   orderItem  where  vlocity_cmt__RootItemId__c   =:orderItemId      ];
		


        //LDA start: Build Map of Map for all orderitem attributes

        Map<String, Object> orderItemAttributes = new Map<String, Object>();


        for (OrderItem item : currentOrderItemList){

            if (item.vlocity_cmt__JSONAttribute__c != null){

                Map<String, Object> rootJsonAttribute = (Map<String, Object>)JSON.deserializeUntyped(item.vlocity_cmt__JSONAttribute__c);
                List<Object> INWIB2C_ACAT_MOBILE = (List<Object>) rootJsonAttribute.get('INWIB2C_ACAT_MOBILE'); 

                Map<String,String> attributeMap = new Map<String,String>();

                for (Object attribute: INWIB2C_ACAT_MOBILE){
                    Map<String, Object> itemAttributeMap = (Map<String, Object>) attribute;
                    Map<String, Object> attributeRunTimeInfo = (Map<String, Object>) itemAttributeMap.get('attributeRunTimeInfo');
                    String dataTypeProperty = (String)attributeRunTimeInfo.get('dataType');
                    String attributeCode = (String)  itemAttributeMap.get('attributeuniquecode__c');

                    String attributeValue;
                    if (('Picklist').equals(dataTypeProperty)){

                        Map<String, Object> selectedItem = (Map<String, Object>)attributeRunTimeInfo.get('selectedItem');

                        if (selectedItem != null){
                            attributeValue = (String) selectedItem.get('value');
                        }

                    }else if (('Checkbox').equals(dataTypeProperty)){

                        attributeValue = (Boolean) attributeRunTimeInfo.get('value')?'true':'false';

                    }else{

                        attributeValue = (String) attributeRunTimeInfo.get('value');

                    }

                    if (attributeValue != null) {
                        attributeMap.put(attributeCode,attributeValue );
                    }


                }

                if (attributeMap != null && attributeMap.size() > 0) {
                    orderItemAttributes.put(item.Product2.ProductCode, attributeMap);
                }
            

            }

            



        }

        system.debug(orderItemAttributes.size());

        List<InwiB2C_Promotion__c> promotionList = [SELECT id, name, inwiB2C_code_promotion__c, inwiB2C_Code_Produit__c, inwiB2C_Libelle_promotion__c, InwiB2C_Type_promotion__c FROM InwiB2C_Promotion__c WHERE InwiB2C_date_Debut__c <= TODAY and inwiB2C_date_fin__c >= TODAY];

        List<Id> promotionIdList = new List<Id>();

        for (InwiB2C_Promotion__c promotion: promotionList){
            promotionIdList.add(promotion.id);

        }


        //missing check on Type Acte de Gestion
        List<inwiB2C_scop_determinant__c> scopeDeterminantList = [SELECT id, Name, InwiB2C_Type_d_inclution__c, InwiB2C_type_acte_de_gestion__c, inwiB2C_Canal__c, inwiB2C_Promotion_discount__c FROM inwiB2C_scop_determinant__c WHERE inwiB2C_Promotion_discount__c in :promotionIdList and inwiB2C_Canal__c = :currentOrder.order.inwiB2C_Canal__c];

        List<Id> scopeDeterminantIdList = new List<Id>();

        for (inwiB2C_scop_determinant__c scopeDeterminant: scopeDeterminantList){
            scopeDeterminantIdList.add(scopeDeterminant.id);

        }

        Map<Id,Boolean> scopeDeterminantBooleanMap = new Map<Id,Boolean> ();
        Map<Id,inwiB2C_scop_determinant__c> scopeDeterminantMap = new Map<Id,inwiB2C_scop_determinant__c> ();

        for (inwiB2C_scop_determinant__c scopeDeterminant: scopeDeterminantList){
            scopeDeterminantBooleanMap.put(scopeDeterminant.Id, true);
            scopeDeterminantMap.put(scopeDeterminant.Id, scopeDeterminant);
        }

        List<inwiB2C_determinant__c> determinantList = [SELECT id, name, inwiB2C_scope__c, inwiB2C_Code_Produit__c, inwiB2C_code_attribute__c, inwiB2C_Valeur_attribut__c, inwiB2C_field__c, inwiB2C_value__c, inwiB2C_scope_determinant__c  FROM inwiB2C_determinant__c WHERE inwiB2C_scope_determinant__c in :scopeDeterminantIdList];

        // Build  SOQL statements

        String accountFields = null;
        String orderFields = null;

        Boolean needAsset = false;

        // need to add check to avoid multiple occurences of the same field

        // Build SOQL statements for each type of data scope

        List<String> clientFieldList = new List<String> ();
        List<String> orderFieldList = new List<String> ();
        
        for (inwiB2C_determinant__c determinant: determinantList){

            switch on determinant.inwiB2C_scope__c{
                when 'inwiB2C_Infos_client'{

                    if (! clientFieldList.contains(determinant.inwiB2C_field__c)){
                        clientFieldList.add(determinant.inwiB2C_field__c);
                        if (accountFields == null){

                            accountFields = determinant.inwiB2C_field__c;

                        }else{
                            accountFields += (',' + determinant.inwiB2C_field__c);

                        }

                    }

                    

                }
                when 'inwiB2C_Order'{

                    if (! orderFieldList.contains(determinant.inwiB2C_field__c)){
                        orderFieldList.add(determinant.inwiB2C_field__c);
                        if (orderFields == null){

                            orderFields = determinant.inwiB2C_field__c;

                        }else{
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

        sObject accountData = Database.query(accountSOQL);
        sObject orderData = Database.query(orderSOQL);
        List<vlocity_cmt__Subscription__c> subscriptionList;

        if (needAsset){
            subscriptionList = [SELECT id, Inwib2c_Offre__c FROM vlocity_cmt__Subscription__c WHERE vlocity_cmt__AccountId__c = :currentOrder.order.AccountId];
        }
        List<String> existingSubscriptionOfferList = new List<String>();

        for (vlocity_cmt__Subscription__c subscription: subscriptionList){
            existingSubscriptionOfferList.add(subscription.Inwib2c_Offre__c);
        }



        
        // Implement Determinant checks
        for (inwiB2C_determinant__c determinant: determinantList){

            switch on determinant.inwiB2C_scope__c{
                when 'inwiB2C_Infos_client'{

                    String accountField;
                    Sobject relObjChild,relObjGrandChild;
                    String[] fieldStructure = determinant.inwiB2C_field__c.split('\\.');

                    System.debug('fieldStructure size : ' + fieldStructure.size());

                    if (fieldStructure.size() == 1){
                        accountField = String.valueOf(accountData.get(determinant.inwiB2C_field__c));

                    }else if (fieldStructure.size() == 2){
                        relObjChild = accountData.getSObject(fieldStructure[0]); 

                        accountField = String.valueOf(relObjChild.get(fieldStructure[1]));

                    }else if (fieldStructure.size() == 3){
                        relObjChild = accountData.getSObject(fieldStructure[0]);
                        relObjGrandChild = relObjChild.getSObject(fieldStructure[1]); 

                        accountField = String.valueOf(relObjGrandChild.get(fieldStructure[2]));

                    }

                    System.debug('in info client : ' + accountField);
                    

                    if (accountField != null && accountField.equals(determinant.inwiB2C_value__c)){
                        Boolean oldEligibility = scopeDeterminantBooleanMap.get(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.remove(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.put(determinant.inwiB2C_scope_determinant__c, oldEligibility && true );
                        
                    }else{
                        Boolean oldEligibility = scopeDeterminantBooleanMap.get(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.remove(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.put(determinant.inwiB2C_scope_determinant__c, oldEligibility && false );
                    }

                }
                when 'inwiB2C_Order'{
                    String orderField;
                    Sobject relObjChild,relObjGrandChild;
                    String[] fieldStructure = determinant.inwiB2C_field__c.split('\\.');

                    System.debug('fieldStructure size : ' + fieldStructure.size());

                    if (fieldStructure.size() == 1){
                        orderField = String.valueOf(orderData.get(determinant.inwiB2C_field__c));

                    }else if (fieldStructure.size() == 2){
                        relObjChild = orderData.getSObject(fieldStructure[0]); 

                        orderField = String.valueOf(relObjChild.get(fieldStructure[1]));

                    }else if (fieldStructure.size() == 3){
                        relObjChild = orderData.getSObject(fieldStructure[0]);
                        relObjGrandChild = relObjChild.getSObject(fieldStructure[1]); 

                        orderField = String.valueOf(relObjGrandChild.get(fieldStructure[2]));

                    }

                    System.debug('in info client : ' + orderField);
                    

                    if (orderField != null && orderField.equals(determinant.inwiB2C_value__c)){
                        Boolean oldEligibility = scopeDeterminantBooleanMap.get(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.remove(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.put(determinant.inwiB2C_scope_determinant__c, oldEligibility && true );
                        
                    }else{
                        Boolean oldEligibility = scopeDeterminantBooleanMap.get(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.remove(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.put(determinant.inwiB2C_scope_determinant__c, oldEligibility && false );
                    }
                    
                }
                when 'inwiB2C_Order_item'{

                    Map<String,String> attributeMap = (Map<String,String>)orderItemAttributes.get(determinant.inwiB2C_Code_Produit__c);

                    if (attributeMap != null){

                        String value = attributeMap.get(determinant.inwiB2C_code_attribute__c);

                        if (value != null && value.equals(determinant.inwiB2C_Valeur_attribut__c)){
                            Boolean oldEligibility = scopeDeterminantBooleanMap.get(determinant.inwiB2C_scope_determinant__c);
                            scopeDeterminantBooleanMap.remove(determinant.inwiB2C_scope_determinant__c);
                            scopeDeterminantBooleanMap.put(determinant.inwiB2C_scope_determinant__c, oldEligibility && true );

                        }else {

                            Boolean oldEligibility = scopeDeterminantBooleanMap.get(determinant.inwiB2C_scope_determinant__c);
                            scopeDeterminantBooleanMap.remove(determinant.inwiB2C_scope_determinant__c);
                            scopeDeterminantBooleanMap.put(determinant.inwiB2C_scope_determinant__c, oldEligibility && false );

                        }

                    }else{

                        Boolean oldEligibility = scopeDeterminantBooleanMap.get(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.remove(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.put(determinant.inwiB2C_scope_determinant__c, oldEligibility && false );

                    }


                    
                }
                when 'inwiB2C_Assets'{

                    

                    if(existingSubscriptionOfferList.contains(determinant.inwiB2C_Code_Produit__c)){
                        Boolean oldEligibility = scopeDeterminantBooleanMap.get(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.remove(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.put(determinant.inwiB2C_scope_determinant__c, oldEligibility && true );
                    }else{
                        Boolean oldEligibility = scopeDeterminantBooleanMap.get(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.remove(determinant.inwiB2C_scope_determinant__c);
                        scopeDeterminantBooleanMap.put(determinant.inwiB2C_scope_determinant__c, oldEligibility && false );

                    }
                    
                }

            }
        }





        // LDA end


        system.debug(scopeDeterminantBooleanMap);

        Map<Id, inwiB2C_PromotionEligibility> promotionEligibilityMap = new Map<Id, inwiB2C_PromotionEligibility>();

        for (id scopeDeterminantId: scopeDeterminantBooleanMap.keySet() ){
            if (scopeDeterminantBooleanMap.get(scopeDeterminantId)){
                inwiB2C_scop_determinant__c scoprDeterminant =  scopeDeterminantMap.get(scopeDeterminantId);
                id promotionId = scoprDeterminant.inwiB2C_Promotion_discount__c;
                if (promotionEligibilityMap.containsKey(promotionId)){
                    inwiB2C_PromotionEligibility promotionEligibility = promotionEligibilityMap.get(promotionId);
                    if ('Cochable'.equals(promotionEligibility.inclusionType) && 'included'.equals(scoprDeterminant.InwiB2C_Type_d_inclution__c) ){
                        promotionEligibility.inclusionType = scoprDeterminant.InwiB2C_Type_d_inclution__c;
                    }

                    
                }else{

                    inwiB2C_PromotionEligibility promotionEligibility = new inwiB2C_PromotionEligibility();
                    promotionEligibility.eligible = true;
                    promotionEligibility.inclusionType = scoprDeterminant.InwiB2C_Type_d_inclution__c;
                    promotionEligibilityMap.put(promotionId, promotionEligibility);

                }
            }
        }

        system.debug(promotionEligibilityMap.toString());

        
       


        List<InwiB2C_Promotion__c> eligiblepromotionList= new List<InwiB2C_Promotion__c>();
		return eligiblepromotionList ; 


    }
    
}