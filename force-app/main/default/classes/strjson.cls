public class strjson {
    /*public class InwiB2C_Calcule_CAUT_FMSFMD {
     
{"CSOrderScor": { "offre": "","engagementDuration": 0,"handSetType": "SIM","targetOperator": "mTelecom","isBlackListed": "OUI","seniority": 0," typeClient": "CI","isPortability": "ALL","AdditionelCretera": [{"Code": "","Value":"" }]}} 
   /*
    * public boolean invokeMethod(String methodName, Map<String,Object> input, Map<String,Object> output, Map<String,Object> options) {        
        Boolean result = true;    
       try{
           
           if(methodName == 'LoodFromFill'){
              //output.put('result',  LoodFromFill('input'));
           }     
       } catch(Exception e){
                      
           result = false;
                   

       return true;            
  }    
    
      public void Map<String, Object> LoodFromFill(Map<String,Object>  input){	//a method for recovering the input
       
       //the fill json 
      /*  jsonString = '{“CSOrderScor”:“offre”: “”, “engagementDuration”: 0,\n'+
           ' “handSetType”: “SIM”, "targetOperator”: “mTelecom”, “isBlackListed”: “OUI”, \n'+
            '“seniority”: 0, “typeClient”: “CI”,  “isPorrtability”: “ALL”, \n'+
            ' “AdditionelCretera”: [ “Code”: “”,"Value”:“”  } ] }}' ;*/
       /*
          
       // deseria;ize the file json .
        Map<String,Object> inputt = (Map<String,Object>) JSON.deserializeUntyped(input);
        
		Map<String, Object> CSOr = (Map<String, Object>)inputt.get('CSOrderScor');
		
		List<Object> Addit = (List<Object>)CSOr.get('AdditionelCretera');
		Map<String, Object> firstItem = (Map<String, Object>)Addit.get(0);
		
       System.debug(input);
       
      // if additionelCretera it is empty.
       if( Addit == [Select Code_Cretere__c,Value_Cretere__c From inwiB2C_MONT_CAUT_CRETER__C 
                     Where Code_Cretere__c =:null
                     and Value_Cretere__c =:null]){
           List<Object> CSO =[Select InwiB2C_VALUE_CAUTION__c, VALUE_FMD__c, VALUE_FMS__c from InwiB2C_MONT_CAUT_FMSFMD__c  ];
          
           system.debug(CSO);             
        } else{
            System.debug('the object InwiB2C_MONT_CAUT_CRETER it is empty');
                       
        }
    }
    
    
    // a method for recovering the output
     public  void comptOutput(){
        // String jsonOut ='{"CSOrderScorRep":{"Caution":300,"FMS:0,"FMD":100}';
         
         Map<String,Object> Output = (Map<String,Object>) JSON.deserializeUntyped(jsonOut);

         Map<String, JSONParser> menuProperties =(  Map<String, JSONParser>) Output.get('menu');
         //System.debug(menuProperties.keySet()); // (FMS,FMD,Cuation)

		 for(String key : menuProperties.keySet()) {  //return fms,fmd ,caution

  			 JSONParser node = menuProperties.get(key);
        	 system.debug(node);
             
		}
    }
   
}*/
}/*   for (String key : input.keySet()){
              if(key == 'AdditionelCretera'){
                  if(Addit == [Select Code_Cretere__c,Value_Cretere__c From inwiB2C_MONT_CAUT_CRETER__C 
                     Where Code_Cretere__c =:null
                     and Value_Cretere__c =:null]){
                            CSOrder =[Select InwiB2C_Code_Offre__c,InwiB2C_DUREE_ENGAGEMENT__c,InwiB2C_IS_PORTABILITY__c,InwiB2C_ISBLACKLISTED__cInwiB2C_Libell_Offre__c,InwiB2C_MIN_ACTIVITY__c,InwiB2C_M_Type_Client__c,InwiB2C_TYPE_HANDSET__cFROM InwiB2C_MONT_CAUT_FMSFMD__c] ;          
                        	return CSOrder;
                     }
              }
          }
       */