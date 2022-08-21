global with sharing class InwiB2C_CodeAuthentification implements vlocity_cmt.VlocityOpenInterface{
    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        Boolean result = true;
            
        try{
            
            if(methodName.equals('AddPWDAuthentification')){
                System.debug('Success! the method AddPWDAuthentification was called' );
                AddPWDAuthentification(inputMap, outMap, options);

            }else{
                if(methodName.equals('verify')){
                    System.debug('Success! the method verify was called' );
                    verify(inputMap, outMap, options);
                }  

            }
        } catch(Exception e){
            System.debug('An unexpected error has occurred: ' + e.getMessage());
            result = false;
                    
        }
             
        return result;
                  
   }
    global static void verify(Map<String,Object> inputMap, Map<String,Object> outMap,Map<String,Object> options) {
        String Mdn =  (String)options.get('Mdn');
        String code =  (String)options.get('code');
        Boolean match = false;
             list<InwiB2C_CodeAuthentification__c> element=[
             SELECT InwiB2C_PasswordAuthentification__c	
             FROM InwiB2C_CodeAuthentification__c
             where 
             InwiB2C_NumeroMDN__c=:Mdn 
            //  and InwiB2C_PasswordAuthentification__c=:code
             order by InwiB2C_DateCreation__c desc limit 1];
             if(element!=null && !element.isEmpty()){
                 if (code==element[0].InwiB2C_PasswordAuthentification__c){
                    match=true;
                 }
             }
            outMap.put('verification',match);
       
     }

     public static void AddPWDAuthentification(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        String Mdn =  (String)options.get('Mdn');
        Integer len = 6;
        String str = string.valueof(Math.abs(Crypto.getRandomLong()));
        String Code = str.substring(0, len);
        // String Code = String.valueof((Math.random() * 100000));
        Datetime DateOperation =  DateTime.now();
        try{

            InwiB2C_CodeAuthentification__c CodeAuth = new InwiB2C_CodeAuthentification__c ();
            CodeAuth.InwiB2C_DateCreation__c =  DateOperation;
            CodeAuth.InwiB2C_PasswordAuthentification__c = Code;
            CodeAuth.InwiB2C_NumeroMDN__c=Mdn;
            Insert CodeAuth;


        }catch(DmlException e) {System.debug('An unexpected error has occurred: ' + e.getMessage());
        
    }
    outMap.put('password',Code);
   
}



}