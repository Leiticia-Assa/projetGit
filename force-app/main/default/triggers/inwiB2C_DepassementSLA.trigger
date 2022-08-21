trigger inwiB2C_DepassementSLA on Case (after update) {
    Map<Id, Case> caseOldMap = Trigger.oldMap;
    List<FeedItem> FeedItemList = New List<FeedItem>();
    List<Task> taskList = new List<Task> ();
    /*B-0611 ZME 29.01.2021 BEGIN*/
    List<Id> updateCasesCompleteMilestone = new List<Id>();
    List<Id> updateCasesCompleteMilestoneola = new List<Id>();
    List<Id> updateCasesReOpenMilestone = new List<Id>();
    DateTime completionDate = System.now();
    /*B-0611 ZME 29.01.2021 END*/
    for(Case caseNew:Trigger.new)
    {        
        Case oldCase = caseOldMap.get(caseNew.Id);
        /*B-0611 ZME 29.01.2021 BEGIN*/
        if (((caseNew.isClosed == true)||(caseNew.Status == 'InwiB2C_Resolu')||(caseNew.Status == 'InwiB2C_Annule')) && ((caseNew.SlaStartDate <= completionDate) && (caseNew.SlaExitDate == null)) && oldCase.IsClosed == False) {
            updateCasesCompleteMilestone.add(caseNew.Id);
        }
        /*B-0611 ZME 29.01.2021 END*/
        /*B-0926 HMI 04.03.2021 BEGIN*/
          if (((caseNew.Inwib2c_la_file_d_attente__c!= oldCase.Inwib2c_la_file_d_attente__c) && 
           (oldCase.Inwib2c_la_file_d_attente__c!=null)) &&
          ((caseNew.SlaStartDate <= completionDate) && (caseNew.SlaExitDate == null)) && oldCase.IsClosed == False) {
            updateCasesCompleteMilestoneola.add(caseNew.Id);
        }
        /*B-0926 HMI 04.03.2021 END*/
        
        
        if (caseNew.Depassement_SLA__c  && !oldCase.Depassement_SLA__c &&(((String)caseNew.OwnerId).contains('005')) ) {
            User user = [Select ManagerId from User where Id = :caseNew.ownerId ];
            String parentNotification = (user.ManagerId !=null)? user.ManagerId: caseNew.ownerId;
            System.debug(user.ManagerId);
            /*FeedItem post = new FeedItem();
            post.ParentId = parentNotification;
            post.Body = 'Le Case suivant est de dépassement de SLA';
            post.Title = 'Case';
            post.LinkUrl = '/lightning/r/Case/' + caseNew.ID + '/view';
            FeedItemList.add(post);*/
            Task newTask = new Task ();
            newTask.WhatId = caseNew.Id;
            newTask.Subject = 'Le Case suivant est de dépassement de SLA';
            newTask.Status = 'Open';
            newTask.Priority = 'High';
            newTask.OwnerId = parentNotification;
            taskList.add(newTask);
        }
    }
    /*if (FeedItemList.size()>0) {         
    insert FeedItemList;                
    }*/
    if (taskList.size()>0){
        insert taskList;
    }
    /*B-0611 ZME 29.01.2021 BEGIN*/
    if (updateCasesCompleteMilestone.isEmpty() == false){
        inwib2c_milestoneUtils.completeMilestone(updateCasesCompleteMilestone, completionDate);
    }
    /*B-0611 ZME 29.01.2021 END*/
    
    /*B-0926 HMI 04.03.2021 BEGIN*/
    if (updateCasesCompleteMilestoneola.isEmpty() == false){
        inwib2c_milestoneUtils.completeMilestoneola(updateCasesCompleteMilestoneola, completionDate);
    }
   /*B-0926 HMI 04.03.2021 END*/
        

}