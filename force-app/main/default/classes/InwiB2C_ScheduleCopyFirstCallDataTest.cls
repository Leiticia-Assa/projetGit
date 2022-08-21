@istest
class InwiB2C_ScheduleCopyFirstCallDataTest{
	public static testMethod void testschedule() {
		Test.StartTest();
		InwiB2C_ScheduleCopyFirstCallDataBatch testsche = new InwiB2C_ScheduleCopyFirstCallDataBatch();
		String sch = '0 0 23 * * ?';
		system.schedule('Test status Check', sch, testsche );
		Test.stopTest();
        
	}
}