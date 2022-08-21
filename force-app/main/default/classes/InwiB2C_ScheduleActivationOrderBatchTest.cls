@istest
class InwiB2C_ScheduleActivationOrderBatchTest{
	public static testMethod void testschedule() {
		Test.StartTest();
		InwiB2C_ScheduleActivationOrderBatch testsche = new InwiB2C_ScheduleActivationOrderBatch();
		String sch = '0 0 23 * * ?';
		system.schedule('Test status Check', sch, testsche );
		Test.stopTest();
        
	}
}