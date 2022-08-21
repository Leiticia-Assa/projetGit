global with sharing class InwiB2C_AssignCaseToProfile implements vlocity_cmt.VlocityOpenInterface {


    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
			
        Boolean result = true;
			
        try{
			
            if(methodName.equals('AssignCase')){
                System.debug('Success! the method ASSIGNCASE was called' );
                AssignCase(inputMap, outMap, options);

			
            }else if(methodName.equals('AssignCaseToUser')){
                System.debug('Success! the method ASSIGNCASETOUSER was called' );
                AssignCaseToUser(inputMap, outMap, options); 
             } else if(methodName.equals('getUsersByCaseId')){
                System.debug('Success! the method getUsersByCaseId was called' );
                getUsersByCaseId(inputMap, outMap, options); 
             } else{
			
			
            }                              
			
        } catch(Exception e){System.debug('An unexpected error has occurred: ' + e.getMessage());result = false;
			        
        }
			 
        return result;
			      
   }


    public static void AssignCase(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
            

        String IdCase =  (String)options.get('IdCase'); System.debug(IdCase);
        String QueueInput =  (String)options.get('QueueInput'); System.debug(QueueInput);
        String QueueName =  (String)options.get('QueueNameInput'); System.debug(QueueName);
        String idQueue;


        Case[] CurrentCase = [SELECT OwnerId, id, Inwib2c_Cat_gorie__c, Inwib2c_la_file_d_attente_d_origine__c,Inwib2c_la_file_d_attente__c, Inwib2c_id_file_d_attente_d_origine__c, Inwib2c_id_la_file_d_attente__c, Status, Depacement_OLA__c, InwiB2C_LastEscaladeDate__c, InwiB2C_Sous_DMT1__c, InwiB2C_Sous_DMT2__c, InwiB2C_Sous_DMT3__c FROM Case WHERE Id = :IdCase ];
        if (CurrentCase.size() > 0) 
        {
        String CaseCategory = CurrentCase[0].Inwib2c_Cat_gorie__c;
        //Group queueInputSelect = [SELECT ID, Name FROM GROUP WHERE ID=:QueueInput];

        //System.debug(queueInputSelect);

        //Calcul sous DMT
        if (CurrentCase[0].InwiB2C_LastEscaladeDate__c != NULL )
        {
            DateTime DateToday = DateTime.now();
            decimal Sous_DMT = ((DateToday.getTime())/1000/60/60) - ((CurrentCase[0].InwiB2C_LastEscaladeDate__c.getTime())/1000/60/60);
            
        if (CurrentCase[0].InwiB2C_Sous_DMT3__c == NULL )
        {
            if (CurrentCase[0].InwiB2C_Sous_DMT2__c == NULL)
            {
                if (CurrentCase[0].InwiB2C_Sous_DMT1__c == NULL)
                    CurrentCase[0].InwiB2C_Sous_DMT1__c = Sous_DMT;
                else
                    CurrentCase[0].InwiB2C_Sous_DMT2__c = Sous_DMT;
            }
            else
                CurrentCase[0].InwiB2C_Sous_DMT3__c = Sous_DMT;
        }

        }

        CurrentCase[0].InwiB2C_LastEscaladeDate__c = DateTime.now();

        try {
            System.debug('try');

            boolean IsQueueFound = [SELECT COUNT() FROM BOLevel2Profiles__c WHERE QueueInput__c = :QueueName] > 0;
        
            //If the queue is present in the BO table
            if (IsQueueFound){
                boolean IsCategoryFound = [ Select COUNT() from BOLevel2Profiles__c where QueueInput__c = :QueueName AND Category__c = :CaseCategory] > 0;
                if (IsCategoryFound){
                    //Get the queueOutput's profile
                    //String ProfileQueue = [ select INWI_B2C_PROFIL_FILE__c from INWI_B2C_PROFIL_FILE__c where INWIB2C_FILE_USER__c=:QueueOutput limit 1].INWI_B2C_PROFIL_FILE__c;
                    BOLevel2Profiles__c QueueOutput = [ Select QueueOutput__c,QueueOutputId__c  from BOLevel2Profiles__c where QueueInput__c = :QueueName AND Category__c = :CaseCategory LIMIT 1];
                   // Group queueOutPutSelect = [SELECT ID, Name FROM GROUP WHERE Name=:QueueOutput];
                    String IdQueueOutput = QueueOutput.QueueOutputId__c;
                    String QueueOutPutName = QueueOutput.QueueOutput__c;

                    idQueue = IdQueueOutput.substring(0,IdQueueOutput.length()-3);
                    CurrentCase[0].OwnerId =  idQueue;
                    CurrentCase[0].Inwib2c_la_file_d_attente_d_origine__c = CurrentCase[0].Inwib2c_la_file_d_attente__c;
                    CurrentCase[0].Inwib2c_id_file_d_attente_d_origine__c = CurrentCase[0].Inwib2c_id_la_file_d_attente__c;
                    CurrentCase[0].Inwib2c_la_file_d_attente__c = QueueOutPutName;
                    CurrentCase[0].Inwib2c_id_la_file_d_attente__c = idQueue;
                    }
                 else{
                    idQueue = QueueInput.substring(0,QueueInput.length()-3);
                    CurrentCase[0].OwnerId = idQueue;
                    CurrentCase[0].Inwib2c_la_file_d_attente_d_origine__c = CurrentCase[0].Inwib2c_la_file_d_attente__c;
                    CurrentCase[0].Inwib2c_id_file_d_attente_d_origine__c = CurrentCase[0].Inwib2c_id_la_file_d_attente__c;
                    CurrentCase[0].Inwib2c_la_file_d_attente__c = QueueName;
                    CurrentCase[0].Inwib2c_id_la_file_d_attente__c = idQueue;
                    CurrentCase[0].Depacement_OLA__c = false;
                 }

            }
            else
            {
                //Get the queueInput's profile
                //String ProfileQueue = [ select INWI_B2C_PROFIL_FILE__c from INWI_B2C_PROFIL_FILE__c where INWIB2C_FILE_USER__c=:QueueInput limit 1].INWI_B2C_PROFIL_FILE__c;
                idQueue = QueueInput.substring(0,QueueInput.length()-3);
                CurrentCase[0].OwnerId = idQueue;
                CurrentCase[0].Inwib2c_la_file_d_attente_d_origine__c = CurrentCase[0].Inwib2c_la_file_d_attente__c;
                CurrentCase[0].Inwib2c_id_file_d_attente_d_origine__c = CurrentCase[0].Inwib2c_id_la_file_d_attente__c;
                CurrentCase[0].Inwib2c_la_file_d_attente__c = QueueName;
                CurrentCase[0].Inwib2c_id_la_file_d_attente__c = idQueue;
                CurrentCase[0].Depacement_OLA__c = false;
            }
            CurrentCase[0].Status = 'InwiB2C_Escalade';
            outMap.put('EscaladeMessage', 'La Réclamation est bien affectée, vous pouvez fermer la fenêtre de la Réclamation.');
            update CurrentCase[0];
            


        }catch(DmlException e) {System.debug('An unexpected error has occurred: ' + e.getMessage()); outMap.put('EscaladeMessage', 'Il ne vous est pas possible de modifier l\'affectation de la Réclamation.');
        }
    }
        
    }

    // Method to assign the case to a user
    public static void AssignCaseToUser(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
            

        String IdCase =  (String)options.get('IdCase'); System.debug(IdCase);
        String QueueInput =  (String)options.get('QueueInput'); System.debug(QueueInput);

        Case CurrentCase = [SELECT OwnerId, id, Inwib2c_Cat_gorie__c, Inwib2c_la_file_d_attente_d_origine__c,Inwib2c_la_file_d_attente__c, Inwib2c_id_file_d_attente_d_origine__c, Inwib2c_id_la_file_d_attente__c  FROM Case WHERE Id = :IdCase LIMIT 1];

        User SelectedUser = [SELECT ID, Name FROM User WHERE ID=:QueueInput];

        System.debug(SelectedUser);


        try {
            System.debug('try');

                CurrentCase.OwnerId = SelectedUser.Id;
                CurrentCase.Status = 'InwiB2C_Escalade';

            update CurrentCase;
            outMap.put('EscaladeMessage', 'La Réclamation est bien affectée, vous pouvez fermer la fenêtre de la Réclamation.');


        }catch(DmlException e) {System.debug('An unexpected error has occurred: ' + e.getMessage()); outMap.put('EscaladeMessage', 'Il ne vous est pas possible de modifier l\'affectation de la Réclamation.');
        }
        
    }
     // Method to get the users who belong to to the assigned queue of the case
    public static void getUsersByCaseId(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        
        String OwnerId = '', ActualQueue, CaseQueue;
        String IdCase =  (String)options.get('IdCase'); System.debug(IdCase);
        List < Map < String, String >> UIoptions = new List < Map < String, String >> ();
        List<User> GroupUsersIds = [Select id from user];
        List<Group> RelatedGroupList = [Select RelatedId from Group];
        List<User> GroupUsersId;

        // Get the Case informations by ID
        Case[] CurrentCase = [Select Inwib2c_la_file_d_attente__c, Inwib2c_id_la_file_d_attente__c, OwnerId from Case where Id = :IdCase ];
        if (CurrentCase.size() > 0) {
            
         OwnerId = CurrentCase[0].OwnerId;
         ActualQueue = CurrentCase[0].Inwib2c_la_file_d_attente__c;
         CaseQueue = CurrentCase[0].Inwib2c_id_la_file_d_attente__c;
        }
        try{
        //If the OwnerId is a User, the case may be assigned to a user or queue
        if (((String)OwnerId).contains('005')){

        List<Groupmember> UserOrGroupList = [SELECT UserOrGroupId FROM Groupmember WHERE GroupId = :CaseQueue];
        List<Id> UsersIds = new List<Id>();

        for (Groupmember item: UserOrGroupList){
            //Case of a user: add it directly
            if (((String)item.UserOrGroupId).contains('005')){
                UsersIds.add(item.UserOrGroupId);
            }
            //Case of a role, add its users
            if (((String)item.UserOrGroupId).contains('00G')){
                String RelatedId;
                for (Group RelatedGroup: RelatedGroupList)
                {
                    if(item.UserOrGroupId == RelatedGroup.Id )
                    {
                        RelatedId = RelatedGroup.RelatedId;
                        break;
                    }
                }
                
                for (User UserItem : GroupUsersIds)
                {
                    if (UserItem.UserRoleId == RelatedId)
                    {
                        GroupUsersId.add(UserItem);
                    }
                }
                //String RelatedId = [Select RelatedId from Group where Id = :item.UserOrGroupId].RelatedId;
                //List<User> GroupUsersId = [Select id from user where UserRoleId =:RelatedId];
                for (User UserItem : GroupUsersId)
                    UsersIds.add(UserItem.id);
            }

        }

        List<User> AuthUsers = [SELECT id, name from user where id in : UsersIds  ];
        
        
        for (User  usr : AuthUsers) {
            Map<String, String> result= new Map<String, String>();
            result.put('value', usr.id);
            result.put('label', usr.name);
            UIoptions.add(result);
         }
        }
        
        outMap.put('IsCaseAssigned',CaseQueue );
        outMap.put('ActualQueue', ActualQueue);
        outMap.put('authusers', UIoptions);
    
    }catch(DmlException e) {System.debug('An unexpected error has occurred: ' + e.getMessage());
    }

    }
}