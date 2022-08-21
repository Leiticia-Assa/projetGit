public with sharing class InwiB2C_ModificationMigration_Controller {
        public String name {get;set;}
    	public String cin {get;set;}
        public String mdn {get; set;}
        public String offre {get;set;}
        public String poscode {get;set;}
        public String numcomm {get;set;}
        public String oldoffer {get;set;}
        public String oldmontant {get;set;}
        public String newmontant {get;set;}
    	public String datedefacturation{get;set;}
        public String typeModification{get;set;}

    

    
    
    public InwiB2C_ModificationMigration_Controller() {
            date dayString = date.today();
            datedefacturation = dayString.format();
        	name=Apexpages.currentPage().getParameters().get('name');
            cin= Apexpages.currentPage().getParameters().get('cin');
            mdn= Apexpages.currentPage().getParameters().get('mdn');
            offre=Apexpages.currentPage().getParameters().get('offre');
            poscode=Apexpages.currentPage().getParameters().get('poscode');
            numcomm = Apexpages.currentPage().getParameters().get('numcomm');
            oldoffer = Apexpages.currentPage().getParameters().get('oldoffer'); 
            oldmontant = Apexpages.currentPage().getParameters().get('oldmontant'); 
            newmontant = Apexpages.currentPage().getParameters().get('newmontant'); 
            typeModification = Apexpages.currentPage().getParameters().get('typeModification'); 


       
      }

    }