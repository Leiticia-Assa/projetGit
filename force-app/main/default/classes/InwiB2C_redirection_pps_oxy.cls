global with sharing  class InwiB2C_redirection_pps_oxy implements vlocity_cmt.VlocityOpenInterface {

    
    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        Boolean result = true;
        try{
            if(methodName.equals('redirect_pps')){
                redirect_pps(inputMap, outMap, options);
            }
            
            if(methodName.equals('redirect_oxy')){
                redirect_oxy(inputMap, outMap, options);
            }
            else {

            }                              
        } catch(Exception e){
                       
            result = false;     
        }

        return result;

   }


   public static void  redirect_pps(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        
    System.debug('start redirect_pps');
   // ID theId = ID.valueOf((String)options.get('linktogo'));
   System.debug(options.get('linktogo') +'linktogo');

   String retppsValue = inwiB2C_openLegacy360.getCustPeopleSoftURLParam((String)options.get('linktogo'));
   
    System.debug('retppsValue : ');
    System.debug(retppsValue);


    System.debug('end redirect_pps');

    outMap.put('redirectpps',retppsValue);

}
    
public static void  redirect_oxy(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
    
    System.debug('start redirect_oxy');

   // ID theId = ID.valueOf((String)options.get('linktogo'));

   String retoxyValue = inwiB2C_openLegacy360.getCustOxygeneURLParam((String)options.get('linktogo'));
   
    System.debug('retoxyValue : ');
    System.debug(retoxyValue);

    
    outMap.put('redirectoxy',retoxyValue);


    System.debug('end redirect_oxy');

}


}