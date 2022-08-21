import { LightningElement, wire , track  } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import template from './inwiB2C_OffreDisplay.html';
import getoffres from '@salesforce/apex/InwiB2C_Offre.getOffres';
import { refreshApex } from '@salesforce/apex';

export default class InwiB2C_OffreDisplay extends NavigationMixin(LightningElement) {


    @track dated_offre=null;
    @track datef_offre=null;
    @track offres;
    @track wiredOffresList;
    error;

    columns = [
        { label: 'Promo', fieldName: 'Name',initialWidth: 150 },
        { label: 'Résumé de la promo', fieldName: 'Inwib2c_Detail_de_l_offre__c', initialWidth: 300},
        { label: 'Statut actuel', fieldName: 'InwiB2C_Statut_Offre__c', initialWidth: 125 , cellAttributes:
        { iconName: { fieldName: 'inwiB2C_Icon' }, iconPosition: 'left' }},
        { label: 'Date de début', fieldName: 'Inwib2c_Date_de_d_but__c',initialWidth: 130, type: "date", typeAttributes:{
            year: "numeric",
            month: "2-digit",
            day: "2-digit"
        }},
        {label: 'Date de fin ',fieldName: 'Inwib2c_Date_de_fin__c',initialWidth: 130, type: "date", typeAttributes:{
            year: "numeric",
            month: "2-digit",
            day: "2-digit"
        }},
        {label: 'Détails',initialWidth: 75, type: "button-icon", typeAttributes: { label: "Voir Details", name: "view_details", title: 'Click to View Details', iconName: 'utility:link'},  hideDefaultActions: true , editable: false}
    ];

    @wire(getoffres, {dated_offre:'$dated_offre',datef_offre:'$datef_offre'}) offreReply(result) {
        this.wiredOffresList = result;
        if (result.data) {
            this.offres = result.data;

       
        } else if (result.error) {
            this.error = result.error;
        }
    }
   
    get records (){

        let result = [];

        
        if (this.offres ) { 

            this.offres.forEach(offre => {

                let newOffre = {
                    Name: offre.Name,
                    Inwib2c_Detail_de_l_offre__c: offre.Inwib2c_Detail_de_l_offre__c,
                    InwiB2C_Statut_Offre__c: offre.InwiB2C_Statut_Offre__c,
                    Inwib2c_Date_de_d_but__c: offre.Inwib2c_Date_de_d_but__c,
                    Inwib2c_Date_de_fin__c: offre.Inwib2c_Date_de_fin__c,
                    Id: offre.Id
     
                }

                if (offre.InwiB2C_Statut_Offre__c == 'Active'){
                    newOffre.inwiB2C_Icon = 'custom:custom33';
                }else {
                    newOffre.inwiB2C_Icon = 'custom:custom109';
                }
           
                result.push (newOffre);

            });
        }

        return result;

   }

 
    render(){
        return template;
    }

    searchOffred(event){        
        this.dated_offre = event.target.value;
   
    }
    searchOffref(event){        
        this.datef_offre = event.target.value;     
    }

    refreshData(){
        console.log('in refresh data');

        return refreshApex(this.wiredOffresList);
    }
 

    handleRowAction(event){
        
        const action = event.detail.action;
        const row = event.detail.row;
        switch (action.name) {
            case 'view_details':
                console.log ('button clicked');
                console.log(row.Id);
                this.navigateToRecordPage('inwib2c_Offre__c',row.Id );
                break;
            default:
                console.log('nothing');
                break;
        }
    }
    
    navigateToRecordPage(sObject, recordId) {
        console.log(recordId);
        
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                actionName: 'view'
            }
        });
    }

    connectedCallback() {       
        // Register error listener       
        
    }
    renderedCallback(){

    }
  
}