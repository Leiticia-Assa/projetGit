/*B-0611 ZME 29.01.2021 BEGIN*/
@isTest
Public class inwib2c_MilestoneUtilsTest {
    @isTest
    static void TestCompleteMilestoneCase(){
        Account busAcc = new Account(Name='TestForMS',
                                     phone='4567890999');
        insert busAcc;
        Contact cont = new Contact(FirstName = 'Test',
                                   LastName = 'LastName',
                                   phone='4567890999',
                                   accountid = busAcc.id);
        insert(cont);
        Id contactId = cont.Id;
        Entitlement entl = new Entitlement(Name='TestEntitlement',
                                           AccountId=busAcc.Id);
        insert entl;
        String entlId;
        if (entl != null)
            entlId = entl.Id;
        List<Case> cases = new List<Case>{};
            if (entlId != null){
                Case c = new Case(Subject = 'Test Case with Entitlement ', 
                                  EntitlementId = entlId,
                                  ContactId = contactId);
                cases.add(c);
            }
        if (cases.isEmpty()==false){
            insert cases;
            List<Id> caseIds = new List<Id>();
            for (Case cL : cases){
                caseIds.add(cL.Id);
            }
            inwib2c_MilestoneUtils.completeMilestone(caseIds, System.now());
            inwib2c_MilestoneUtils.completeMilestoneola(caseIds, System.now());
        }
    }
}
/*B-0611 ZME 29.01.2021 END*/