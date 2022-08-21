@istest
class InwiB2C_ScheduleSubsMassProcessBatchTest{
	public static testMethod void testschedule() {
		Test.StartTest();
		InwiB2C_ScheduleSubsMassProcessingBatch testsche = new InwiB2C_ScheduleSubsMassProcessingBatch();
		String sch = '0 0 23 * * ?';
		system.schedule('Test status Check', sch, testsche );
		Test.stopTest();
        
	}
}