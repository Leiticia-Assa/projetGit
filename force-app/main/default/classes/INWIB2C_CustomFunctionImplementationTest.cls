@isTest
public class INWIB2C_CustomFunctionImplementationTest {
		public static String JSON_ATTRIBUTE = '{"INWI_ACAT_IOT":[{"$$AttributeDefinitionStart$$":null,"objectid__c":"01t0D000002iZfAQAU","attributeid__c":"a0P0D0000014noaUAA","attributecategoryid__c":"a0O0D000002DZ0aUAG","categorycode__c":"INWI_ACAT_IOT","categoryname__c":"IOT","attributeuniquecode__c":"INWI_ATT_RT_DATA_IOT","attributeconfigurable__c":true,"attributedisplaysequence__c":"20","attributefilterable__c":false,"attributecloneable__c":true,"isactive__c":true,"attributedisplayname__c":"Data","displaysequence__c":"null","categorydisplaysequence__c":50,"customconfiguitemplate__c":null,"formatmask__c":null,"hasrule__c":true,"isconfigurable__c":true,"ishidden__c":false,"valueinnumber__c":null,"objecttype__c":"Product2","querycode__c":null,"isreadonly__c":true,"isnottranslatable__c":false,"isquerydriven__c":false,"querylabel__c":null,"id":"a0M0D000000nBpgUAE","isrequired__c":true,"rulemessage__c":null,"uidisplaytype__c":"Dropdown","value__c":null,"valuedatatype__c":"Picklist","valuedescription__c":null,"attributegrouptype__c":null,"attributeRunTimeInfo":{"dataType":"Picklist","uiDisplayType":"Dropdown","values":[{"displayText":"15Go","id":"ebc92e17-644d-fed7-48af-22ff14952d1e","sequence":10,"value":"15Go"},{"displayText":"30Go","id":"203aab93-e795-c07b-9353-c9fc2ee2f988","sequence":20,"value":"30Go"},{"displayText":"60Go","id":"fc4ff531-f98f-02dd-9b37-c8dca3112f7c","sequence":30,"value":"60Go"},{"displayText":"Illimitée","id":"c2f5e438-439e-44f1-cbc2-a91a8556cb47","sequence":40,"value":"Illimitée"},{"displayText":"512Mo","id":"23cc9add-b7d1-6022-8216-62b615efe841","sequence":50,"value":"512Mo"},{"displayText":"256Mo","id":"45d93430-5770-41cc-bd64-6d5f0126990d","sequence":60,"value":"256Mo"},{"displayText":"5Go","id":"bc96856e-847b-21b6-4ff3-a687a1aa5a09","sequence":70,"value":"5Go"}],"default":[],"selectedItem":{"displayText":"30Go","id":"203aab93-e795-c07b-9353-c9fc2ee2f988","sequence":20,"value":"30Go"}},"$$AttributeDefinitionEnd$$":null},{"$$AttributeDefinitionStart$$":null,"objectid__c":"01t0D000002iZfAQAU","attributeid__c":"a0P0D0000014nodUAA","attributecategoryid__c":"a0O0D000002DZ0aUAG","categorycode__c":"INWI_ACAT_IOT","categoryname__c":"IOT","attributeuniquecode__c":"INWI_ATT_RT_IOT_DATA_LABEL","attributeconfigurable__c":true,"attributedisplaysequence__c":"10","attributefilterable__c":false,"attributecloneable__c":true,"isactive__c":true,"attributedisplayname__c":"Forfait","displaysequence__c":"null","categorydisplaysequence__c":50,"customconfiguitemplate__c":null,"formatmask__c":null,"hasrule__c":true,"isconfigurable__c":true,"ishidden__c":false,"valueinnumber__c":null,"objecttype__c":"Product2","querycode__c":null,"isreadonly__c":false,"isnottranslatable__c":false,"isquerydriven__c":false,"querylabel__c":null,"id":"a0M0D000000nBphUAE","isrequired__c":true,"rulemessage__c":null,"uidisplaytype__c":"Dropdown","value__c":null,"valuedatatype__c":"Picklist","valuedescription__c":null,"attributegrouptype__c":null,"attributeRunTimeInfo":{"dataType":"Picklist","uiDisplayType":"Dropdown","values":[{"displayText":"Forfait 15Go","id":"823a2981-a6bf-11e7-d925-da4bcfcd521c","sequence":10,"value":"Forfait 15Go"},{"displayText":"Forfait 30Go","id":"9c21c8f6-0d1d-96ce-71a5-be044364cc2f","sequence":20,"value":"Forfait 30Go"},{"displayText":"Forfait 60Go","id":"ea251c03-88f7-1399-b8eb-d99cea40cc22","sequence":30,"value":"Forfait 60Go"}],"default":[],"selectedItem":{"displayText":"Forfait 30Go","id":"9c21c8f6-0d1d-96ce-71a5-be044364cc2f","sequence":20,"value":"Forfait 30Go"}},"$$AttributeDefinitionEnd$$":null}],"INWI_ATT_RT_ENGAGEMENT":[{"$$AttributeDefinitionStart$$":null,"objectid__c":"01t0D000002iZfAQAU","attributeid__c":"a0P0D0000014no5UAA","attributecategoryid__c":"a0O0D000002DZ0QUAW","categorycode__c":"INWI_ATT_RT_ENGAGEMENT","categoryname__c":"Engagement","attributeuniquecode__c":"INWI_ATT_RT_ENGAGEMENT_IOT","attributeconfigurable__c":true,"attributedisplaysequence__c":"30","attributefilterable__c":false,"attributecloneable__c":true,"isactive__c":false,"attributedisplayname__c":"Engagement","displaysequence__c":"null","categorydisplaysequence__c":20,"customconfiguitemplate__c":null,"formatmask__c":null,"hasrule__c":false,"isconfigurable__c":true,"ishidden__c":false,"valueinnumber__c":null,"objecttype__c":"Product2","querycode__c":null,"isreadonly__c":false,"isnottranslatable__c":false,"isquerydriven__c":false,"querylabel__c":null,"id":"a0M0D000000nBpiUAE","isrequired__c":true,"rulemessage__c":null,"uidisplaytype__c":"Dropdown","value__c":null,"valuedatatype__c":"Picklist","valuedescription__c":null,"attributegrouptype__c":null,"attributeRunTimeInfo":{"dataType":"Picklist","uiDisplayType":"Dropdown","values":[{"displayText":"12 Mois","id":"fbea5c4d-316e-6ddd-7e13-1fc2cb0ba794","sequence":10,"value":"12 Months"},{"displayText":"24 Mois","id":"663785e9-521a-e674-7583-d07f39377f1f","sequence":20,"value":"24 Months"},{"displayText":"36 Mois","id":"f138d898-5233-ca48-fb59-3263948dd1c4","sequence":30,"value":"36 Months"}],"default":[],"selectedItem":{"displayText":"24 Mois","id":"663785e9-521a-e674-7583-d07f39377f1f","sequence":20,"value":"24 Months"}},"$$AttributeDefinitionEnd$$":null}]}';
        public static String JSON_ATTRIBUTE_UPDATED = '{"INWI_ACAT_IOT":[{"$$AttributeDefinitionStart$$":null,"objectid__c":"01t0D000002iZfAQAU","attributeid__c":"a0P0D0000014noaUAA","attributecategoryid__c":"a0O0D000002DZ0aUAG","categorycode__c":"INWI_ACAT_IOT","categoryname__c":"IOT","attributeuniquecode__c":"INWI_ATT_RT_DATA_IOT","attributeconfigurable__c":true,"attributedisplaysequence__c":"20","attributefilterable__c":false,"attributecloneable__c":true,"isactive__c":true,"attributedisplayname__c":"Data","displaysequence__c":"null","categorydisplaysequence__c":50,"customconfiguitemplate__c":null,"formatmask__c":null,"hasrule__c":true,"isconfigurable__c":true,"ishidden__c":false,"valueinnumber__c":null,"objecttype__c":"Product2","querycode__c":null,"isreadonly__c":true,"isnottranslatable__c":false,"isquerydriven__c":false,"querylabel__c":null,"id":"a0M0D000000nBpgUAE","isrequired__c":true,"rulemessage__c":null,"uidisplaytype__c":"Dropdown","value__c":null,"valuedatatype__c":"Picklist","valuedescription__c":null,"attributegrouptype__c":null,"attributeRunTimeInfo":{"dataType":"Picklist","uiDisplayType":"Dropdown","values":[{"displayText":"15Go","id":"ebc92e17-644d-fed7-48af-22ff14952d1e","sequence":10,"value":"15Go"},{"displayText":"30Go","id":"203aab93-e795-c07b-9353-c9fc2ee2f988","sequence":20,"value":"30Go"},{"displayText":"60Go","id":"fc4ff531-f98f-02dd-9b37-c8dca3112f7c","sequence":30,"value":"60Go"},{"displayText":"Illimitée","id":"c2f5e438-439e-44f1-cbc2-a91a8556cb47","sequence":40,"value":"Illimitée"},{"displayText":"512Mo","id":"23cc9add-b7d1-6022-8216-62b615efe841","sequence":50,"value":"512Mo"},{"displayText":"256Mo","id":"45d93430-5770-41cc-bd64-6d5f0126990d","sequence":60,"value":"256Mo"},{"displayText":"5Go","id":"bc96856e-847b-21b6-4ff3-a687a1aa5a09","sequence":70,"value":"5Go"}],"default":[],"selectedItem":{"displayText":"30Go","id":"203aab93-e795-c07b-9353-c9fc2ee2f988","sequence":20,"value":"30Go"}},"$$AttributeDefinitionEnd$$":null},{"$$AttributeDefinitionStart$$":null,"objectid__c":"01t0D000002iZfAQAU","attributeid__c":"a0P0D0000014nodUAA","attributecategoryid__c":"a0O0D000002DZ0aUAG","categorycode__c":"INWI_ACAT_IOT","categoryname__c":"IOT","attributeuniquecode__c":"INWI_ATT_RT_IOT_DATA_LABEL","attributeconfigurable__c":true,"attributedisplaysequence__c":"10","attributefilterable__c":false,"attributecloneable__c":true,"isactive__c":true,"attributedisplayname__c":"Forfait","displaysequence__c":"null","categorydisplaysequence__c":50,"customconfiguitemplate__c":null,"formatmask__c":null,"hasrule__c":true,"isconfigurable__c":true,"ishidden__c":false,"valueinnumber__c":null,"objecttype__c":"Product2","querycode__c":null,"isreadonly__c":false,"isnottranslatable__c":false,"isquerydriven__c":false,"querylabel__c":null,"id":"a0M0D000000nBphUAE","isrequired__c":true,"rulemessage__c":null,"uidisplaytype__c":"Dropdown","value__c":null,"valuedatatype__c":"Picklist","valuedescription__c":null,"attributegrouptype__c":null,"attributeRunTimeInfo":{"dataType":"Picklist","uiDisplayType":"Dropdown","values":[{"displayText":"Forfait 15Go","id":"823a2981-a6bf-11e7-d925-da4bcfcd521c","sequence":10,"value":"Forfait 15Go"},{"displayText":"Forfait 30Go","id":"9c21c8f6-0d1d-96ce-71a5-be044364cc2f","sequence":20,"value":"Forfait 30Go"},{"displayText":"Forfait 60Go","id":"ea251c03-88f7-1399-b8eb-d99cea40cc22","sequence":30,"value":"Forfait 60Go"}],"default":[],"selectedItem":{"displayText":"Forfait 30Go","id":"9c21c8f6-0d1d-96ce-71a5-be044364cc2f","sequence":20,"value":"Forfait 30Go"}},"$$AttributeDefinitionEnd$$":null}],"INWI_ATT_RT_ENGAGEMENT":[{"$$AttributeDefinitionStart$$":null,"objectid__c":"01t0D000002iZfAQAU","attributeid__c":"a0P0D0000014no5UAA","attributecategoryid__c":"a0O0D000002DZ0QUAW","categorycode__c":"INWI_ATT_RT_ENGAGEMENT","categoryname__c":"Engagement","attributeuniquecode__c":"INWI_ATT_RT_ENGAGEMENT_IOT","attributeconfigurable__c":true,"attributedisplaysequence__c":"30","attributefilterable__c":false,"attributecloneable__c":true,"isactive__c":false,"attributedisplayname__c":"Engagement","displaysequence__c":"null","categorydisplaysequence__c":20,"customconfiguitemplate__c":null,"formatmask__c":null,"hasrule__c":false,"isconfigurable__c":true,"ishidden__c":false,"valueinnumber__c":null,"objecttype__c":"Product2","querycode__c":null,"isreadonly__c":false,"isnottranslatable__c":false,"isquerydriven__c":false,"querylabel__c":null,"id":"a0M0D000000nBpiUAE","isrequired__c":true,"rulemessage__c":null,"uidisplaytype__c":"Dropdown","value__c":null,"valuedatatype__c":"Picklist","valuedescription__c":null,"attributegrouptype__c":null,"attributeRunTimeInfo":{"dataType":"Picklist","uiDisplayType":"Dropdown","values":[{"displayText":"12 Mois","id":"fbea5c4d-316e-6ddd-7e13-1fc2cb0ba794","sequence":10,"value":"12 Months"},{"displayText":"24 Mois","id":"663785e9-521a-e674-7583-d07f39377f1f","sequence":20,"value":"24 Months"},{"displayText":"36 Mois","id":"f138d898-5233-ca48-fb59-3263948dd1c4","sequence":30,"value":"36 Months"}],"default":[],"selectedItem"},{"displayText":"36 Mois","id":"f138d898-5233-ca48-fb59-3263948dd1c4","sequence":30,"value":"36 Months"}},"$$AttributeDefinitionEnd$$":null}]}';
        public static String INWI_ATT_RT_ENGAGEMENT_IOT = 'INWI_ATT_RT_ENGAGEMENT_IOT';
        public static String MONTHS_24 = '24 Months';
        public static String ENGAGEMENT='Engagement';
        public static String DIPLAY_TEXT_MONTHS_36 = '36 Mois';
        public static String DIPLAY_TEXT_MONTHS_24 = '24 Mois';
    
