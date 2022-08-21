global with sharing class InwiB2C_TransformJsonFraisMigration implements vlocity_cmt.VlocityOpenInterface {
     global static boolean invokeMethod(String methodName, Map<String,Object> input, Map<String,Object> output, Map<String,Object> options) {        
        Boolean result = true;    
       try{
           
           if(methodName == 'TransformJson'){
              TransformJson(input, output, options);
           }     
       } catch(Exception e){
                      
           result = false;
                   
       }     
       return true;            
  }
    public static void TransformJson(Map<String, Object> deserialized,Map<String,Object> output, Map<String,Object> options){
       // Map<String,Object> output = new Map<String,Object>();
		Map<String,Object> output1 = new Map<String,Object>();
		Map<String,Object> fees = new Map<String,Object>();
		List<Object> feeslist = new List<Object>();
		List<Object> parametrFinal = new List<Object>();
		//String jsonString='{"payment":{"type":"FEES","fees":[{"serviceCode":"CCMFR","description":"Modification de forfait","credit":"true","parameter":[{"1":{"value":"82194","name":"Forfait Illimité inwi 11h+11Go"},"2":{"value":"86906","name":"Forfait 4H + 2Go"},"3":{"value":"OUI","name":"FMFPENALITE_B"}}]}],"order":{"devis":"true","reasoncode":"4","offerCode":{"code":"MOBO2"},"captureID":"a4k3M0000008jvtQAA","billingAccountID":"0013M00000zwUTTQA2"}}}';
		 //deserialized = (Map<String, Object>)JSON.deserializeUntyped(jsonString);
    		//system.debug('Value=> '+deserialized.get('payment'));
		String value=JSON.serialize(deserialized.get('payment'));
		Map<String, Object> deserialized1 = (Map<String, Object>)JSON.deserializeUntyped(value);
		For(String key : deserialized1.keySet()){
    		if(key=='fees'){
        		String value2=JSON.serialize(deserialized1.get(key));
        		List<Map<String, Object>> ListTmp = new List<Map<String, Object>>();
        		for (Object instance : (List<Object>)deserialized1.get(key))
                ListTmp.add((Map<String, Object>)instance);
        		//system.debug(ListTmp);
        		for (Map<String, Object> a : ListTmp)
            		For(String key2 : a.keySet()){
            			if(key2 == 'parameter'){
                			String parametr = JSON.serialize(a.get(key2));
                			List<Map<String, Object>> ListTmp1 = new List<Map<String, Object>>();
        					for (Object instance : (List<Object>)a.get(key2))
                    		ListTmp1.add((Map<String, Object>)instance);
                			for (Map<String, Object> b : ListTmp1)
                    		For(String key3 : b.keySet())
                    		parametrFinal.add(b.get(key3));
                    		//system.debug(parametrFinal);
                 			fees.put(key2,parametrFinal);
            			}
                		else
                    		fees.put(key2,a.get(key2));
            		}
        		feeslist.add(fees);
      			output1.put(key,feeslist);
    		}
    		else
		        output1.put(key,deserialized1.get(key));

		}
		output.put('payment',output1);
        //String jsonMap=JSON.serialize(output);
        //System.debug(jsonMap);





    }


}