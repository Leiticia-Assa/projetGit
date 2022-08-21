@isTest
public class InwiB2C_Test_CaseLabelChanger_OS {
    @isTest
    static void MethodTestPositive(){
        
    Map<String,Object> outMap = new  Map<String,Object>();
    Map<String,Object> options = new  Map<String,Object>();
	Map<String,Object> inputMap = new  Map<String,Object>();
    
    

    
  Map<String,String> case1 = new Map<String,String>();
  Map<String,String> case2 = new Map<String,String>();
                 
      case1.put('Status', 'Escalade');
      case1.put('AccountId', '0012z000002LEanAAG');
      case1.put('FilleDAttente', 'BO_eshop');
      case1.put('IdCase', '5002z0000017VcsAAE');
      case1.put('Recapitulatif', 'lo');
      case1.put('Categorie', 'Inwib2c_Portail');
      case1.put('CreactedDate', '31/01/2021');
      case1.put('ConcernedSubscriptions', 'a4k2z0000004CUSAA2');
      case1.put('caseNumber', '00001909');
      case1.put('NumLigne', '212680214410');
                   
      case2.put('Status', 'Ouvert');
      case2.put('AccountId', '0012z000002LEanAAG');
      case2.put('IdCase', '5002z000000Vc7IAAS');
      case2.put('Recapitulatif', 'rf');
      case2.put('Categorie', 'Inwib2c_Couverture');
      case2.put('CreactedDate', '26/01/2021');
      case2.put('ConcernedSubscriptions', 'a4k2z0000004COAAA2');
      case2.put('caseNumber', '00001868');
      case2.put('NumLigne', '212638987671');
        
          List<Map<String,String>> allCases = new List<Map<String,String>>();

        allCases.add(case1);
        allCases.add(case2);
    options.put('allcases',allCases );
    inwiB2C_CaseLabelChanger_OS cls = new inwiB2C_CaseLabelChanger_OS(); 
    
    boolean result1 = cls.invokeMethod('getStatusLabel',inputMap, outMap, options);
    System.assertEquals(true, result1);
    }
}