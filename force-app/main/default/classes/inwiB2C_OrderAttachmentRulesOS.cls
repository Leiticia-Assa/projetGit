global with sharing class inwiB2C_OrderAttachmentRulesOS implements vlocity_cmt.VlocityOpenInterface{
    global Boolean invokeMethod(String methodName, Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options){

        Boolean result = true;

        try{

            if (methodName.equals('getOrderAttachmentList')){
                getOrderAttachmentList(inputMap, outMap, options);

                // your implementation, use outMap to send response back to OmniScript

            } else if (methodName.equals('applyPromotions')){
                //applyPromotions(inputMap, outMap, options);

                // your implementation, use outMap to send response back to OmniScript

            }

        } catch (Exception e){

            result = false;

        }

        return result;
    }


    public static void getOrderAttachmentList(Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options){

        String orderId = (String) inputMap.get('orderId');

        Map<String,Object> documents = inwiB2C_OrderAttachmentRules.getOrderAttachmentList(orderId);

        System.debug(documents);

        outMap.put('DocumentList', documents.get('DocumentList'));




    }
    
}