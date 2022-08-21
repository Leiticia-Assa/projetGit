global class InwiB2C_ScheduleSubsMassProcessingBatch implements Schedulable {
   global void execute(SchedulableContext sc) {
      InwiB2C_SubsMassProcessingBatch b = new InwiB2C_SubsMassProcessingBatch(); 
      database.executebatch(b, 2000);
   }
}