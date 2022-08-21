global with sharing class MDNFileHandler  implements vlocity_cmt.VlocityOpenInterface{
    String errorsValidation='';
    public Boolean InvokeMethod(String methodName,Map<String,Object> input,Map<String,Object> output, Map<String,Object> options) {   
        Boolean result = true;
        try
        {
            system.debug('HELLO');
            if(methodName == 'ReadMDNFile'){
                output.put('List', ReadMDNFile(input));
            }
         }
        catch(Exception e)
       	{
           System.debug('MDNFileHandler:invokeMethod -> exception: '+e);
           result = false;
       	}
       
       return result;
    }

    private string ReadMDNFile(Map<String, Object> input){
        Id contentDocumentId = (Id)input.get('contentDocumentId');
         system.debug('FUNCTION IN: '+contentDocumentId);
       // Map<String,List<MDN>> mapFile = new Map<String,List<MDN>>();
        List<MDN> listPorta = new List<MDN>();
        if(contentDocumentId != null) {
            ContentVersion contentVersionObj = [SELECT Id, Title, VersionData FROM ContentVersion WHERE ContentDocumentId =:contentDocumentId];
            String data = Blob.valueOf(contentVersionObj.VersionData.toString()).toString();
             system.debug('DATA: '+data);
            list<String> recordsList = data.split('\n');
            Boolean hasError = false;
            Map<String, String> mdns ;
            for(Integer i = 1; i < recordsList.size(); i++){
                 system.debug('Record: '+recordsList[i]);
                MDN mdn = new MDN();
               
                mdn.mdn =recordsList[i];
                
                listPorta.add(mdn);
            }
        }   
                  return JSON.serialize(listPorta);
    }

    public class MDN
    {
        public string mdn;
    }
}