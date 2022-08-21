public class InwiB2C_CloseCases {
    public List<Case> CasesList {get;set;}
    public ApexPages.StandardSetController standardController;
    private Set<Id> casesIds = new Set<Id>();
    public Boolean RightToClose {get;set;}

    public InwiB2C_CloseCases(ApexPages.StandardSetController standardController){
        List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
        String MyProflieName = PROFILE[0].Name;
        //String ProfileId = userinfo.getProfileId();
        RightToClose = false;
        if (MyProflieName.equals('System Administrator') || MyProflieName.equals('Administrateur système') || MyProflieName.equals('SC Superviseur BO CRC Int')){
        
            this.standardController = standardController;
            CasesList = new List<Case>();
            for (Case mem : (List<Case>)standardController.getSelected()){ 
                casesIds.add(mem.Id);
            }
            
            CasesList = [SELECT Id, Casenumber FROM Case WHERE ID IN: casesIds FOR UPDATE];
            if (!CasesList.isEmpty()){
                RightToClose = true;
            }
    }

    }

    Public PageReference CloseCases()
    {
        //Save the data here
        for (Case mem : CasesList){ 
            mem.status = 'InwiB2C_Resolu';
        }
         update CasesList;
        Pagereference pr = new Pagereference('/lightning/o/Case/list');
        pr.setRedirect(true);
        return pr;
    }

    Public PageReference CancelAction()
    {
        Pagereference pr = new Pagereference('/lightning/o/Case/list');
        pr.setRedirect(true);
        return pr;
    }
}