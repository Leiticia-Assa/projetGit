@isTest

public with sharing class inwiB2C_ContractPickListManagement_TEST {

        @isTest(SeeAllData=true)
    static void  MethodTest() {
        
        Map<String,Object> outMap,options,inputMap= new  Map<String,Object>();

        (new inwiB2C_ContractPickListManagement()).invokeMethod('gePicklistValues',inputMap, outMap, options);

        


    }
}