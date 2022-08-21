public class InwiB2C_Calcule_CAUT_FMSFMD {
      
      public static void Calculs_Values( Map<String,object> input,List<Object> Output) {
       
        // Map<String,object> input =new Map<String,object>(); 
      //List<Object> Output =new List<Object>();   
      	//String js = '{"CSOrderScor": { "offre": "","engagementDuration": 0,"handSetType": "SIM","targetOperator": "mTelecom","isBlackListed": "OUI","seniority": 0,"typeClient": "CI","isPorrtability": "ALL","AdditionelCretera": [{"Code": "","Value":"" }]}} ';
        
         Map<String, Object> inputt = (Map<String, Object>)JSON.deserializeUntyped(json.serialize(input));
          //Map<String, Object> inputt = (Map<String, Object>)JSON.deserializeUntyped(input);
          System.debug(inputt);
          
          //input =(Map<String,object>) JSON.deserializeUntyped(js); 
          Map<String, Object> CSOrderScor =  (Map<String, Object>) inputt.get('CSOrderScor');
           //System.debug(CSOrderScor);
           
          String offer =(String) CSOrderScor.get('offre');
           // System.debug(offer); 
          Decimal engagementDuration =  (Decimal) CSOrderScor.get('engagementDuration');
          System.debug(engagementDuration);
          String handSetType =  (String) CSOrderScor.get('handSetType');
          System.debug(handSetType); 
          String targetOperator =  (String) CSOrderScor.get('targetOperator');
           System.debug(targetOperator);
          String isBlackListed =  (String) CSOrderScor.get('isBlackListed');
           System.debug(isBlackListed);
         Decimal seniority =  (Decimal) CSOrderScor.get('seniority');
         System.debug(seniority);
         String typeClient =  (String) CSOrderScor.get('typeClient');
 		 System.debug(typeClient);
         String isPorrtability =  (String) CSOrderScor.get('isPorrtability');
         System.debug(isPorrtability);
         List<Object> AdditionelCretera = (List<Object>) CSOrderScor.get('AdditionelCretera');
         for(Object inidividualEntries : AdditionelCretera){
             Map<String,Object> ind = (Map<String,Object> )inidividualEntries;
            
             String Code = ( String)ind.get('Code');
             String Value = ( String)ind.get('Value');
             system.debug(Code);
             system.debug(Value);
         }
             
          List<object> CSOrderScorRep = [Select InwiB2C_VALUE_CAUTION__c, VALUE_FMD__c, VALUE_FMS__c from InwiB2C_MONT_CAUT_FMSFMD__c 
                                     where (InwiB2C_Code_Offre__c = : offer
                                           and InwiB2C_DUREE_ENGAGEMENT__c =: engagementDuration 
                                           and InwiB2C_IS_PORTABILITY__c=: isPorrtability
                                           and InwiB2C_ISBLACKLISTED__c=: isBlackListed 
                                           and  InwiB2C_M_Type_Client__c =: typeClient 
                                           and InwiB2C_TYPE_HANDSET__c =: handSetType ) ]; 
          
          List<Object> addi =[select Code_Cretere__c,InwiB2C_MONT_CAUT_FMSFMD__c,Value_Cretere__c
                              from InwiB2C_MONT_CAUT_CRETER__c
                           
                              // Where (Code_Cretere__c =: Code)
                             ];
         
          system.debug('CSOrderScorRep'+CSOrderScorRep);
          String result =Json.serialize(CSOrderScorRep);
          system.debug('result'+result);
         // jsonparser.Get(result);
          Output = (List<Object>)json.deserializeUntyped(result);
          system.debug(Output);    
        }
}