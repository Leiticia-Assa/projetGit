/*B-0162 MANSRim 21/06/2021 Begin*/
@isTest
public class InwiB2C_TestOrderLabelMgt { 
@isTest(SeeAllData=true)
   	static void MethodTestPositive()
{
    Map<String,Object> outMap = new  Map<String,Object>();
    Map<String,Object> options = new  Map<String,Object>();
	Map<String,Object> inputMap = new  Map<String,Object>();
//	List <Map<String, Object>> caseList=new List <Map<String, Object>>();
   // Map<String, Object> inputMap = (Map<String, Object>) JSON.deserializeUntyped('{\"caseAll\":{\"List\":[{\"Type\": \"Inwib2c_Reclamation\",\"Statut\": \"InwiB2C_Escalade\" },{\"Type\": \"Inwib2c_Televente\",\"Statut\": \"InwiB2C_Ouvert\" } ] }}');
 
 
   // inputMap.put('caseAll', JSON.deserializeUntyped(' { \"List\":[{\"Type\": \"Inwib2c_Reclamation\",\"Statut\": \"InwiB2C_Escalade\" },{\"Type\": \"Inwib2c_Reclamation\",\"Statut\": \"InwiB2C_Escalade\" } ] }'));
    Map<String, Object> listeAll=new Map<String, Object>();

List<Map<String, Object>> liste = new List <Map<String, Object>>();
Map<String, Object> mape = new Map<String, Object>();
mape.put('Type', 'inwib2c_TypeDeLaCommande__c');
mape.put('Statut', 'status');
liste.add(mape);
        ListeAll.put('ListOrders',liste);

    
Map<String, Object> mapeActions = new Map<String, Object>();
mapeActions.put('Type', 'inwiB2C_TypeActeDeGestion__c');
liste.add(mapeActions);

    ListeAll.put('ListActeGestion',liste);
    
    
    Map<String, Object> mapeActionsType = new Map<String, Object>();
mapeActionsType.put('Type', 'inwiB2C_TypeAction__c');
liste.add(mapeActionsType);

    ListeAll.put('ListActions',liste);
    

   //Map<String, Object> testLimit=new Map<String, Object>();
  //  testLimit.put('CaseLimit',listeLimit);    
    
    
    // inputMap.put('OrderLimit',listeLimit );
inputMap.put('OrderAll',listeAll );
   

    
    
    

    
    
 //  	inputMap.put('caseAll', JSON.deserializeUntyped('  {  \"CaseLimit\":  [ {  \"AccountId\": \"0012z000002bWH4AAM\", \"Type\": \"Inwib2c_Reclamation\",\"Statuts\": \"InwiB2C_Escalade\" } ] }'));
    //inputMap.put('List', JSON.deserializeUntyped(' [ { \"AccountId\": \"0012z000002bWH4AAM\", \"Type\": \"Inwib2c_Reclamation\",\"Statut\": \"InwiB2C_Escalade\" } ] '));
    
    
    
    
    
    



   InwiB2C_OrderLabelMget_DR cls = new InwiB2C_OrderLabelMget_DR(); 

   boolean result = cls.invokeMethod('populateLabelsDR_Order',inputMap, outMap, options);
      //  System.debug('La valeur de outMap' + inputMap);
  //  System.debug('La valeur de outMap' + outMap);
    System.assertEquals(true, result);
    //result = cls.invokeMethod('populateLabelsDR_OrderSubscription',inputMap, outMap, options);
   // System.assertEquals(true, result);
    
    // result = cls.invokeMethod('populateLabelsDR_ActionSubscription',inputMap, outMap, options);
 //   System.assertEquals(true, result);
    
    }
}
/*B-0162 MansRIM 01/01/2021 end*/