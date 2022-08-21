global with sharing class INWIB2C_TransformJsonOSS implements vlocity_cmt.VlocityOpenInterface2{
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
    public static void TransformOssJson(Map<String, Object> deserialized,Map<String,Object> output, Map<String,Object> options){
      //String DRJson='{"serviceOrderItem": [{"code": "CAMEL","action": "ADD"},{"code": "VOLTE","action": "NOP"}],"relatedParty": [{"TYPE_LIGNE": "B2CPRE"}],"resourceRef": {"ICCID": "892128510050200964","IMSI": "604050400053933","OLD_OCSID": "IN1","OCSID": "IN1","OLD_MSISDN": "INWIB2C_ATT_RT_MSISDN_PROVISIONAL"},"action": "MOD","reason": "ORDER_CUSTOMIZATION","id": "a3625000000ETCQAA4"}';   
        //Map<String, Object> deserialized = (Map<String, Object>)JSON.deserializeUntyped(DRJson);
        //Map<String,Object> output = new Map<String,Object>();
        for (String key : deserialized.keySet())
        {    
            if(key=='relatedParty')     
            { 	
                List<Map<String, Object>> ListTmp = new List<Map<String, Object>>();
                for (Object instance : (List<Object>)deserialized.get(key))
                    ListTmp.add((Map<String, Object>)instance);
                output.put(key,ListTmp);
            }
            if(key=='resourceRef'){
                String a = JSON.serialize(deserialized.get(key));
                List<Map<String,Object>> tmp=TransformRessourceRef(a);
                output.put(key,tmp);
            }
            if(key=='serviceOrderItem'){
                List<Map<String, Object>> OrderItemList = new List<Map<String, Object>>();
                List<Map<String, Object>> tmpList = new List<Map<String, Object>>();
                for (Object instance : (List<Object>)deserialized.get(key))
                    OrderItemList.add((Map<String, Object>)instance);
                for (Map<String, Object> iter : orderItemList)
                {
                    if(iter.size()==2)
                    {
                        String a =JSON.serialize(iter);
                        tmpList.add(iter);
                    }
                        
                    else
                    {
                        String a = JSON.serialize(iter); 
                        Map<String,Object> tmp=TransformserviceRefOrValue(a);
                        tmpList.add(tmp);
                    }
                }
                output.put(key,tmpList);
            } 
            if(key=='id' || key =='action' || key=='reason'){
                output.put(key,deserialized.get(key));
            }
        }
        //String jsonMap=JSON.serialize(output);
        //System.debug(jsonMap);
        //return output;
        }
    public static List<Map<String,Object>> TransformRessourceRef(String input){
        String jsonString='{"resourceRef":';		
		//String input = '"resourceRef": [{"OFFER_TYPE": "0","VPN_GROUP": "VPN","PARAMETER_OCS": "1","VMS_PROFILE": "9991122444","DESTINATION": "506","OCSID": "ocsid","LANG": "FR","KI": "KI","IMSI": "IMSI","OLD_MSISDN": "provorigin","MSISDN": "finalm","OLD_INPROFILE": "old-profil","INPROFILE": "4490"}]';
        jsonString=jsonString+input+'}';
        Map<String, Object> deserialized = (Map<String, Object>)JSON.deserializeUntyped(jsonString);
        List<Map<String, Object>> ressourceRef = new List<Map<String, Object>>();
        for (Object instance : (List<Object>)deserialized.get('resourceRef'))
            ressourceRef.add((Map<String, Object>)instance);
		
		List<Map<String,Object>> listTmp=new List<Map<String,Object>>();
        for (String key : ressourceRef[0].keySet())
        {	Map<String,Object> mapTmp = new Map<String,Object>();
            mapTmp.put('name',key);
         	mapTmp.put('value',ressourceRef[0].get(key));
            listTmp.add(mapTmp);
             
        }
        return listTmp;
    }
    public static Map<String,Object> TransformserviceRefOrValue(String input){
        String jsonString='{"serviceOrderItem":[';
        //String input='"serviceOrderItem": [{"serviceRefOrValue": {"characteristic": {"SMS_OUT": {"code": "SMS_OUT","value": "ALLOWED" },"SMS_IN": {"code": "SMS_IN","value": "ALLOWED"}}},"action": "ADD","code": "SMS" }]';
        //String input = '"serviceOrderItem": [{"serviceRefOrValue": {"characteristic": {"SERVICE_LEVEL_OUT": {"code": "SERVICE_LEVEL_OUT","value": "SR0"},"SERVICE_LEVEL_IN": {"code": "SERVICE_LEVEL_IN","value": "ALLOWED"}}},"action": "ADD","code": "VOICE"},{"action": "ADD","code": "USSD"}]';
        ////String input ='"serviceOrderItem": [{"serviceRefOrValue": {"characteristic": {"IROAM_SERVICE_LEVEL": "code": "IROAM_SERVICE_LEVEL","value": "Roaming Voix+SMS+Data"}},"action": "AD","code": "IROAM"}}]';
        Map<String,Object> output = new Map<String,Object>();    
        jsonString=jsonString+input+']}';
        Map<String, Object> deserialized = (Map<String, Object>)JSON.deserializeUntyped(jsonString);
        List<Map<String, Object>> serviceOrderItem = new List<Map<String, Object>>();
        for (Object instance : (List<Object>)deserialized.get('serviceOrderItem'))
        serviceOrderItem.add((Map<String, Object>)instance);
        for (String key : serviceOrderItem[0].keySet())
        {
            if(Key=='serviceRefOrValue')
            {
              Map<String,Object> value=(Map<String,Object>)serviceOrderItem[0].get(key);
              Map<String,Object> value2=(Map<String,Object>)value.get('characteristic');
              List<Map<String,Object>> listTmp=new List<Map<String,Object>>();
                for(String key2 : value2.keySet())
                {	Map<String,Object> mapTmp=new Map<String,Object>();
                    Map<String,Object> value3=(Map<String,Object>)value2.get(key2);
                        for(String key3 : value3.keySet())
                            {    
                                 mapTmp.put(key3,value3.get(key3));
                            }
                   listTmp.add(mapTmp);	
                    }
               Map<String,Object> mapTmp1=new Map<String,Object>();
               mapTmp1.put('characteristic',listTmp);
               List<Map<String,Object>> listTmp1=new List<Map<String,Object>>();
               listTmp1.add(mapTmp1);
                output.put('serviceRefOrValue',listTmp1);        
        } 
        else
        {
            output.put(key,serviceOrderItem[0].get(key));
        }
        }
        return output;
    }
}