        @isTest static void invokeMethodTest() {
        String methodName = 'AttributeDisplayText'; 
        List<Object> arguments = new List<Object>();
        arguments.add(JSON_ATTRIBUTE);
        arguments.add(INWI_ATT_RT_ENGAGEMENT_IOT);
        Map<String,Object> inputMap = new Map<String,Object>();
        inputMap.put('arguments', arguments);
        Map<String,Object> outMap = new Map<String,Object>(); 
        Map<String,Object> options = new Map<String,Object>();
        INWIB2C_INWICustomFunctionImplementation customFunctionImplementation = new INWIB2C_INWICustomFunctionImplementation();
        boolean result = customFunctionImplementation.invokeMethod(methodName, inputMap, outMap, options);
        System.assertEquals(true,result);
        result = customFunctionImplementation.invokeMethod('AttributeValue', inputMap, outMap, options);
        System.assertEquals(true,result);
            
      	
         
        result = customFunctionImplementation.invokeMethod('getAllAttributeValue', inputMap, outMap, options);
        System.assertEquals(true,result);
        
          
    
         
        List<Object> arguments2 = new List<Object>{new Map<String,Object>{'CSProduct'=> new List<Object>{new Map<String,Object>{'CSProduct' => new Map<String,Object>{'AB'=>'CC'}}}}, 'AB', 'CD'};

        inputMap.put('arguments', arguments2);
        result = customFunctionImplementation.invokeMethod('SPLITNodes', inputMap, outMap, options);
            
        System.assertEquals(true,result);
             
    }
      @isTest static void getAttributeValuesFromJSONTest() {
        List<Object> arguments = new List<Object>();
        arguments.add(JSON_ATTRIBUTE);
        arguments.add(INWI_ATT_RT_ENGAGEMENT_IOT);
        String result = INWIB2C_INWICustomFunctionImplementation.attributeValue(arguments);
        system.assertEquals(MONTHS_24, result);
    	}
    
