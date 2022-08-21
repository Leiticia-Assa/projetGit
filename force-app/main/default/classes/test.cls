public class test {
    
 /*  String jsonInput = '{ \n ' + 
         ' “CSOrderScor”: ' +  
           ' {  “offre”: “”, ' +
              ' “engagementDuration”: 0, ' +
              '  “handSetType”: “SIM”, ' +
              ' “targetOperator”: “mTelecom”, ' +
              '  “isBlackListed”: “OUI”, ' +
              ' “seniority”: 0, ' +
              ' “typeClient”: “CI”, ' +  
              '  “isPorrtability”: “ALL”, \n ' +
              '  “AdditionelCretera”: [ ' +
                  ' {  “Code”: “”, ' +                       
                     ' “Value”:“”  } ] \n ' +               
          ' } ' +
' }' ;  
        
    Map<String, Object> m = (Map<String, Object>)
      JSON.deserializeUntyped(jsonInput); 
    */
    
/*   String requestBodyString = '{"records": [{"attributes":{"referenceId":"ref1", "type":"Account"}, "industry":"Banking", "name":"SampleAccount1", "numberOfEmployees":100, "phone":1111111111, "website":"www.salesforce1.com"}]}';

Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(requestBodyString);
    for(Object obj: (List<Object>)params.get('records')) {
    // the result of obj is JSON, so convert it to map
        Map<String, Object> objMap = (Map<String, Object>) obj;
        String industry = (String) objMap.get('industry');
        System.debug(industry);
    }
    */
}