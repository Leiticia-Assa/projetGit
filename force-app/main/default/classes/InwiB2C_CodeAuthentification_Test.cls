@isTest
public class InwiB2C_CodeAuthentification_Test {
  @isTest(SeeAllData=true)
   	static void InsertPassword()
{
    Map<String,Object> outMap = new  Map<String,Object>();
 	Map<String,Object> options = new  Map<String,Object>();
    Map<String,Object> inputMap = new  Map<String,Object>();

    options.put('Mdn', '212000365216');

    InwiB2C_CodeAuthentification cls = new InwiB2C_CodeAuthentification ();

   
    boolean result = cls.invokeMethod('AddPWDAuthentification',inputMap, outMap, options);
       
    boolean result1 = cls.invokeMethod('verify',inputMap, outMap, options);

    //System.assertEquals(true, result);
    
    //System.assertEquals(true, result1);

    //System.debug(outMap);

}
}