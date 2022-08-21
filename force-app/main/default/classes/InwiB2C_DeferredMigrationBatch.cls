public with sharing class InwiB2C_DeferredMigrationBatch implements Database.Batchable<sObject>, Database.AllowsCallouts {
  Integer daysBefore=3;  
  Date todayDate = system.today(); 
  // Date todayDate = Date.newInstance(2022,03,17);
  List<Integer> daysList = new List<Integer>{}; 
  public InwiB2C_DeferredMigrationBatch() 
    {
    }
    public Database.querylocator start(Database.BatchableContext bc){
		
       for (integer i = 0 ; i<=daysBefore; i++){
         Date migrationDate = todayDate.addDays(i); 
         Integer day = migrationDate.Day();
      // system.debug('day'+day);
         daysList.add(day);
      // system.debug('list'+daysList);
            
         } 
      
        return Database.getQueryLocator([SELECT Id, Cycle_de_facturation__c ,
                                         Statut__c, Orchestration_Item_Id__c,Orchestration_Item_Id__r.vlocity_cmt__State__c 
                                         FROM InwiB2C_MIGRATIONDIFF__c WHERE Cycle_de_facturation__c in:daysList 
                                         AND Statut__c=:'Waiting']);
    }
    public void execute(Database.BatchableContext bc, List<InwiB2C_MIGRATIONDIFF__c> scope){
        
        List<InwiB2C_MIGRATIONDIFF__c> migList =new List <InwiB2C_MIGRATIONDIFF__c>();
        List<vlocity_cmt__OrchestrationItem__c> orchestListP =new List <vlocity_cmt__OrchestrationItem__c>();
        List<vlocity_cmt__OrchestrationItem__c> orchestListC =new List <vlocity_cmt__OrchestrationItem__c>();
        for(InwiB2C_MIGRATIONDIFF__c migDiff : scope){
            migDiff.Statut__c = 'Completed';
            vlocity_cmt__OrchestrationItem__c statePending=new vlocity_cmt__OrchestrationItem__c (id = migDiff.Orchestration_Item_Id__c,vlocity_cmt__State__c = 'Pending');
            if(!orchestListP.contains(statePending)){
                orchestListP.add(statePending);
                update orchestListP;
            }
            vlocity_cmt__OrchestrationItem__c stateCompleted=new vlocity_cmt__OrchestrationItem__c (id = migDiff.Orchestration_Item_Id__c,vlocity_cmt__State__c = 'Completed');
            if(!orchestListC.contains(stateCompleted)){
                orchestListC.add(stateCompleted);
                update orchestListC;
            }
        }
	          Update migList;
            
    }
    public void finish(Database.BatchableContext bc){        
    }
}