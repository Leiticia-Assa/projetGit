public without sharing class INWIB2CJSONAttributeUtilities {

    public static String ATTRIBUTE_CODE_TO_VALUE        = 'attributeCodeToValue';
    public static String ATTRIBUTE_CODE_TO_DISPLAY_NAME = 'attributeCodeToDisplayName';
    public static final String ATTRIBUTE_UNIQUE_CODE    = 'attributeuniquecode__c';
    public static final String ATTRIBUTE_RUN_TIME_INFO  = 'attributeRunTimeInfo';

    public static Map<String,Object> getAttributeValuesFromJSON(String JSONAttr){
        List<Vlocity_cmt.JSONAttributeSupport.JSONAttributeActionRequest> actionRequestsList = new List<Vlocity_cmt.JSONAttributeSupport.JSONAttributeActionRequest>();
        Map<String, object> inputMap = new Map<String, object>(); 
        Map<String, object> outputMap = new Map<String, object>(); 
        Map<String, object> optionsMap = new Map<String, object>();
        inputMap.put('JSONString', JSONAttr);
        Vlocity_cmt.JSONAttributeSupport jsonSupport = new Vlocity_cmt.JSONAttributeSupport();
        jsonSupport.invokeMethod('getAttributeValuesFromJSON', inputMap, outputMap, optionsMap);
        Map<String,Object> modifiedJSON = (Map<String,Object>)outputMap.get(ATTRIBUTE_CODE_TO_VALUE);
        //System.debug('getAttributeValuesFromJSON >>> ' + JSON.serializePretty(modifiedJSON));
        return modifiedJSON;
    }
    /** @Method : getAttributeValueFromJSON
	 ** @params : JSONAttribute, AttributeUniqueCode
	 ** @return : AttributeValue
	 ** @Description : Get Attribute value from JSONAttribute by attribute code
	 **/ 
    public static String getAttributeValueFromJSON(String JSONAttr, String AttributeCode){
        Map<String,Object> attributeValuesList = getAttributeValuesFromJSON(JSONAttr);
        //System.debug('getAttributeValueFromJSON >>> ' + attributeValuesList.get(AttributeCode));
        return (String) attributeValuesList.get(AttributeCode);
        } 
    
        public static Date getAttributeValueFromJSONDate(String JSONAttr, String AttributeCode){
        Map<String,Object> attributeValuesList = getAttributeValuesFromJSON(JSONAttr);
        //System.debug('getAttributeValueFromJSON >>> ' + attributeValuesList.get(AttributeCode));
        return (Date) attributeValuesList.get(AttributeCode);
        } 
    /** @Method : getAttributeDisplayNamesFromJSON
	 ** @params : JSONAttribute
	 ** @return : Map<attributeuniquecode__c,AttributeDisplayName>
	 ** @Description : Get Attribute Displays Names from JSONAttribute
	 **/
    public static Map<String,Object> getAttributeDisplayNamesFromJSON(String JSONAttr){
        List<Vlocity_cmt.JSONAttributeSupport.JSONAttributeActionRequest> actionRequestsList = new List<Vlocity_cmt.JSONAttributeSupport.JSONAttributeActionRequest>();
        Map<String, object> inputMap = new Map<String, object>(); 
        Map<String, object> outputMap = new Map<String, object>(); 
        Map<String, object> optionsMap = new Map<String, object>();
        inputMap.put('JSONString', JSONAttr);
        Vlocity_cmt.JSONAttributeSupport jsonSupport = new Vlocity_cmt.JSONAttributeSupport();
        jsonSupport.invokeMethod('getAttributeValuesFromJSON', inputMap, outputMap, optionsMap);
        Map<String,Object> modifiedJSON = (Map<String,Object>)outputMap.get(ATTRIBUTE_CODE_TO_DISPLAY_NAME);
        //System.debug('getAttributeDisplayNamesFromJSON >>> ' + JSON.serializePretty(modifiedJSON));
		return modifiedJSON;
    }

    public static String updateAttributeValueFromJSON(String JSONAttr, String AttributeCode, String AttributeValue){
        List<Vlocity_cmt.JSONAttributeSupport.JSONAttributeActionRequest> actionRequestsList = new List<Vlocity_cmt.JSONAttributeSupport.JSONAttributeActionRequest>();
        actionRequestsList.add(new Vlocity_cmt.JSONAttributeSupport.JSONAttributeActionRequest(AttributeCode, Vlocity_cmt.JSONAttributeSupport.ActionType.ASSIGN, AttributeValue));
    
        Map<String, object> inputMap = new Map<String, object>();
        Map<String, object> outputMap = new Map<String, object>();
        Map<String, object> optionsMap = new Map<String, object>();
        
        inputMap.put('objectSO', null);
        inputMap.put('runTimeAttributesJSON', JSONAttr); // run time attribute value
        inputMap.put('originalAttributesJSON', JSONAttr); // design time (master) attribute
        inputMap.put('JSONAttributeActionRequestList', actionRequestsList); // attributes and values to update
 
        vlocity_cmt.JSONAttributeSupport jsonSupport = new vlocity_cmt.JSONAttributeSupport();
        jsonSupport.invokeMethod('applyAttributeActions', inputMap, outputMap, optionsMap);
        return (String)outputMap.get('modifiedJSON'); 
        
    }

   
    
}