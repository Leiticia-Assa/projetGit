global with sharing class InwiB2C_TransformResultLigneTemp implements vlocity_cmt.VlocityOpenInterface2 {
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
   
    public static void TransformOssJson(Map<String, Object> input,Map<String,Object> output, Map<String,Object> options){
      // String input = '{"properties":[[{"value":"212707747578","name":"mdn_tmp"},{"value":"ExpirÃ©","name":"statut"},{"value":"","name":"Date_creation"}],[{"value":"212707727474","name":"mdn_tmp"},{"value":"ExpirÃ©","name":"statut"},{"value":"","name":"Date_creation"}],[{"value":"212707727473","name":"mdn_tmp"},{"value":"ExpirÃ©","name":"statut"},{"value":"","name":"Date_creation"}]],"mdn":"212648027821"}';
        		//jsonString=jsonString+input+'}';  

Map<String, Object> deserialize = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(input));
List<Object> properties = (list<Object>)JSON.deserializeUntyped(JSON.serialize(deserialize.get('properties')));
Set<Map<String,Object>> l=new Set<Map<String,Object>>();
for (Object tmp : properties)
	{
        String c = JSON.serialize(tmp);
        String mapJson = '{"list":['+c.substring( 1, c.length() - 1 )+']}';
        Map<String,Object> b = (Map<String,Object>)JSON.deserializeUntyped(mapJson);
        List<Map<String, Object>> listtmp = new List<Map<String, Object>>();
        for (Object instance : (List<Object>)b.get('list'))
        listtmp.add((Map<String, Object>)instance);
        Map<String, String> m=new Map<String, String>();
        for (Map<String, Object> j : listtmp)
            {
                for(String keyJ : j.keySet())
                {
                    m.put(String.valueOf(j.get('name')),String.valueOf(j.get('value')));
                }
            }
        l.add(m);
    }
output.put('properties',l);
//output.put('mdn',deserialize.get('mdn'));
  //      String jsonMap=JSON.serialize(output);
//        System.debug(jsonMap);
    }
}