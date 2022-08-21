@istest
class InwiB2C_ScheduleCancelOrderBatchTest{
	public static testMethod void testschedule() {
		Test.StartTest();
		InwiB2C_ScheduleCancelOrderBatch testsche = new InwiB2C_ScheduleCancelOrderBatch();
		String sch = '0 0 23 * * ?';
		system.schedule('Test status Check', sch, testsche );
		Test.stopTest();
        
	}
}