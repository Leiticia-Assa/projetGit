global with sharing class INWIB2C_TransformOSSSMO implements vlocity_cmt.VlocityOpenInterface2 {
    global static boolean invokeMethod(String methodName, Map<String,Object> input, Map<String,Object> output, Map<String,Object> options) {        
         Boolean result = true;    
        try{
            
            if(methodName.equals('TransformOssJson')){
                TransformOssJson(input, output, options);                                                      
            
            }     
        } catch(Exception e){
                       
            result = false;
                    
        }     
        return result;            
   }  
    public static List<Map<String,Object>> TransformRessourceRef(String input){
        String jsonString='{"resourceRef":';        
        //String input='{"OLD_MSISDN":"INWIB2C_ATT_RT_MSISDN_PROVISIONAL","OCSID":"IN1","OLD_OCSID":"IN1","IMSI":"604050400053933","ICCID":"892128510050200964"}';
		jsonString=jsonString+input+'}';  
		Map<String, Object> deserialized = (Map<String, Object>)JSON.deserializeUntyped(jsonString);
		List<Map<String,Object>> listTmp=new List<Map<String,Object>>();
		for (String key : deserialized.keySet()){
            String jsonMap=JSON.serialize(deserialized.get(key));
            Map<String, Object> ressourceRef = (Map<String, Object>)JSON.deserializeUntyped(jsonMap);
            for (String key1 : ressourceRef.keySet())
            {
                {	
                    Map<String,Object> mapTmp = new Map<String,Object>();
            		mapTmp.put('name',key1);
         			mapTmp.put('value',ressourceRef.get(key1));
            		listTmp.add(mapTmp);    
                }
            }
        }
        return listTmp;
    }
    public static void TransformOssJson(Map<String, Object> deserialized,Map<String,Object> output, Map<String,Object> options){
        for (String key : deserialized.keySet())
        {    
            if(key=='resourceRef'){
                 String a = JSON.serialize(deserialized.get(key));
                List<Map<String,Object>> tmp=new List<Map<String,Object>>();
                 if(a.substring(0,1)=='[')
                     tmp=TransformRessourceRef(a.substring( 1, a.length() - 1 ));
                else
                     tmp=TransformRessourceRef(a);
                 output.put(key,tmp);
            } 
            else{
                output.put(key,deserialized.get(key));
            }
        }
        //String jsonMap=JSON.serialize(output);
        //System.debug(jsonMap);
    }
}