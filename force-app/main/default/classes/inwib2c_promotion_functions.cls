global class inwib2c_promotion_functions implements vlocity_cmt.VlocityOpenInterface{
    global Boolean invokeMethod(String methodName, Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options){

        Boolean result = true;

        try{

            if (methodName.equals('getAppliedPromotions')){
                getAppliedPromotions(inputMap, outMap, options);
            } else if (methodName.equals('saveAppliedPromotions')){
                saveAppliedPromotions(inputMap, outMap, options);
            } else if (methodName.equals('getAppliedPromotionsForCart')){
                getAppliedPromotionsForCart(inputMap, outMap, options);
            }


        } catch (Exception e){

            result = false;

        }

        return result;
    }

    public static void getAppliedPromotions(Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options){

        Id orderItemId = (String) inputMap.get('orderItemId');
        // Get children
        List<orderItemAppliedPromotion__c> appliedPromotions = [select id, promotionId__c
                                                                from orderItemAppliedPromotion__c
                                                                where orderItemId__c = :orderItemId];

        List<String> promotionsData = new List<String>();
        for (orderItemAppliedPromotion__c item : appliedPromotions){
            promotionsData.add(item.promotionId__c);
        }


        outMap.put('promotions', promotionsData);
    }

    public static void getAppliedPromotionsForCart(Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options){

        Id orderId = (String) inputMap.get('orderId');
        // Get children
        List<orderItemAppliedPromotion__c> appliedPromotions = [select orderItemId__c, promotionId__r.inwiB2C_Libelle_promotion__c
                                                                from orderItemAppliedPromotion__c
                                                                where orderItemId__r.OrderId = :orderId];

        outMap.put('promotions', appliedPromotions);
    }

    public static void saveAppliedPromotions(Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options){
        // Delete old applied promotion
        Id orderItemId = (String) inputMap.get('orderItemId');
        List<orderItemAppliedPromotion__c> oldAppliedPromotions = [select id
                                                                   from orderItemAppliedPromotion__c
                                                                   where orderItemId__c = :orderItemId];

        delete oldAppliedPromotions;

        // Save new applied promotions
        Map<String, Object> deserialized = (Map<String, Object>)inputMap.get('listPromotionIds');
        List<Map<String, Object>> data = new List<Map<String, Object>>();
        for (Object instance : (List<Object>)deserialized.get('data'))
            data.add((Map<String, Object>)instance);
        // List<Object> listPromotionIds = (List<Object>)inputMap.get('listPromotionIds');
        System.debug(data);

        List<orderItemAppliedPromotion__c> promotionsData = new List<orderItemAppliedPromotion__c>();
        for (Map<String, Object> tempObjMap : data){
            orderItemAppliedPromotion__c orderItemAppliedPromotion = new orderItemAppliedPromotion__c();
            orderItemAppliedPromotion.orderItemId__c = (String) tempObjMap.get('orderItemId');
            orderItemAppliedPromotion.promotionId__c = (String) tempObjMap.get('promotionId');
            promotionsData.add(orderItemAppliedPromotion);
        }
        System.debug(promotionsData);
        insert promotionsData;


        outMap.put('status', promotionsData);
    }

}