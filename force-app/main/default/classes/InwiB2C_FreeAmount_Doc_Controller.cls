public class InwiB2C_FreeAmount_Doc_Controller {
    
    
        public String DateTransaction {get;set;}
    	public String NumTransaction {get;set;}
        public String CIN {get; set;}
        public String Nom {get;set;}
        public String Prenom {get;set;}
        public String Quartier {get;set;}
        public String Ville {get;set;}
        public String Pays {get;set;}
        public String CodePointDeVente {get;set;}
        public String CodeAgent {get;set;}
        public String BillingAccount {get;set;}
    	public String ModeDePaiement{get;set;}
        public String TotalAmount{get;set;}
        public String ReferenceDePaiement{get;set;}
        public String NumeroDeTransaction{get;set;}
    
    
    public InwiB2C_FreeAmount_Doc_Controller() {
            date dayString = date.today();
            DateTransaction = dayString.format();
        	NumTransaction=Apexpages.currentPage().getParameters().get('NumTransaction');
            CIN= Apexpages.currentPage().getParameters().get('CIN');
            Nom= Apexpages.currentPage().getParameters().get('Nom');
            Prenom=Apexpages.currentPage().getParameters().get('Prenom');
            CodePointDeVente = Apexpages.currentPage().getParameters().get('CodePointDeVente');
            CodeAgent = Apexpages.currentPage().getParameters().get('CodeAgent'); 
            BillingAccount = Apexpages.currentPage().getParameters().get('BillingAccount'); 
            ModeDePaiement = Apexpages.currentPage().getParameters().get('ModeDePaiement'); 
            TotalAmount = Apexpages.currentPage().getParameters().get('TotalAmount'); 
            ReferenceDePaiement = Apexpages.currentPage().getParameters().get('ReferenceDePaiement'); 
            NumeroDeTransaction = Apexpages.currentPage().getParameters().get('NumeroDeTransaction');
            Quartier = Apexpages.currentPage().getParameters().get('Quartier'); 
            Ville = Apexpages.currentPage().getParameters().get('Ville'); 
            Pays = Apexpages.currentPage().getParameters().get('Pays'); 


       
      }
}