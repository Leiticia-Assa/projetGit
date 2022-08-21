global class  inwiB2C_Deferred_Migration implements vlocity_cmt.VlocityOpenInterface {
   global boolean invokeMethod(String methodName, Map<String,Object> input, Map<String,Object> output, Map<String,Object> options) {        
        Boolean result = true;    
      
           
          
              output.put('result',  TransformJson(input));
           
       return true;            
  } 

 Map<String, Object> TransformJson(Map<String, Object> input)
  {
       Object cycledeFacturation;
      boolean isIN = false;
      Decimal daysBefore;
      Integer intConvertedValue;
      daysBefore = [Select MasterLabel,label,inwiB2C_DaysBefore__c from inwiB2C_TimeBeforeCycle__mdt limit 1].inwiB2C_DaysBefore__c;
      intConvertedValue = daysBefore.intValue();
       for (String key : input.keySet())
    		{             
                if(key=='Cycle')     
                { 
       cycledeFacturation = input.get('Cycle');
                   
                }
               
            }
      Integer cycledeFacturation1 =Integer.ValueOf(cycledeFacturation);
      String messageErreur = 'La migration est autorisée '+intConvertedValue+' jours avant le cycle de facturation qui est: '+cycledeFacturation1;
      

      Date todayDate = system.today(); 
       // Date todayDate = Date.newInstance(2022,03,30);
      for (integer i = 0 ; i<=intConvertedValue; i++){
         Date migrationDate = todayDate.addDays(i);
          
         Integer Day = migrationDate.Day();
 
          if(Day == cycledeFacturation1 ){
              isIN = true;
          }
      }
       
      if(isIN == true){
        input.put('status','1');
          
      }else
      {
          input.put('status','0');
           input.put('error',messageErreur);
      }
      return input;
        }
       


}