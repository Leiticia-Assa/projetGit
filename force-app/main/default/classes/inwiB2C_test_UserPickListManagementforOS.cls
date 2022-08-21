@isTest
public class inwiB2C_test_UserPickListManagementforOS {
      @isTest(SeeAllData=true)
    static void MethodTestPositive()
    {
        
         Map<String,Object> outMap = new  Map<String,Object>();
     Map<String,Object> options = new  Map<String,Object>();
     Map<String,Object> inputMap = new  Map<String,Object>();

        
        
    
        string recordTypeValue0='InwiB2C_Assistance';
        String recordTypeValue1='InwiB2C_HelpDesk';
        String recordTypeValue2='InwiB2C_Information';
        String recordTypeValue3='InwiB2C_Modification';
        String recordTypeValue4='InwiB2C_Reclamation';
        String recordTypeValue5='InwiB2C_RECLAMATION_VIP';
        String recordTypeValue6='InwiB2C_Retention';
        String recordTypeValue7='InwiB2C_Televente';


          inwiB2C_UserPickListManagementforOS cls = new inwiB2C_UserPickListManagementforOS(); 
    
        inputMap = new  Map<String,Object>();
        inputMap.put('recordTypeValue',recordTypeValue0); 
        boolean result0 = cls.invokeMethod('getRecordTypeList',inputMap, outMap, options);
        result0 = cls.invokeMethod('getDefaultType',inputMap, outMap, options);
        System.assertEquals(true, result0);
        
        inputMap = new  Map<String,Object>();
        inputMap.put('recordTypeValue',recordTypeValue1); 
        boolean result1 = cls.invokeMethod('getRecordTypeList',inputMap, outMap, options);
        result1 = cls.invokeMethod('getDefaultType',inputMap, outMap, options);
        System.assertEquals(true, result1);

        
        inputMap = new  Map<String,Object>();
        inputMap.put('recordTypeValue',recordTypeValue2); 
        boolean result2 = cls.invokeMethod('getRecordTypeList',inputMap, outMap, options);
        result2 = cls.invokeMethod('getDefaultType',inputMap, outMap, options);
        System.assertEquals(true, result2);

        inputMap = new  Map<String,Object>();
        inputMap.put('recordTypeValue',recordTypeValue3); 
        boolean result3 = cls.invokeMethod('getRecordTypeList',inputMap, outMap, options);
        result3 = cls.invokeMethod('getDefaultType',inputMap, outMap, options);
        System.assertEquals(true, result3);

        inputMap = new  Map<String,Object>();
        inputMap.put('recordTypeValue',recordTypeValue4); 
        boolean result4 = cls.invokeMethod('getRecordTypeList',inputMap, outMap, options);
        result4 = cls.invokeMethod('getDefaultType',inputMap, outMap, options);
        System.assertEquals(true, result4);

        inputMap = new  Map<String,Object>();
        inputMap.put('recordTypeValue',recordTypeValue5); 
        boolean result5 = cls.invokeMethod('getRecordTypeList',inputMap, outMap, options);
        result5 = cls.invokeMethod('getDefaultType',inputMap, outMap, options);
        System.assertEquals(true, result5);

        inputMap = new  Map<String,Object>();
        inputMap.put('recordTypeValue',recordTypeValue6); 
        boolean result6 = cls.invokeMethod('getRecordTypeList',inputMap, outMap, options);
        result6 = cls.invokeMethod('getDefaultType',inputMap, outMap, options);
        System.assertEquals(true, result6);

        inputMap = new  Map<String,Object>();
        inputMap.put('recordTypeValue',recordTypeValue7); 
        boolean result7 = cls.invokeMethod('getRecordTypeList',inputMap, outMap, options);
        result7 = cls.invokeMethod('getDefaultType',inputMap, outMap, options);
        System.assertEquals(true, result7);

        

    }

}