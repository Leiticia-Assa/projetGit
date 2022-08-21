@isTest
public class InwiB2C_TestAssignCase {
    
 @isTest(SeeAllData=true)
   	static void AssignCaseToBOQueue()
{
    Map<String,Object> outMap = new  Map<String,Object>();
 	Map<String,Object> options = new  Map<String,Object>();
    Map<String,Object> inputMap = new  Map<String,Object>();

    Account testAccount  = new Account ();
    testAccount.Name = 'TestOxygeneParam';
    testAccount.AccountNumber = '123456';
    Insert testAccount;
    
    BOLevel2Profiles__c boLevel2Test = new BOLevel2Profiles__c (QueueInput__c = 'BO Réclamation B2C', Category__c= 'Inwib2c_Reseau_Reclamation', QueueOutput__c = 'BO Réclamation Réseau');
    insert boLevel2Test;
    case TestCase =new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='C',status ='Ouvert'
                     ,InwiB2C_TypeSpecialite__c='InwiB2C_Roaming',Inwib2c_Cat_gorie__c='Inwib2c_Reseau_Reclamation');
    insert TestCase;
    TestCase.status  = 'Résolu';
    
    string IdNewCase = [SELECT id from group where name ='BO Réclamation B2C' limit 1].id;
    
    options.put('IdCase', TestCase.id);
    options.put('QueueInput', IdNewCase);
    options.put('QueueNameInput', 'BO Réclamation B2C');
   InwiB2C_AssignCaseToProfile cls = new InwiB2C_AssignCaseToProfile(); 
   
    boolean result = cls.invokeMethod('AssignCase',inputMap, outMap, options);
    System.assertEquals(true, result);


}
    
     @isTest(SeeAllData=true)
   	static void AssignCaseToBoQueue2()
{
    Map<String,Object> outMap = new  Map<String,Object>();
 	Map<String,Object> options = new  Map<String,Object>();
    Map<String,Object> inputMap = new  Map<String,Object>();

    case TestCase =new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='C',status ='Ouvert'
                            ,InwiB2C_TypeSpecialite__c='InwiB2C_Roaming',Inwib2c_Cat_gorie__c='Inwib2c_Portabilite', InwiB2C_LastEscaladeDate__c=Date.newInstance(2016, 12, 9));
    insert TestCase;
    
    string IdNewCase = [SELECT id from group where name ='BO Réclamation B2C' limit 1].id;
    BOLevel2Profiles__c boLevel2Test = new BOLevel2Profiles__c (QueueInput__c = 'BO Réclamation B2C', Category__c= 'Inwib2c_Reseau_Reclamation', QueueOutput__c = 'BO Réclamation Réseau');
    insert boLevel2Test;
    options.put('IdCase',TestCase.id );
    options.put('QueueInput', IdNewCase);
    options.put('QueueNameInput', 'BO Réclamation B2C');
   InwiB2C_AssignCaseToProfile cls = new InwiB2C_AssignCaseToProfile(); 
   
    boolean result = cls.invokeMethod('AssignCase',inputMap, outMap, options);
    System.assertEquals(true, result);

}
    
     @isTest(SeeAllData=true)
   	static void AssignCaseToQueue()
{
    Map<String,Object> outMap = new  Map<String,Object>();
 	Map<String,Object> options = new  Map<String,Object>();
    Map<String,Object> inputMap = new  Map<String,Object>();
        BOLevel2Profiles__c boLevel2Test = new BOLevel2Profiles__c (QueueInput__c = 'BO Réclamation B2C', Category__c= 'Inwib2c_Reseau_Reclamation', QueueOutput__c = 'BO Réclamation Réseau');
    insert boLevel2Test;
    case TestCase =new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='C',status ='Ouvert'
                            ,InwiB2C_TypeSpecialite__c='InwiB2C_Roaming',Inwib2c_Cat_gorie__c='Inwib2c_Portabilite');
    insert TestCase;
    
    string IdNewCase = [SELECT id from group where name ='Scoring Roaming' limit 1].id;

    options.put('IdCase',TestCase.id );
    options.put('QueueInput', IdNewCase);
    options.put('QueueNameInput', 'Scoring Roaming');

   InwiB2C_AssignCaseToProfile cls = new InwiB2C_AssignCaseToProfile(); 
   
    boolean result = cls.invokeMethod('AssignCase',inputMap, outMap, options);
    System.assertEquals(true, result);

}
    
     @isTest(SeeAllData=true)
   	static void AssignCaseToUser()
{
    Map<String,Object> outMap = new  Map<String,Object>();
 	Map<String,Object> options = new  Map<String,Object>();
    Map<String,Object> inputMap = new  Map<String,Object>();
    
    case TestCase =new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='C',status ='Ouvert'
                            ,InwiB2C_TypeSpecialite__c='InwiB2C_Roaming',Inwib2c_Cat_gorie__c='Inwib2c_Portabilite');
    insert TestCase;
    User[] UserEsc = [SELECT Id From User limit 1];
    String idUserEsc = UserEsc[0].Id;

    options.put('IdCase', TestCase.Id);
    options.put('QueueInput', idUserEsc);

    InwiB2C_AssignCaseToProfile cls = new InwiB2C_AssignCaseToProfile(); 

   boolean result = cls.invokeMethod('AssignCaseToUser',inputMap, outMap, options);
   System.assertEquals(true, result);

}
    
         @isTest(SeeAllData=true)
   	static void getUsersByCaseId()
{
    Map<String,Object> outMap = new  Map<String,Object>();
 	Map<String,Object> options = new  Map<String,Object>();
    Map<String,Object> inputMap = new  Map<String,Object>();
    List<Groupmember> UserOrGroupList = [SELECT UserOrGroupId, GroupId FROM Groupmember limit 1];
    
    case TestCase =new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='C',status ='Ouvert'
                            ,InwiB2C_TypeSpecialite__c='InwiB2C_Roaming',Inwib2c_id_la_file_d_attente__c = UserOrGroupList[0].GroupId , Inwib2c_Cat_gorie__c='Inwib2c_Reseau_Reclamation');
    insert TestCase;
    
    options.put('IdCase', TestCase.Id);
    
    InwiB2C_AssignCaseToProfile cls = new InwiB2C_AssignCaseToProfile(); 
    
    boolean result = cls.invokeMethod('getUsersByCaseId',inputMap, outMap, options);
    System.assertEquals(true, result);

}
    
}