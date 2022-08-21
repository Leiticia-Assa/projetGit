global with sharing  class InwiB2C_Test implements vlocity_cmt.VlocityOpenInterface {
     
            global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
                    
               if (methodName == 'CheckRib') {
                    outMap.put('result', CheckRib(inputMap));
                }
                     
                return true;
            }
                
                Map<String,Object> CheckRib(Map<String,Object> inputMap) {
                       String cle = (String) inputMap.get ('cle');
                       String rib = (String) inputMap.get ('rib');
                      system.debug('rib'+rib);
                      system.debug('clé'+cle);
                      // integer ribvalue = integer.valueof(rib);
                       integer clevalue = integer.valueof(cle);
                     Long ribvalue = Long.valueof(rib);
                     long var=97;
                   Long result1;
                   result1= math.mod( ribvalue, var);
                            //   Decimal  result1=ribvalue mod 97;
                               // system.debug('res1'+result1);
                              String result;
                              Long  resultfinale=97-result1;
                              system.debug('res1'+resultfinale);
                    if (resultfinale==clevalue){
                      system.debug('clé valide');
                         result='rib valide';
    
                    }
                    else                     
                        result='rib invalide';
                        system.debug('clé invalide');
                    
                    
           inputMap.put('result',result);
           return inputMap;
    
                }
    }