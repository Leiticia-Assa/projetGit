@isTest
public class InwiB2C_TestCloseCases {
	@isTest(SeeAllData=true)
    static void validateStandardController(){
          
        case TestCase =new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='Appel_entrant',status ='Ouvert'
                                ,InwiB2C_TypeSpecialite__c='InwiB2C_Roaming',Inwib2c_Cat_gorie__c='Inwib2c_Portabilite');
        insert TestCase;
        //String IdCase = TestCase.Id;
        
        case TestCase2 =new case(Type='Inwib2c_Reclamation' ,Description='A2' ,Subject='B2', origin='Appel_entrant',status ='Ouvert'
                                ,InwiB2C_TypeSpecialite__c='InwiB2C_Roaming',Inwib2c_Cat_gorie__c='Inwib2c_Portabilite');
        insert TestCase2;
        
        List<String> listIdCase = new List<String>();
        listIdCase.add(TestCase.Id);
        listIdCase.add(TestCase2.Id);
        
        
        
        List<Case> CasesList = [select id, casenumber, recordtypeId from case where id in :listIdCase]; 
        
        PageReference pageRef = Page.InwiB2C_CloseSelectedCases;
        Test.setCurrentPage(pageRef);
        
        ApexPages.standardSetController sc = new ApexPages.standardSetController(CasesList);
        InwiB2C_CloseCases testCloseCases = new InwiB2C_CloseCases(sc);
        
        testCloseCases.CasesList = CasesList;
        
        
        testCloseCases.CloseCases();
        testCloseCases.CancelAction();
        
        
      }
    
}