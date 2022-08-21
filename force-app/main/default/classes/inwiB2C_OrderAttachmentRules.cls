public with sharing class inwiB2C_OrderAttachmentRules {

public static  Map<String,Object> getOrderAttachmentList (String IdOrder) {
    
    Order getOrderFields = [SELECT Id,inwib2c_TypeDeLaCommande__c,inwiB2C_TypeActeDeGestion__c,inwib2c_AvecPortabilite__c   ,inwiB2C_Canal__c,inwib2c_ModeDeLivraison__c  FROM Order where Id=:IdOrder ];
    List<OrderItem> getOrderItemFields = [Select OrderId,Product2.Family, Product2.ProductCode, vlocity_cmt__JSONAttribute__c ,vlocity_cmt__BillingAccountId__r.InwiB2C_Mode_de_paiement__c  from OrderItem where OrderId =: IdOrder and vlocity_cmt__ParentItemId__c =:''];
        
   
    String inwiB2C_TypedeLigne;
    String Family; 
    String ProductCode;
    String Mdp;   
List<String> OrderList = new List<String>{};    
    for(OrderItem getOrderItem : getOrderItemFields){
        inwiB2C_TypedeLigne  = INWIB2CJSONAttributeUtilities.getAttributeValueFromJSON(getOrderItem.vlocity_cmt__JSONAttribute__c, 'INWIB2C_ATT_RT_TYPE_LIGNE');   
        Family=getOrderItem.Product2.Family;
        ProductCode =getOrderItem.Product2.ProductCode;
        mdp=getOrderItem.vlocity_cmt__BillingAccountId__r.InwiB2C_Mode_de_paiement__c;
       // System.debug(inwiB2C_TypedeLigne);
   if(!OrderList.contains(inwiB2C_TypedeLigne)){        
           
            OrderList.add(inwiB2C_TypedeLigne);
        
            System.debug('new list2'+OrderList); 
        }
           OrderList.add(Family);
           OrderList.add(ProductCode);
           OrderList.add(mdp);
    } 
System.debug('liste finale = '+OrderList);


       List <inwiB2C_DocumentRule__c> documentList= [SELECT ID, Name , inwiB2C_Document__r.inwB2C_DocumentId__c,inwiB2C_Document__r.Name,  inwiB2C_Mandatory__c FROM inwiB2C_DocumentRule__c 
                                                  WHERE ((inwiB2C_TypeCommande__c =:getOrderFields.inwib2c_TypeDeLaCommande__c or inwiB2C_TypeCommande__c =:'All')
                                                  and  (inwiB2C_TypeActeDeGestion__c=: getOrderFields.inwiB2C_TypeActeDeGestion__c or inwiB2C_TypeActeDeGestion__c=:'All')
                                                  and (inwiB2C_ProductFamily__c in :OrderList or inwiB2C_ProductFamily__c=:'All')
                                                  and (inwiB2C_TypedeLigne__c in :OrderList or inwiB2C_TypedeLigne__c=:'All') 
                                                  and (Mode_de_livraison__c =:getOrderFields.inwib2c_ModeDeLivraison__c or Mode_de_livraison__c =:'All')
                                                  and inwiB2C_Portabilit__c=: getOrderFields.inwib2c_AvecPortabilite__c
                                                  and (inwiB2C_MethodeDelPaiement__c in :OrderList or inwiB2C_MethodeDelPaiement__c=:'All')
                                                  and (inwiB2C_CodeProduit__c in :OrderList or inwiB2C_CodeProduit__c = null)
                                                  and (inwiB2C_Canal__c=:getOrderFields.inwiB2C_Canal__c or inwiB2C_Canal__c=:'All')) order by inwiB2C_Document__r.Name desc ];
    System.debug(documentList);

    Map<String,Object> response = new Map<String,Object>();

    List<Object> DocumentListResponse = new List<Object>();

    for (inwiB2C_DocumentRule__c document: documentList){

        Map<String, Object> documentItem= new Map<String, Object>();
        documentItem.put('docTypeId', document.inwiB2C_Document__r.inwB2C_DocumentId__c);
        documentItem.put('docTypeLabel', document.inwiB2C_Document__r.Name);
        documentItem.put('mandatory', document.inwiB2C_Mandatory__c);

        DocumentListResponse.add(documentItem);

    }

    response.put('DocumentList', DocumentListResponse);

    System.debug(response.toString());

    return response;  
}
}