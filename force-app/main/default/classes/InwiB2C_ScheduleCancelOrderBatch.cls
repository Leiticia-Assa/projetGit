global class InwiB2C_ScheduleCancelOrderBatch implements Schedulable {
   global void execute(SchedulableContext sc) {
      InwiB2C_CancelOrderBatch b = new InwiB2C_CancelOrderBatch(); 
      database.executebatch(b);
   }
}