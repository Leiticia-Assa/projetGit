@isTest
public class InwiB2C_MdnResearchTest {
    
        @isTest
    static void testgetMdnList (){
        Map<String,Object> outMap = new  Map<String,Object>();
        Map<String,Object> options = new  Map<String,Object>();
        Map<String,Object> inputMap = new  Map<String,Object>();
    
        inputMap.put('mdnType', 'MO');
        inputMap.put('offerType', 'Pre');
        inputMap.put('category', 'NORMAL');
        inputMap.put('mdn', '');
        inputMap.put('lockToken', '9100');
        inputMap.put('nbrResult', 2);
        InwiB2C_MdnResearch cls = new InwiB2C_MdnResearch(); 
        Test.setMock(HttpCalloutMock.class, new INWIB2C_SMSCalloutMock()); 
        boolean result = cls.invokeMethod('getMdnList',inputMap, outMap, options);
        //System.assertEquals(true, result);
        
    }

}