@isTest 

public with sharing class InwiB2C_SubmitForApprovalCustom_TEST {

    @isTest 
    static void  MethodTestSubmitForApprovalCustom() {


        Map<String,Object> outMap,options,inputMap= new  Map<String,Object>();


        InwiB2C_Demande_identification__c di = new InwiB2C_Demande_identification__c(InwiB2C_Nom__c='NomTest',InwiB2C_Prenom__c='Prenom');
        insert di;
    

        inputMap.put('recordId',di.Id);


        (new InwiB2C_SubmitForApprovalCustom()).invokeMethod('submitApproval',inputMap, outMap, options);

}



}