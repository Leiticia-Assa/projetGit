global class InwiB2C_ScheduleActivationOrderBatch implements Schedulable {
    global void execute(SchedulableContext sc) {
        InwiB2C_RattrapageActivationOrderBatch b = new InwiB2C_RattrapageActivationOrderBatch(); 
        database.executebatch(b,100);
        
     }
}