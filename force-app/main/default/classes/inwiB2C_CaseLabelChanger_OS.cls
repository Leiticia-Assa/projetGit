global with sharing  class inwiB2C_CaseLabelChanger_OS implements vlocity_cmt.VlocityOpenInterface{


    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
            
        Boolean result = true;
            
        try{
            
            if(methodName.equals('getStatusLabel')){
                getStatusLabel(inputMap, outMap, options);
                        
            }
        } catch(Exception e){
            result = false;
        }
  
        return result;
                  
   }


    public static void getStatusLabel(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {

        Map<String, String> caseStatusLabels = new Map<String, String>();
        Map<String, String> caseCategorieLabels = new Map<String, String>();

        System.debug('Case.status.getDescribe().getPicklistValues(): ');
        System.debug(Case.status.getDescribe().getPicklistValues() );

        // Récupération des labels de Statut de Case dans une Map
        for (PickListEntry pe : Case.status.getDescribe().getPicklistValues()) 
            caseStatusLabels.put(pe.getValue(), pe.getLabel());
        

            for (PickListEntry catVal : Case.Inwib2c_Cat_gorie__c.getDescribe().getPicklistValues()) 
            caseCategorieLabels.put(catVal.getValue(), catVal.getLabel());

        List<Object> AllCases = (List<Object>) options.get('allcases');

        try{
            for ( Integer i = 0, j = 0; i < AllCases.size() ; i++ ) {
               Map<String,Object> theCase =  (Map<String,Object>) AllCases[i];
               String theStatus = (String)theCase.get('Status');
               String theCategorie = (String)theCase.get('Categorie');
               for(String keyStat : caseStatusLabels.keySet())
                   if(theStatus == keyStat )
                        ((Map<String,Object>)AllCases[i]).put('Status', (String)caseStatusLabels.get(keyStat));
                    
                for(String keyCat : caseCategorieLabels.keySet())
                    if(theCategorie == keyCat )
                        ((Map<String,Object>)AllCases[i]).put('Categorie', (String)caseCategorieLabels.get(keyCat));
     
            }        
            outMap.put('InProgressCases',AllCases);

    }catch(Exception e){
            System.debug(e);           
        }


    }

}