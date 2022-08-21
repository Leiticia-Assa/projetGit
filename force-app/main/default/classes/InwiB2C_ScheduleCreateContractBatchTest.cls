@istest
class InwiB2C_ScheduleCreateContractBatchTest{
	public static testMethod void testschedule() {
		Test.StartTest();
		InwiB2C_ScheduleCreateContractBulkBatch testsche = new InwiB2C_ScheduleCreateContractBulkBatch();
		String sch = '0 0 23 * * ?';
		system.schedule('Test status Check', sch, testsche );
		Test.stopTest();
        
	}
}