global class inwiB2C_ScheduleUpdateInvoicSuspenBatch implements Schedulable {
global void execute(SchedulableContext sc) {
      inwiB2C_UpdateInvoicingSuspensionBatch b = new inwiB2C_UpdateInvoicingSuspensionBatch(3); 
      database.executebatch(b, 2000);
   }
}