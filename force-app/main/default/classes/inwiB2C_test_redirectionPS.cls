/*B-0162 MANSRim 01/01/2021 Begin*/

@isTest
public class inwiB2C_test_redirectionPS {
    @isTest(SeeAllData=true)
   	static void MethodTestPositive()
{
    
    Map<String,Object> outMap = new  Map<String,Object>();
    Map<String,Object> options = new  Map<String,Object>();
	Map<String,Object> inputMap = new  Map<String,Object>();
    
    	//String linktogo ='0012z000002cxObAAI'; 
     //String retoxyValue ='0012z000002cxObAAI';
    
    Account accounttest1 = new Account(
    Name = 'Mohamed Test',
    AccountNumber='154741554');
    insert accounttest1;


    String theid1 = accounttest1.ID;

    options.put('linktogo',theid1 );

       InwiB2C_redirection_pps_oxy cls = new InwiB2C_redirection_pps_oxy(); 

        boolean result1 = cls.invokeMethod('redirect_pps',inputMap, outMap, options);
        System.assertEquals(true, result1);
        
        
    boolean result2 = cls.invokeMethod('redirect_oxy',inputMap, outMap, options);
    System.assertEquals(true, result2);

    
    Account accounttest2 = new Account(
    Name = 'Mohamed Test');
    insert accounttest2;
    String theid2 = accounttest2.ID;

    options = new  Map<String,Object>();
    
    options.put('linktogo',theid2 );

        boolean result3 = cls.invokeMethod('redirect_pps',inputMap, outMap, options);
        System.assertEquals(true, result3);

        boolean result4 = cls.invokeMethod('redirect_oxy',inputMap, outMap, options);
        System.assertEquals(false, result4);

}

}
/*B-0162 MansRIM 01/01/2021 end*/