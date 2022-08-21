public class TestClass2{
    
    //public static String Inputjson = '{"CSOrderScor": { "offre": "","engagementDuration": 0,"handSetType": "SIM","targetOperator": "mTelecom","isBlackListed": "OUI","seniority": 0,"typeClient": "CI","isPorrtability": "ALL","AdditionelCretera": [{"Code": "","Value":"" }]}} ';
        
    public Static void Calculs_Values (Map<String,Object> Input, Map<String,Object> Output ) {       
     
     String Inputjson = '{"CSOrderScor": { "offre": "","engagementDuration": 0,"handSetType": "SIM","targetOperator": "mTelecom","isBlackListed": "OUI","seniority": 0,"typeClient": "CI","isPorrtability": "ALL","AdditionelCretera": [{"Code": "","Value":"" }]}} ';
      Map<String, Object> deserialize = (Map<String, Object>)JSON.deserializeUntyped(Inputjson);
      system.debug(deserialize);
     
       /* String CSOrderScor =       (String) deserialize.get('CSOrderScor');
          String offre =               (String) deserialize.get('offre');
          String engagementDuration =  (String) deserialize.get('engagementDuration');
          String handSetType =         (String) deserialize.get('handSetType');
          String targetOperator =      (String) deserialize.get('targetOperator');
          String isBlackListed =       (String) deserialize.get('isBlackListed');
          String seniority =           (String) deserialize.get('seniority');
          String typeClient =          (String) deserialize.get('typeClient');
          String isPorrtability =      (String) deserialize.get('isPorrtability');
    
      List<Map<String,Object>> AdditionelCretera = (List<Map<String,Object>>) deserialize.get('AdditionelCretera');
      Map<String, Object> i = new Map<String, Object> ();
      for (Object x : AdditionelCretera) {
         i = (Map<String, Object>) x;
      }
     Map<String, Object> Code = ( Map<String, Object>)i.get('Code');
     Map<String, Object> Value = ( Map<String, Object>)i.get('Value');
     
  InwiB2C_MONT_CAUT_FMSFMD__c CSOrderScorRep = [Select InwiB2C_VALUE_CAUTION__c, VALUE_FMD__c, VALUE_FMS__c from InwiB2C_MONT_CAUT_FMSFMD__c 
                    where (InwiB2C_Code_Offre__c =: offre /*and InwiB2C_DUREE_ENGAGEMENT__c =: 'engagementDuration' and 
                           InwiB2C_IS_PORTABILITY__c=: isPorrtability and InwiB2C_ISBLACKLISTED__c=: isBlackListed 
                           and InwiB2C_M_Type_Client__c =: typeClient 
                           and InwiB2C_TYPE_HANDSET__c =: handSetType )]; 
          
     Output = (Map<String, Object>) json.serialize(CSOrderScorRep);
         
      Map<String, JSONParser> parserReq =(  Map<String, JSONParser>) Output.get('CSOrderScorRep');
     
       for(String key : parserReq.keySet()) {  //return fms,fmd ,caution

  			 JSONParser node = parserReq.get(key);
        	 system.debug(node);            
		}
TestClass2.Calculs_Values ('{"CSOrderScor": { "offre": "","engagementDuration": 0,"handSetType": "SIM","targetOperator": "mTelecom","isBlackListed": "OUI","seniority": 0,"typeClient": "CI","isPorrtability": "ALL","AdditionelCretera": [{"Code": "","Value":"" }]}} ');
        



     system.debug(output);*/
    }    
}