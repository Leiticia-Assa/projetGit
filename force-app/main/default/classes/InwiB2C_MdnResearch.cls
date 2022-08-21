global with sharing   class InwiB2C_MdnResearch  implements vlocity_cmt.VlocityOpenInterface{
    
    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
			
        Boolean result = true;
			
        try{
			
            if(methodName.equals('getMdnList')){
                getMdnList(inputMap, outMap, options);                                                          
			
            }else {
			
            // your implementation, use outMap to send response back to OmniScript                   
			
            }                              
			
        } catch(Exception e){result = false;
			        
        }
			 
        return result;
			      
   }

   public static void getMdnList(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        System.debug(JSON.serialize(inputMap));

        System.debug('in getMdnList');

        String mdnType = (String) inputMap.get('mdnType');
        String offerType = (String) inputMap.get('offerType');
        String category = (String) inputMap.get('category');
        String mdn = (String) inputMap.get('mdn');
        String lockToken = (String) inputMap.get('lockToken');
        Integer nbrResult = (Integer) inputMap.get('nbrResult');
        String body='{ "mdnType":"'+mdnType+'", "offerType":"'+offerType+'", "category":"'+category+'", "mdn":"'+mdn+'","lockToken":"'+lockToken+'","nbrResult": '+nbrResult+' }';

        try{
            Http http = new Http();
            HttpRequest request = new HttpRequest();


            request.setEndpoint('callout:SOA_URL/inwi-api/resourcePoolManagement/v1/msisdn/search');
            request.setMethod('POST');
            request.setHeader('Content-Type','application/json;charset=UTF-8');
            request.setHeader('canal', 'SF');
            request.setHeader('user', UserInfo.getName());
            request.setHeader('uuid', INWIB2C_GenerateTransactionCode.generate());            
            request.setBody(body);
            request.setTimeout(60000);
            HttpResponse response = http.send(request);
            // Parse the JSON response
            if (response.getStatusCode() != 200) {
                System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
                    
                
                outMap.put('errorCode',response.getStatusCode() ) ;
                outMap.put('errorName',response.getStatus() ) ;

                outMap.remove('error');
                outMap.put('error','KO' ) ;

                    
                    
                    
            } else {
                System.debug('OK: '+ response + response.getBodyAsBlob());
                
                outMap.put('numberslist', response.getBodyAsBlob() ) ;
            
            }

        }catch (Exception e){
            outMap.put('errorCode',e.getTypeName() ) ; outMap.put('errorName',e.getMessage() ) ;

            outMap.remove('error'); outMap.put('error','KO' ) ;

        }
        

   }   

}