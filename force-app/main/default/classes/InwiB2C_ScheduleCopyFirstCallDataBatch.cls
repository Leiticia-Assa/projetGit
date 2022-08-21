global class InwiB2C_ScheduleCopyFirstCallDataBatch implements Schedulable {
   global void execute(SchedulableContext sc) {
      InwiB2C_CopyFirstCallDataBatch b = new InwiB2C_CopyFirstCallDataBatch(); 
      database.executebatch(b,2000);
   }
}