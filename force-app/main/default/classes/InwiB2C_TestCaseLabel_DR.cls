/*B-0162 MANSRim 01/01/2021 Begin*/
@isTest
public class InwiB2C_TestCaseLabel_DR { 
@isTest(SeeAllData=true)
   	static void MethodTestPositive()
{
    Map<String,Object> outMap = new  Map<String,Object>();
    Map<String,Object> options = new  Map<String,Object>();
	Map<String,Object> inputMap = new  Map<String,Object>();
//	List <Map<String, Object>> caseList=new List <Map<String, Object>>();
   // Map<String, Object> inputMap = (Map<String, Object>) JSON.deserializeUntyped('{\"caseAll\":{\"List\":[{\"Type\": \"Inwib2c_Reclamation\",\"Statut\": \"InwiB2C_Escalade\" },{\"Type\": \"Inwib2c_Televente\",\"Statut\": \"InwiB2C_Ouvert\" } ] }}');
 
 
   // inputMap.put('caseAll', JSON.deserializeUntyped(' { \"List\":[{\"Type\": \"Inwib2c_Reclamation\",\"Statut\": \"InwiB2C_Escalade\" },{\"Type\": \"Inwib2c_Reclamation\",\"Statut\": \"InwiB2C_Escalade\" } ] }'));

List<Map<String, Object>> liste = new List <Map<String, Object>>();
Map<String, Object> mape = new Map<String, Object>();
mape.put('Type', 'Inwib2c_Reclamation');
mape.put('Statut', 'InwiB2C_Escalade');

liste.add(mape);
    Map<String, Object> listeAll=new Map<String, Object>();
    ListeAll.put('List',liste);
    
    
    
    
List<Map<String, Object>> listeLimit = new List <Map<String, Object>>();
Map<String, Object> mapeLimit = new Map<String, Object>();
mapeLimit.put('Type', 'Inwib2c_Reclamation');
    mapeLimit.put('Statuts', 'InwiB2C_Escalade');

listeLimit.add(mapeLimit);
   //Map<String, Object> testLimit=new Map<String, Object>();
  //  testLimit.put('CaseLimit',listeLimit);    
    
    
     inputMap.put('CaseLimit',listeLimit );
inputMap.put('caseAll',listeAll );
   

    
    
    

    
    
 //  	inputMap.put('caseAll', JSON.deserializeUntyped('  {  \"CaseLimit\":  [ {  \"AccountId\": \"0012z000002bWH4AAM\", \"Type\": \"Inwib2c_Reclamation\",\"Statuts\": \"InwiB2C_Escalade\" } ] }'));
    //inputMap.put('List', JSON.deserializeUntyped(' [ { \"AccountId\": \"0012z000002bWH4AAM\", \"Type\": \"Inwib2c_Reclamation\",\"Statut\": \"InwiB2C_Escalade\" } ] '));
    
    
    
    
    
    



   inwiB2C_CaseLabelMgt_DR cls = new inwiB2C_CaseLabelMgt_DR(); 

   boolean result = cls.invokeMethod('populateLabelsDR_CaseClient',inputMap, outMap, options);
      //  System.debug('La valeur de outMap' + inputMap);
  //  System.debug('La valeur de outMap' + outMap);
    System.assertEquals(true, result);
    result = cls.invokeMethod('populateLabelsDR_CaseSubscription',inputMap, outMap, options);
    System.assertEquals(true, result);
    
    }
}
/*B-0162 MansRIM 01/01/2021 end*/