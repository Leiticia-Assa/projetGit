global with sharing  class inwB2C_getQueueByProfile    implements vlocity_cmt.VlocityOpenInterface {


    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
			
        Boolean result = true;
			
        try{
			
            if(methodName.equals('getQueuesForUser')){
                getQueuesForUser(inputMap, outMap, options);
			
             // your implementation, use outMap to send response back to OmniScript                                                                  
			
            }else {}

			
        } catch(Exception e){ result = false;
			        
        }
			 
        return result;
			      
   }


    public static void getQueuesForUser(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
            
        
        //String inputString = JSON.serialize(inputMap);

        //System.debug(inputString);

        String profilId = UserInfo.getProfileId();
        Profile profile = [SELECT Name from Profile WHERE Id = :profilId LIMIT 1];

        List<Group> queues = getQueuesByProfile (profile.Name);

        List < Map < String, String >> queueList = new List < Map < String, String >> ();


        for (Group queue : queues){

            Map<String,String> queueItem = new  Map<String,String>();

            queueItem.put('value', queue.id);
            queueItem.put('label', queue.name);

            queueList.add(queueItem);

        }

        System.debug(queueList);

        outMap.put('options',queueList );



    }
    //Get the queues available to the profil of the connected user
    private static List<Group> getQueuesByProfile(string Profile){

        List<String> myIds = new List<String>();

        List <inwiB2C_ProfileQueueMgt__c> initialListOfProfileQueues = [SELECT Id, inwiB2C_Queue__c, inwiB2C_Profile__c FROM inwiB2C_ProfileQueueMgt__c WHERE inwiB2C_Profile__c=:Profile];
        
        for (inwiB2C_ProfileQueueMgt__c  tfr : initialListOfProfileQueues) {
            myIds.add(tfr.inwiB2C_Queue__c); }

        return [SELECT Id, Name FROM Group WHERE Name in : myIds];
    }


}