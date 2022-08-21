global with sharing  class InwiB2C_SubmitForApprovalCustom  implements vlocity_cmt.VlocityOpenInterface {
    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        Boolean result = true;
        try{
            if(methodName.equals('submitApproval'))
            submitApproval(inputMap, outMap, options);        
            else{}
        }
            catch(Exception e){
            result = false;
        }
        return result;
    }


    public static void submitApproval(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options){

        try {
            String recordId = (String) inputMap.get('recordId');
            System.debug('recordId: ' + recordId);
        
                
            // Create an approval request for the account
            Approval.ProcessSubmitRequest req1 = 
                new Approval.ProcessSubmitRequest();
            req1.setComments('Soumission de la demande d\'approbation par '+ UserInfo.getName());
            req1.setObjectId(recordId);
            
            // Submit on behalf of a specific submitter
            req1.setSubmitterId(UserInfo.getUserId()); 
                    
            // Submit the record to specific process and skip the criteria evaluation
            req1.setProcessDefinitionNameOrId('InwiB2C_Demande_Identification');
            req1.setSkipEntryCriteria(true);
            
            // Submit the approval request for the account
            Approval.ProcessResult result = Approval.process(req1);
    
            System.Debug('result: '+result);
    
        } catch (Exception e) {
            System.Debug('ExceptionError: '+e);

        }
    } 

}