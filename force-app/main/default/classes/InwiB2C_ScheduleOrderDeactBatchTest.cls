@istest
class InwiB2C_ScheduleOrderDeactBatchTest{
	public static testMethod void testschedule() {
		Test.StartTest();
		InwiB2C_ScheduleOrderDeactivationBatch testsche = new InwiB2C_ScheduleOrderDeactivationBatch();
		String sch = '0 0 23 * * ?';
		system.schedule('Test status Check', sch, testsche );
		Test.stopTest();
        
	}
}