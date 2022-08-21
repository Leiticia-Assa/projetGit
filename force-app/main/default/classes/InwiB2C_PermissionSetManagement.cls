global with sharing  class InwiB2C_PermissionSetManagement implements vlocity_cmt.VlocityOpenInterface {


    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
            
        Boolean result = true;
            
        try{
            
            if(methodName.equals('getPermissionSetInfo')){
                getPermissionSetInfo(inputMap, outMap, options);
                        
            }
        } catch(Exception e){
                       
            result = false;
                    
        }
             
        return result;
                  
   }


    public static void getPermissionSetInfo(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        
      try{
        String idUser =  (String) options.get('iduser');
  
        Boolean isAuthorised = false;
        List<PermissionSetAssignment> userOfConsommationPS  =[SELECT AssigneeId FROM PermissionSetAssignment WHERE PermissionSet.Name = 'InwiB2C_Consommation'];
    
        for (PermissionSetAssignment loopVar : userOfConsommationPS) 
            if(loopVar.AssigneeId==idUser)   
                isAuthorised=true;
        
            

        outMap.put('isAuthorised',isAuthorised);
        } catch(Exception e){
                       
                            System.debug(e);    

        }

        
        

    }
   
   


}