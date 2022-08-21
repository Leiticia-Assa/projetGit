public with sharing class InwiB2C_SuspensionRehabDeFacturation{

        public String cin {get;set;}
        public String descriptif {get; set;}
        public String numcontact {get;set;}
        public String email {get;set;}
        public String MDN {get;set;}
        public String fullName {get;set;}
        public String POSCode {get;set;}
        public String Offre {get;set;}
        public String datedefacturation{get;set;}
        public string numDemande {get;set;}
    
     
        
        public InwiB2C_SuspensionRehabDeFacturation() {
            date dayString = date.today();
            datedefacturation = dayString.format();
            cin= Apexpages.currentPage().getParameters().get('cin');
            descriptif= Apexpages.currentPage().getParameters().get('descriptif');
            numcontact=Apexpages.currentPage().getParameters().get('numcontact');
            numDemande=Apexpages.currentPage().getParameters().get('numDemande');
            MDN = Apexpages.currentPage().getParameters().get('MDN');
            fullName = Apexpages.currentPage().getParameters().get('fullName'); 
            POSCode = Apexpages.currentPage().getParameters().get('POSCode'); 
            Offre = Apexpages.currentPage().getParameters().get('Offre'); 
            email = Apexpages.currentPage().getParameters().get('EMAIL');
               
        }
    }