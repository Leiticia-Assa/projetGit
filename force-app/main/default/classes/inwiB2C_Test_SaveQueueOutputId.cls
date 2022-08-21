@isTest 
public class inwiB2C_Test_SaveQueueOutputId {
    @isTest(SeeAllData=true)

    Static void testMethod2(){
        List <Group> queueList =  [SELECT Id, Name, DeveloperName FROM Group WHERE Type = 'Queue'];
   Map<String,String> queueByNameMap = new Map<String,String> ();

                
   for (Group queue:queueList){

        if (!queueByNameMap.containsKey(queue.Name) ){
            queueByNameMap.put(queue.Name, queue.Id);
        }
   }
      
        BOLevel2Profiles__c BOlevel=new BOLevel2Profiles__c(QueueInput__c='BO Réclamation B2C',
                         Category__c='Inwib2c_Facturation_Reclamation',QueueOutput__c='BO Réclamation Facturation');
        inwiB2C_ProfileQueueMgt__c ProfileQue= new inwiB2C_ProfileQueueMgt__c(inwiB2C_Queue__c ='BO Réclamation B2C',inwiB2C_Profile__c ='SC Agent VIP Int');

 Test.startTest();
			try{
insert BOlevel;
                insert ProfileQue;
			}
			Catch(Exception ee){
			}	
         Test.stopTest();        
        
    }
}