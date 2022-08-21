global with sharing  class inwiB2C_CaseLabelMgt_DR implements vlocity_cmt.VlocityOpenInterface {


    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
            
        Boolean result = true;
            
        try{
            
            if(methodName.equals('populateLabelsDR_CaseClient')){
                populateLabelsDR_CaseClient(inputMap, outMap, options);
            
             // your implementation, use outMap to send response back to OmniScript                                                                  
            
            }
            else if(methodName.equals('populateLabelsDR_CaseSubscription')){
                populateLabelsDR_CaseSubscription(inputMap, outMap, options);
            
            // your implementation, use outMap to send response back to OmniScript                   
            
            }     
        } catch(Exception e){
                       
            result = false;
                    
        }
             
        return result;
                  
   }


    public static void populateLabelsDR_CaseClient(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {

       
        Map<String, String> caseStatusLabels = new Map<String, String>();


        // Récupération des labels de Statut de Case dans une Map
        for (PickListEntry pe : Case.status.getDescribe().getPicklistValues()) {
            caseStatusLabels.put(pe.getValue(), pe.getLabel());

        }
        
        Map<String, String> caseTypeLabels = new Map<String, String>();


        // Récupération des labels de Statut de Case dans une Map
        for (PickListEntry pe : Case.type.getDescribe().getPicklistValues()) {
            caseTypeLabels.put(pe.getValue(), pe.getLabel());

        }
        //Récupération du contenu du chanmp caseAll
        Map<String,Object> caseAll = (Map<String,Object>) inputMap.get('caseAll');

        system.debug(caseAll +'caseAll1');
        system.debug(caseAll.get('List') +'caseList1');

        // Récupération du contenu du champ List
        List <Map<String, Object>> caseList =  (List <Map<String, Object>>) caseAll.get('List');
        system.debug(caseList +'caseList');

        // parcours de la liste des Cases en input
        for (Map<String, Object> caseItem: caseList) {
            //récupération de la valeur du champ Statut
            String statutCode = (String) caseItem.get ('Statut');

            // récupération du label du champ statut sur base de la valeur en entrée
            String statutLabel = caseStatusLabels.get(statutCode);

            // Ajour d'un champ StatutLabel au Case
            caseItem.put('StatutLabel', statutLabel);


             //récupération de la valeur du champ Type
             String typeCode = (String) caseItem.get ('Type');

             // récupération du label du champ Type sur base de la valeur en entrée
             String typeLabel = caseTypeLabels.get(typeCode);
 
             // Ajour d'un champ TypeLabel au Case
             caseItem.put('TypeLabel', typeLabel);
             system.debug(typeLabel);
             system.debug(caseItem);

        }
        

        system.debug(caseAll+'caseALL2');


        outMap.put('caseAll',caseAll);
        system.debug(inputMap.get('CaseLimit')+'caseLimit0');

        List <Map<String, Object>> caseLimit = (List <Map<String, Object>>) inputMap.get('CaseLimit');
       
        system.debug(caseLimit +'caseLimit1');

        for (Map<String, Object> caseItem: caseLimit) {
            system.debug('aaaaa');

            //récupération de la valeur du champ Statut
            String statutCode = (String) caseItem.get ('Statuts');

            // récupération du label du champ statut sur base de la valeur en entrée
            String statutLabel = caseStatusLabels.get(statutCode);
            // Ajour d'un champ StatutLabel au Case
            caseItem.put('StatutLabel', statutLabel);

            //récupération de la valeur du champ Type
            String typeCode = (String) caseItem.get ('Type');

            // récupération du label du champ Type sur base de la valeur en entrée
            String typeLabel = caseTypeLabels.get(typeCode);

            // Ajour d'un champ TypeLabel au Case
            caseItem.put('TypeLabel', typeLabel);

        }


        outMap.put('CaseLimit',caseLimit );
        system.debug(CaseLimit+'CaseLimit');







    }


        




    public static void populateLabelsDR_CaseSubscription(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {

       
        Map<String, String> caseStatusLabels = new Map<String, String>();


        // Récupération des labels de Statut de Case dans une Map
        for (PickListEntry pe : Case.status.getDescribe().getPicklistValues()) {
            caseStatusLabels.put(pe.getValue(), pe.getLabel());

        }

        Map<String, String> caseTypeLabels = new Map<String, String>();


        // Récupération des labels de Statut de Case dans une Map
        for (PickListEntry pe : Case.type.getDescribe().getPicklistValues()) {
            caseTypeLabels.put(pe.getValue(), pe.getLabel());

        }
        //Récupération du contenu du chanmp caseAll
        Map<String,Object> caseAll = (Map<String,Object>) inputMap.get('caseAll');


        // Récupération du contenu du champ List
        List <Map<String, Object>> caseList =  (List <Map<String, Object>>) caseAll.get('List');

        // parcours de la liste des Cases en input
        for (Map<String, Object> caseItem: caseList) {

            //récupération de la valeur du champ Statut
            String statutCode = (String) caseItem.get ('Statut');

            // récupération du label du champ statut sur base de la valeur en entrée
            String statutLabel = caseStatusLabels.get(statutCode);

            // Ajour d'un champ StatutLabel au Case
            caseItem.put('StatutLabel', statutLabel);


             //récupération de la valeur du champ Type
             String typeCode = (String) caseItem.get ('Type');

             // récupération du label du champ Type sur base de la valeur en entrée
             String typeLabel = caseTypeLabels.get(typeCode);
 
             // Ajour d'un champ TypeLabel au Case
             caseItem.put('TypeLabel', typeLabel);

        }

        outMap.put('caseAll',caseAll );

        List <Map<String, Object>> caseLimit = (List <Map<String, Object>>) inputMap.get('CaseLimit');

        for (Map<String, Object> caseItem: caseLimit) {

            //récupération de la valeur du champ Statut
            String statutCode = (String) caseItem.get ('Statuts');

            // récupération du label du champ statut sur base de la valeur en entrée
            String statutLabel = caseStatusLabels.get(statutCode);

            // Ajour d'un champ StatutLabel au Case
            caseItem.put('StatutLabel', statutLabel);

            //récupération de la valeur du champ Type
            String typeCode = (String) caseItem.get ('Type');

            // récupération du label du champ Type sur base de la valeur en entrée
            String typeLabel = caseTypeLabels.get(typeCode);

            // Ajour d'un champ TypeLabel au Case
            caseItem.put('TypeLabel', typeLabel);
        }
        outMap.put('CaseLimit',caseLimit );
    }

}