global with sharing  class InwiB2C_ClearFieldValue implements vlocity_cmt.VlocityOpenInterface{

    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        Boolean result = true;
            if(methodName.equals('resetValue'))
            resetValue(inputMap, outMap, options);        
            else {} 
        return result;
   }

    public static void resetValue(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        System.debug('in resetValue');
        System.debug('inputMap::');
        System.debug(inputMap);

        String theid = (String) inputMap.get('theid');
        System.debug('theid::'+theid);


        String fields='';
        List<Object>  fieldsList = (List<Object>)inputMap.get('fieldsList');
        try {
            for(Object fldStr : fieldsList){
                System.debug('fldStr::'+fldStr);
            }

            for(Object fldStr : fieldsList)
                fields = fields +' ,' + (String)fldStr; 
            System.debug('final str::'+fields);

        } catch (Exception e) {
            System.debug('e::'+e);

        }

        Id entityId = (Id)theid;
        System.debug('here5');

        Schema.sObjectType entityType = entityId.getSObjectType();

        try {

                System.debug('fields: '+fields);
                System.debug('query: '+'SELECT Id'+fields+' FROM '+entityType+' WHERE Id=:theid');

                sobject  theObject = Database.query('SELECT Id'+fields+' FROM '+entityType+' WHERE Id=:theid'); 
                for(Object fld : fieldsList)
                    theObject.put((String)fld,null); 
            update theObject;
        } catch (Exception e) {
            System.debug('error:: '+e);

        } finally {}
        
    }
}