global with sharing  class inwiB2C_UserPickListManagementforOS    implements vlocity_cmt.VlocityOpenInterface {


        global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
                
            Boolean result = true;
                
            try{
                
                if(methodName.equals('getRecordTypeList')){
                    getRecordTypeList(inputMap, outMap, options);
                
                 // your implementation, use outMap to send response back to OmniScript                                                                  
                
                }else if(methodName.equals('getDefaultType')){
                    getDefaultType(inputMap, outMap, options);
                
                // your implementation, use outMap to send response back to OmniScript                   
                
                }                            
                
            } catch(Exception e){
                           
                result = false;
                        
            }
                 
            return result;
                      
       }
    
    
        public static void getRecordTypeList(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
                
            Schema.DescribeSObjectResult caseOject = case.SObjectType.getDescribe();
            List<Schema.RecordTypeInfo> recordTypeList = caseOject.getRecordTypeInfos();

            List < Map < String, String >> resultRecordTypeList = new List < Map < String, String >> ();

            for (Schema.RecordTypeInfo recordType : recordTypeList){

                System.debug(recordType.developerName);

                if (recordType.available && recordType.active && 
                !recordType.developerName.equals('Requete_interne') &&
                !recordType.developerName.equals('InwiB2C_Fraude') &&
                !recordType.developerName.equals('MobilePhoneCase') &&
                !recordType.developerName.equals('Service') &&
                 !recordType.developerName.equals('Master')&&
                 !recordType.developerName.equals('Principal')){
                    Map<String,String> resultRecordType = new  Map<String,String>();

                    resultRecordType.put('name', recordType.developerName);
                    resultRecordType.put('value', recordType.name);

                    resultRecordTypeList.add(resultRecordType);
                }
            }

            outMap.put('options', resultRecordTypeList);

            
        }

        public static void getDefaultType(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
                
            
            String recordTypeValue = (String)inputMap.get('recordTypeValue');

            String typeValue = '';

            switch on recordTypeValue {
                when 'InwiB2C_Assistance'{
                    typeValue = 'Inwib2c_Assistance';
                }
               
                when 'InwiB2C_HelpDesk'{
                    typeValue = 'Inwib2c_HelpDesk';                    
                }
                when 'InwiB2C_Information'{
                    typeValue = 'Inwib2c_Information';                    
                }
                when 'InwiB2C_Modification'{
                    typeValue = 'Inwib2c_Modification';                    
                }
                when 'InwiB2C_Reclamation'{
                    typeValue = 'Inwib2c_Reclamation';                    
                }
                when 'InwiB2C_RECLAMATION_VIP'{
                    typeValue = 'Inwib2c_RECLAMATION_VIP';                    
                }
                when 'InwiB2C_Retention'{
                    typeValue = 'Inwib2c_Retention';                    
                }
                when 'InwiB2C_Televente'{
                    typeValue = 'Inwib2c_Televente';                   
                }
            }

            outMap.put('typeValue', typeValue);     
        }



      
    }