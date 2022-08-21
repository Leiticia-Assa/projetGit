global with sharing  class inwiB2C_NotesManagement  implements vlocity_cmt.VlocityOpenInterface {
    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        Boolean result = true;
        try{
            if(methodName.equals('getNotes'))
                getNotes(inputMap, outMap, options);        
            else if(methodName.equals('createNote'))
                createNote(inputMap, outMap, options); 
            else{}
        }
         catch(Exception e){
            result = false;
        }
        return result;
   }

   

   
    public static void getNotes(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {

        String recordId = (String) inputMap.get('recordId');
        System.debug('recordId: ' + recordId);
    
/*
        Id theRecordId;


        if(recordId.equals('')) theRecordId = null;
        else theRecordId = Id.valueOf(recordId);

*/

        Set<Id> contactIds= new Set<Id>(); 
        contactIds.add(recordId); //include all the contact ids for which you need to retrieve content note
        Set<Id> contentDocumentIds = new Set<Id>();
        //get all contentdocumentids so that you can query on contentnote
        for(ContentDocumentLink conDoc : [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId IN :contactIds]){
            contentDocumentIds.add(conDoc.ContentDocumentId);
        }

    
        List<ContentNote> Notes = [SELECT Id, Title, TextPreview,CreatedById,CreatedDate from ContentNote where Id In: contentDocumentIds ORDER BY CreatedDate DESC ];
        


        
        List<Map<String, Object>> formatedNotes = new List<Map<String, Object>>();

        
        
        try {
            for(ContentNote cn : Notes){
                Map<String, Object> temp = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(cn));


                
                for(User conDoc : [SELECT Name FROM User WHERE Id=:cn.CreatedById])
                    temp.put('CreatedBy' , conDoc.Name);
                
                temp.put('CreatedDate' , cn.CreatedDate.formatGMT('yyyy-MM-dd HH:mm:ss'));

                formatedNotes.add(temp);

            }   
        } catch (Exception e) {
            System.debug('Exception: ' + e);
        }
        


          System.debug('formatedNotes: ' + formatedNotes);

        /*
        for(Object cn : Notes){
              system.debug(cn);
            }
*/


        outMap.put('AllNotes', formatedNotes);

    }

   
    public static void createNote(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        
/*
        Set<Id> contactIds= new Set<Id>(); 
        contactIds.add(recordId); //include all the contact ids for which you need to retrieve content note
        Set<Id> contentDocumentIds = new Set<Id>();
        //get all contentdocumentids so that you can query on contentnote
        for(ContentDocumentLink conDoc : [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId IN :contactIds]){
            contentDocumentIds.add(conDoc.ContentDocumentId);
        }

    
        List<ContentNote> Notes = [SELECT Id, Title, TextPreview,CreatedById,CreatedDate from ContentNote where Id In: contentDocumentIds];
        */

        String recordId = (String) inputMap.get('recordId');
        String title = (String) inputMap.get('title');
        String body = (String) inputMap.get('body');
        

        ContentNote cn = new ContentNote(
            Title=title,
            Content =Blob.valueOf(body.escapeHTML4())
        );
        insert cn;

        Id idContentNote =  cn.Id;
        system.debug('idContentNote: '+idContentNote);

        ContentDocumentLink cdl = new ContentDocumentLink(
            LinkedEntityId=recordId,
            ContentDocumentId=idContentNote
        );
        insert cdl;

        Id idContentDocumentLink =  cdl.Id;
        system.debug('idContentDocumentLink: '+idContentDocumentLink);


        

       // outMap.put('AllNotes', cdl.);




    }

  
}