@isTest
public class InwiB2C_TestGetQueueByProfile {

      @isTest(SeeAllData=true)
   	static void MethodePositive()
{
    Map<String,Object> outMap = new  Map<String,Object>();
 	Map<String,Object> options = new  Map<String,Object>();
    Map<String,Object> inputMap = new  Map<String,Object>();


    inwB2C_getQueueByProfile cls = new inwB2C_getQueueByProfile(); 
   
   boolean result = cls.invokeMethod('getQueuesForUser',inputMap, outMap, options);
   System.assertEquals(true, result);

}
    
}