    /* @isTest static void attributeDisplayTextTest() {
        List<Object> arguments = new List<Object>();
        arguments.add(JSON_ATTRIBUTE);
        arguments.add(INWI_ATT_RT_ENGAGEMENT_IOT);
        String result = INWIB2C_INWICustomFunctionImplementation.attributeDisplayText(arguments);
       // system.assertEquals(MONTHS_24, result);
    	}*/
    @isTest static void getAllAttributeValueTest() {
        List<Object> arguments = new List<Object>();
        Map<String,Object> result=new Map<String,Object>();
        arguments.add(JSON_ATTRIBUTE);
        result = INWIB2C_INWICustomFunctionImplementation.getAllAttributeValue(arguments);
          //System.assertEquals(true,result);
    	}
     @isTest static void ReplaceTest() {
     /* List<Object> arguments3 = new List<Object>();
        arguments3.add('chaine');
        arguments3.add(',');
        arguments3.add('-');

         Map<String,Object> inputMap = new Map<String,Object>();
        inputMap.put('arguments', arguments3);
        Map<String,Object> outMap = new Map<String,Object>(); 
        Map<String,Object> options = new Map<String,Object>();*/
              String result;
                  
        result = INWIB2C_INWICustomFunctionImplementation.REPLACE('chaine,chai',',','-');
       //  System.assertEquals(true,result);
     }
    
     
}