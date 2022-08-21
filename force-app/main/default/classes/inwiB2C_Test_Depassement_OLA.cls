/*B-0162 RMA 01/01/2021 BEGIN*/
@isTest 
public class inwiB2C_Test_Depassement_OLA 
{
    @isTest Static void testMethod1()
    {
        //User user = [Select ManagerId from User where Id = '0052z000000Qco7AAC '];
        
        case c =new case(Type='Inwib2c_Reclamation',
                         Description='A',
                         Subject='B',
                         origin='C',
                         status ='Ouvert',
                         InwiB2C_TypeSpecialite__c='InwiB2C_Roaming',
                         Inwib2c_Cat_gorie__c='Inwib2c_Reseau_Reclamation');
        insert c;
        /*B-0611 ZME 03.02.2021 BEGIN*/
        //c.status  = 'Résolu';
        c.status = 'InwiB2C_Resolu';
        /*B-0611 ZME 03.02.2021 END*/
        c.Depacement_OLA__c=true;
        c.Depassement_SLA__c=true;
        update c;
        string idowner= c.ownerId;
        String parentNotification = c.ownerId;
        List<Task> taskList = new List<Task> ();
        Task t = new task(ActivityDate=date.today(),OwnerId=parentNotification,subject='Le Case suivant est de dépassement de OLA', WhoId=c.Id, Status='Open',Priority='High');
        Test.startTest();
        try{
            insert t;
            taskList.add(t);
            insert taskList;
        }
        Catch(Exception ee){
        }	
        Test.stopTest();
    }
}
/*B-0162 RMA 01/01/2021 END*/