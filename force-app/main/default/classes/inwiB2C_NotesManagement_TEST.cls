@isTest

public with sharing class inwiB2C_NotesManagement_TEST {

    @isTest(SeeAllData=true)
    static void  MethodTestNotesManagement() {


    Map<String,Object> outMap,options,inputMap= new  Map<String,Object>();

    Account acc = new Account(Name='classTestAccount');
    insert acc;

    Contract contrat = new Contract(Name='classTestContract',AccountId=acc.Id);
    insert contrat;        

    inputMap.put('recordId',contrat.Id);
    inputMap.put('title','a title');
    inputMap.put('body','the body text');

    (new inwiB2C_NotesManagement()).invokeMethod('createNote',inputMap, outMap, options);
    (new inwiB2C_NotesManagement()).invokeMethod('getNotes',inputMap, outMap, options);

   

    }
}