/* AAR 24/01/2021 Begin*/

@isTest
public class InwiB2C_Test_PermissionSetManagement {
    @isTest(SeeAllData=true)
   	static void MethodTestPositive()
{
    
    Map<String,Object> outMap = new  Map<String,Object>();
    Map<String,Object> options = new  Map<String,Object>();
	Map<String,Object> inputMap = new  Map<String,Object>();
    
    
    InwiB2C_PermissionSetManagement cls = new InwiB2C_PermissionSetManagement(); 


        options.put('iduser','0012z000002cxObAAI' );
        boolean result1 = cls.invokeMethod('getPermissionSetInfo',inputMap, outMap, options);
        System.assertEquals(true, result1);


    	List<PermissionSetAssignment> userOfConsommationPS = [SELECT AssigneeId FROM PermissionSetAssignment WHERE PermissionSet.Name = 'InwiB2C_Consommation'];
        String authorizedID;
    	for (PermissionSetAssignment loopVar : userOfConsommationPS) 
                authorizedID=loopVar.AssigneeId;

    	options = new  Map<String,Object>();
    	options.put('iduser',authorizedID );
        boolean result2 = cls.invokeMethod('getPermissionSetInfo',inputMap, outMap, options);
        System.assertEquals(true, result2);

    
    
    	options = null;
        boolean result3 = cls.invokeMethod('getPermissionSetInfo',inputMap, outMap, options);
        System.assertEquals(true, result3);
}

}
/* AAR 24/01/2021 end*/