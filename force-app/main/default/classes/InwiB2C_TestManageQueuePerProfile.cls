@isTest
public class InwiB2C_TestManageQueuePerProfile {
    
 @isTest
   	static void TestManageQueues()
{

   InwiB2C_manageQueuePerProfile cls = new InwiB2C_manageQueuePerProfile(); 
   
    //List<Profile> profiles= new List<Profile>();
	List<Profile> profiles = InwiB2C_manageQueuePerProfile.getProfilesList();
    System.debug(profiles);
    
    List<Group> groupes = new List<Group>();
    groupes = InwiB2C_manageQueuePerProfile.getQueuesList();
    System.debug(groupes);
    
     List<Group> groupesbyprofiles = new List<Group>();
    groupesbyprofiles = InwiB2C_manageQueuePerProfile.getQueuesByProfile('SC Agents BO réclamation N2');
    System.debug(groupesbyprofiles);
    
    List<String> queueslist = new list<String> { 'BO Réclamation Couverture'};
    
    boolean result = InwiB2C_manageQueuePerProfile.InsertProfileQueues('SC Agents BO réclamation N2', queueslist);
	System.assertEquals(true, result);

}}