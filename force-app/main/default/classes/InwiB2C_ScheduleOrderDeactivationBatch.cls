public with sharing class InwiB2C_ScheduleOrderDeactivationBatch implements Schedulable {
   public void execute(SchedulableContext sc) {
      InwiB2C_OrderDeactivationBatch b = new InwiB2C_OrderDeactivationBatch(); 
      database.executebatch(b,200);
   }
}