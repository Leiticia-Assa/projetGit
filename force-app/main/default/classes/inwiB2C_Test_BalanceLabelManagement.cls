@isTest
public class inwiB2C_Test_BalanceLabelManagement {
    @isTest(SeeAllData=true)
    static void MethodTestPositive()
{
    
     Map<String,Object> outMap = new  Map<String,Object>();
     Map<String,Object> options = new  Map<String,Object>();
     Map<String,Object> inputMap = new  Map<String,Object>();
    

    List<Map<String, Object>> Liste = new List <Map<String, Object>>();
    Map<String, Object> M_LISTEBAL = new Map<String, Object>();
    M_LISTEBAL.put('DURATION', '23');
    M_LISTEBAL.put('M_AMOUNT_CEILING', '0');
    M_LISTEBAL.put('M_FLAG_CEILING', 'N');
    M_LISTEBAL.put('CALL_DIRECTION', 'Sortant');
    M_LISTEBAL.put('M_LISTEBAL', '1234567890:12.43;987654321:43.01;');
    M_LISTEBAL.put('CANAL', '');
    M_LISTEBAL.put('GPRS_VOLUME', '');
    M_LISTEBAL.put('M_START_DATE', '2020-08-09 21:30:07');
    M_LISTEBAL.put('M_AMOUNT_CON', '0.01');
    M_LISTEBAL.put('M_SERVICE_NAME', 'SERVICE INCONNU');
    M_LISTEBAL.put('M_LINE_ID', '212636591728');
    M_LISTEBAL.put('M_CALL_TYPE', 'Voix');
    M_LISTEBAL.put('M_TYPE_CONSO', 'Voice_OC');
    M_LISTEBAL.put('FNFFLAG', 'Non');
    
    Liste.add(M_LISTEBAL);
    M_LISTEBAL = new Map<String, Object>();
    
    
    
    
    
    M_LISTEBAL.put('DURATION', '23');
    M_LISTEBAL.put('M_AMOUNT_CEILING', '0');
    M_LISTEBAL.put('M_FLAG_CEILING', 'N');
    M_LISTEBAL.put('CALL_DIRECTION', 'Sortant');
    M_LISTEBAL.put('M_LISTEBAL', '1234567890:65.01;987654321:76.01;');
    M_LISTEBAL.put('CANAL', '');
    M_LISTEBAL.put('GPRS_VOLUME', '');
    M_LISTEBAL.put('M_START_DATE', '2020-08-09 21:30:07');
    M_LISTEBAL.put('M_AMOUNT_CON', '0.01');
    M_LISTEBAL.put('M_SERVICE_NAME', 'SERVICE INCONNU');
    M_LISTEBAL.put('M_LINE_ID', '212636591728');
    M_LISTEBAL.put('M_CALL_TYPE', 'Voix');
    M_LISTEBAL.put('M_TYPE_CONSO', 'Voice_OC');
    M_LISTEBAL.put('FNFFLAG', 'Non');

   Liste.add(M_LISTEBAL);
        List<InwiB2C_Balance_Labels__c> listBalanceLabels= [SELECT Id, Name, Label_Id__c FROM InwiB2C_Balance_Labels__c ];
    Map<String, Object> balanceMap = new  Map<String, Object>();

   
    List<Map<String, Object>> Liste2 = new List <Map<String, Object>>();
    
    InwiB2C_Balance_Labels__c  balanceLabel1 = new InwiB2C_Balance_Labels__c ();
    
    balanceLabel1.Label_Id__c = '1234567890';
    balanceLabel1.Name = 'Name 1234567890';
    
    insert balanceLabel1;
    
    InwiB2C_Balance_Labels__c  balanceLabel2 = new InwiB2C_Balance_Labels__c ();
    
    balanceLabel2.Label_Id__c = '987654321';
    balanceLabel2.Name = 'Name 0987654321';
    
    insert balanceLabel2;
    
    
    
    
    
    /*Map<String, Object> BalanceLab = new Map<String, Object>();
     BalanceLab.put('balId', '3000');
    BalanceLab.put('balLabel', 'Votre solde mensuel est de');
    BalanceLab.put('M_FLAG_CEILING', 'N');
    BalanceLab.put('balAmount', '0.58');
    BalanceLab.put('balCount', '18');
   
    BalanceLab.put('balId', '3001');
    BalanceLab.put('balLabel', 'Votre solde mensuel est de');
    BalanceLab.put('M_FLAG_CEILING', 'N');
    BalanceLab.put('balAmount', '0.58');
    BalanceLab.put('balCount', '18');
    */
    
   
    
    
 
     inputMap.put('consoList',Liste); 
     //inputMap.put('balanceList',BalanceLab); 

    
    
   


     InwiB2C_BalanceLabelManagement cls = new InwiB2C_BalanceLabelManagement(); 
    
  
   boolean result = cls.invokeMethod('getBalanceWithLabels',inputMap, outMap, options);
   
    System.assertEquals(true, result);
    
    
   
    
}
    
        
    

}