public with sharing class InwiB2C_ScheduleCreateContractBulkBatch implements Schedulable {
   public void execute(SchedulableContext sc) {
      InwiB2C_CreateContractBulkBatch b = new InwiB2C_CreateContractBulkBatch(); 
      database.executebatch(b,100);
   }
}