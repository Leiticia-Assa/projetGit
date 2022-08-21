/*B-0611 ZME 29.01.2021 BEGIN*/
public class inwib2c_MilestoneUtils{
    public static void completeMilestone(List<Id> caseIds, DateTime complDate){  
        List<CaseMilestone> cmsToUpdate = [select Id, completionDate
                                           from CaseMilestone cm
                                           where caseId in :caseIds and completionDate = null];
        if (cmsToUpdate.isEmpty() == false){
            for (CaseMilestone cm : cmsToUpdate){
                cm.completionDate = complDate;
            }
            update cmsToUpdate;
        }
    }
        public static void completeMilestoneola(List<Id> caseIds, DateTime complDate){  
        List<CaseMilestone> cmsToUpdate = [select Id, completionDate
                                           from CaseMilestone cm
                                           where caseId in :caseIds and cm.MilestoneType.Name not in ('SLA Milestone')
                                            and completionDate = null]; 
        if (cmsToUpdate.isEmpty() == false){
            for (CaseMilestone cm : cmsToUpdate){
                cm.completionDate = complDate;
            }
            update cmsToUpdate;
        }
    }
}
/*B-0611 ZME 29.01.2021 END*/