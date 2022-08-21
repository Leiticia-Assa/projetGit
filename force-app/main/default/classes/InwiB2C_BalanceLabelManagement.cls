global with sharing class InwiB2C_BalanceLabelManagement implements vlocity_cmt.VlocityOpenInterface{

    //global CustomClassName() {}
			
    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
			
        Boolean result = true;
			
        try{
			
            if(methodName.equals('getBalanceWithLabels')){
                getBalanceWithLabels(inputMap, outMap, options);
			
             // your implementation, use outMap to send response back to OmniScript                                                                  
			
            }                          
			
        } catch(Exception e){
			           
            result = false;
			        
        }
			 
        return result;
			      
   }

   global Boolean getBalanceWithLabels(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options){

    System.debug('In getBalanceWithLabels Class');
    List<Object> consoList = (List<Object>) inputMap.get('consoList');
    List<InwiB2C_Balance_Labels__c> listBalanceLabels= [SELECT Id, Name, Label_Id__c FROM InwiB2C_Balance_Labels__c ];

    //System.debug('listBalanceLabels size: ' + listBalanceLabels.size());

    Map<String, String> balanceLabelsMap = new  Map<String, String>();
    Map<String, Object> balanceMap = new  Map<String, Object>();

    for ( InwiB2C_Balance_Labels__c balanceLabel: listBalanceLabels){

        balanceLabelsMap.put(balanceLabel.Label_Id__c, balanceLabel.Name);
    }
    for ( Integer i = 0, j = 0; i < consoList.size() ; i++ ) {

        Map<String,Object> conso =  (Map<String,Object>) consoList[i];
      String M_LISTEBAL = (String) conso.get('M_LISTEBAL');
        if (M_LISTEBAL != null) {

            List<String> listBal = M_LISTEBAL.split(';');

            List<Object> bals = new  List<Object>();

            for (String bal : listBal ){

                
                if (bal.length() > 1){
                    Map<String,Object> balNode = new  Map<String,Object>();

                    List<String>  balItems = bal.split(':');

                    String balId = balItems[0];
                    String balAmount = balItems[1];
                    String balLabel = balanceLabelsMap.get(balId);

                // System.debug('balId: ' + balId + ' balLabel :' + balLabel);

                    balNode.put('balId', balId);
                    balNode.put('balAmount', balAmount);
                    balNode.put('balLabel', balLabel);

                    bals.add(balNode);

                    // Add the balance to the sum
                      system.debug(balId +'balId');
                      system.debug(balanceMap +'balanceMap');
                      system.debug(balanceMap.get(balId) +'balanceMapID');

                    if (balanceMap.containsKey(balId)){
                    system.debug(balId +'balId in if');

                        Map<String,Object> balsumNode =  (Map<String,Object>) balanceMap.get(balId);

                        String balSumAmount = (String) balsumNode.get('balAmount');  
                        
                        try {
                            Decimal balSumAmountNumber = decimal.valueOf(balSumAmount);
                            Decimal balAmountNumber = decimal.valueOf(balAmount);

                            Decimal balCount = (Decimal) balsumNode.get('balCount');

                            balSumAmountNumber = balSumAmountNumber + balAmountNumber;

                            balsumNode.remove('balAmount');
                            balsumNode.remove('balCount');
                            balsumNode.put('balAmount', String.valueOf(balSumAmountNumber));
                            balsumNode.put('balCount', balCount+1);

                        }catch (Exception e){

                            System.debug('Exception type caught: ' + e.getTypeName());    
                            System.debug('Message: ' + e.getMessage());    
                            System.debug('Cause: ' + e.getCause());    // returns null
                            System.debug('Line number: ' + e.getLineNumber());    
                            System.debug('Stack trace: ' + e.getStackTraceString()); 

                        }

                    }else {
                        Map<String,Object> balsumNode = new  Map<String,Object>();
                        balsumNode.put('balId', balId);
                        balsumNode.put('balAmount', balAmount);
                        balsumNode.put('balLabel', balLabel);
                        balsumNode.put('balCount', 0);
                        balanceMap.put(balId,balsumNode );

                    }
                    

                    

                }
                
            }

            conso.remove('M_LISTEBAL');

            conso.put('M_LISTEBAL', bals);


        }

        String GPRS_VOLUME = (String) conso.get('GPRS_VOLUME');
        if (GPRS_VOLUME == null || GPRS_VOLUME.equals('')){
            GPRS_VOLUME = '0';
            conso.put('GPRS_VOLUME', GPRS_VOLUME);
        }


    }

    

    String resultConso = JSON.serialize(consoList);


    List <Object> balanceList = balanceMap.values();

    outMap.put('consoString', resultConso);
    outMap.put('balanceList', balanceMap.values());
    


    return true;

   }
			
}