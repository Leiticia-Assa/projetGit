global with sharing  class InwiB2C_manageQueuePerProfile {
    
    // Method to retrieve List of available Profiles 
    @AuraEnabled (cacheable=true)
    global static List<Profile> getProfilesList(){
        return [SELECT Id, Name FROM Profile LIMIT 100];
    }

    // Method to retrieve List of available Queues 
    @AuraEnabled (cacheable=true)
    global static List<Group> getQueuesList(){
        return [SELECT Id, Name, DeveloperName FROM Group WHERE Type = 'Queue' LIMIT 100];
    }


    // Method to inster available Queues for a profile 
    @AuraEnabled
    public static Boolean InsertProfileQueues(String Profile, List<String> Queues){
        try {

            // Get list of existing Queues for a Profile
            List <inwiB2C_ProfileQueueMgt__c> initialListOfProfileQueues = [SELECT Id, inwiB2C_Queue__c, inwiB2C_Profile__c FROM inwiB2C_ProfileQueueMgt__c WHERE inwiB2C_Profile__c=:Profile];
            // Delete existing Queues for a Profile
            delete initialListOfProfileQueues;

            // New List of Queues per Profile
            List <inwiB2C_ProfileQueueMgt__c>  newListOfProfileQueues = new  List <inwiB2C_ProfileQueueMgt__c> ();

            for (String queue:Queues ){

                inwiB2C_ProfileQueueMgt__c newProfileQueue = new inwiB2C_ProfileQueueMgt__c();
                newProfileQueue.inwiB2C_Profile__c = Profile;
                newProfileQueue.inwiB2C_Queue__c = queue;

                newListOfProfileQueues.add(newProfileQueue);
                
            }

            System.debug(newListOfProfileQueues);

            insert newListOfProfileQueues;
            return true;


        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());

        }

    }

    // Method to retrieve configured Queues per Profile
    @AuraEnabled
    global static List<Group> getQueuesByProfile(string Profile){

        // Get list of existing Queues for a Profile
        List <inwiB2C_ProfileQueueMgt__c> initialListOfProfileQueues = [SELECT Id, inwiB2C_Queue__c, inwiB2C_Profile__c FROM inwiB2C_ProfileQueueMgt__c WHERE inwiB2C_Profile__c=:Profile];

        
        List<String> myIds = new List<String>();

        
        for (inwiB2C_ProfileQueueMgt__c  profileQueue : initialListOfProfileQueues) {
            myIds.add(profileQueue.inwiB2C_Queue__c); 
        }

        return [SELECT Id, Name FROM Group WHERE Name in : myIds];
    }
}