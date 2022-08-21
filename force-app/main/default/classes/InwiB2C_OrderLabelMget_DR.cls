global with sharing  class InwiB2C_OrderLabelMget_DR implements vlocity_cmt.VlocityOpenInterface {


    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
            
        Boolean result = true;
            
        try{
            
            if(methodName.equals('populateLabelsDR_Order')){
                populateLabelsDR_Order(inputMap, outMap, options);
            
             // your implementation, use outMap to send response back to OmniScript                                                                  
            
            }
            
        } catch(Exception e){
                       
            result = false;
                    
        }
             
        return result;
                  
   }


    public static void populateLabelsDR_Order(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {

       
        Map<String, String> OrderStatusLabels = new Map<String, String>();


        // Récupération des labels de Statut de Case dans une Map
        for (PickListEntry pe : Order.inwiB2C_Statut__c.getDescribe().getPicklistValues()) {
            OrderStatusLabels.put(pe.getValue(), pe.getLabel());

        }
        
        Map<String, String> OrderTypeLabels = new Map<String, String>();


        // Récupération des labels de Statut de Case dans une Map
        for (PickListEntry pe : Order.inwib2c_TypeDeLaCommande__c.getDescribe().getPicklistValues()) {
            OrderTypeLabels.put(pe.getValue(), pe.getLabel());

        }
        
                Map<String, String> ActionStatusLabels = new Map<String, String>();

          for (PickListEntry pe : INWIB2C_HIST_ACTION_LINE__c.inwiB2C_TypeAction__c.getDescribe().getPicklistValues()) {
            ActionStatusLabels.put(pe.getValue(), pe.getLabel());

        }
        
        
          Map<String, String> ActeTypeLabels = new Map<String, String>();

          for (PickListEntry pe : Order.inwiB2C_TypeActeDeGestion__c.getDescribe().getPicklistValues()) {
            ActeTypeLabels.put(pe.getValue(), pe.getLabel());

        }
        
        

            //Récupération du contenu du chanmp Order
            Map<String,Object> OrderAll = (Map<String,Object>) inputMap.get('OrderAll');
    
            // Récupération du contenu du champ List
            List <Map<String, Object>> OrderList =  (List <Map<String, Object>>) OrderAll.get('ListOrders');
            // parcours de la liste des Cases en input
            for (Map<String, Object> caseItem: OrderList) {
                //récupération de la valeur du champ Statut
                String statutCode = (String) caseItem.get ('Statut');
    
                // récupération du label du champ statut sur base de la valeur en entrée
                String statutLabel = OrderStatusLabels.get(statutCode);
    
                // Ajour d'un champ StatutLabel au Case
                caseItem.put('StatutLabel', statutLabel);
    
    
                 //récupération de la valeur du champ Type
                 String typeCode = (String) caseItem.get ('Type');
    
                 // récupération du label du champ Type sur base de la valeur en entrée
                 String typeLabel = OrderTypeLabels.get(typeCode);
     
                 // Ajour d'un champ TypeLabel au Case
                 caseItem.put('TypeLabel', typeLabel);
                 system.debug(typeLabel);
                 system.debug(caseItem);
    
            }
        

     //   system.debug(caseAll+'caseALL2');
     //   Reccupération de la liste des Actions
             List <Map<String, Object>> ActionList =  (List <Map<String, Object>>) OrderAll.get('ListActions');

        // parcours de la liste des Cases en input
        for (Map<String, Object> actionItem: ActionList) {

            //récupération de la valeur du champ Statut
            String TypeCode = (String) actionItem.get ('Type');

            // récupération du label du champ statut sur base de la valeur en entrée
            String TypeLabel = ActionStatusLabels.get(TypeCode);

            // Ajour d'un champ StatutLabel au Case
            actionItem.put('TypeLabel', TypeLabel);
        }
        
        
        
        //Récupération du contenu de la liste Acte de gestion
    
            // Récupération du contenu du champ List
            List <Map<String, Object>> ActeList =  (List <Map<String, Object>>) OrderAll.get('ListActeGestion');
            // parcours de la liste des Cases en input
            for (Map<String, Object> ActeItem: ActeList) {
                //récupération de la valeur du champ Statut
                String statutCode = (String) ActeItem.get ('Statut');    
                // récupération du label du champ statut sur base de la valeur en entrée
                String statutLabel = OrderStatusLabels.get(statutCode);
                // Ajour d'un champ StatutLabel au Case
                ActeItem.put('StatutLabel', statutLabel);
    
    
                 //récupération de la valeur du champ Type
                 String typeCode = (String) ActeItem.get ('Type');
    
                 // récupération du label du champ Type sur base de la valeur en entrée
                 String typeLabel = ActeTypeLabels.get(typeCode);
     
                 // Ajour d'un champ TypeLabel au Case
                 ActeItem.put('TypeLabel', typeLabel);
                 
    
            }


        outMap.put('OrderAll',OrderAll);
    




    }


        




  


}