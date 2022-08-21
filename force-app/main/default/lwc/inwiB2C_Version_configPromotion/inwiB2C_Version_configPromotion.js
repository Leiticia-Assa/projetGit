// apexContactsForAccount.js
import { LightningElement, wire, api } from 'lwc';
import get_scop_determinant from '@salesforce/apex/InwiB2C_ManageConfPromotionLWC.get_scop_determinant';
import { refreshApex } from '@salesforce/apex';
import { updateRecord } from 'lightning/uiRecordApi';

// import { ShowToastEvent } from 'lightning/platformShowToastEvent';
// import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
// import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
// import ID_FIELD from '@salesforce/schema/Contact.Id';

import updateContacts from '@salesforce/apex/InwiB2C_ManageConfPromotionLWC.updateContacts';
import { getRecordNotifyChange } from 'lightning/uiRecordApi';

// import scope determinant object;

import SCOPE_DETERMINANT_OBJECT from '@salesforce/schema/inwiB2C_scop_determinant__c'
import CANAL_FIELD from '@salesforce/schema/inwiB2C_scop_determinant__c.inwiB2C_Canal__c'
import TYPE_ACTE_GESTION_FIELD from '@salesforce/schema/inwiB2C_scop_determinant__c.InwiB2C_type_acte_de_gestion__c'
import TYPE_D_INCLUSION_FIELD from '@salesforce/schema/inwiB2C_scop_determinant__c.InwiB2C_Type_d_inclution__c'



// const COLS = [
//     { label: 'First Name', fieldName: 'FirstName', editable: true },
//     { label: 'Last Name', fieldName: 'LastName', editable: true },
//     { label: 'Title', fieldName: 'Title' },
//     { label: 'Phone', fieldName: 'Phone', type: 'phone' },
//     { label: 'Email', fieldName: 'Email', type: 'email' }
// ];


//Les action dans chaque ligne
actions_scope_determinant = [
    { label: 'Show details', name: 'show_details' },
    { label: 'Delete', name: 'delete' }
];
scope_determinant_columns = [
    { label: "Name", fieldName: "Name", hideDefaultActions: true },
    { label: "Canal", fieldName: "inwiB2C_Canal__c", hideDefaultActions: true },
    { label: "Type Acte de gestion", fieldName: "InwiB2C_type_acte_de_gestion__c", hideDefaultActions: true },
    { label: "Type d'inclusion", fieldName: "InwiB2C_Type_d_inclution__c", hideDefaultActions: true },
    {
        type: 'action',
        typeAttributes: { rowActions: this.actions_scope_determinant },
        hideDefaultActions: true
    }
];
export default class InwiB2C_Version_configPromotion extends LightningElement {

    @api recordId;
    columns = scope_determinant_columns;
    draftValues = [];

    @wire(get_scop_determinant, {  idPromotion: '$recordId' })
    promotion;

    // handleSave(event) {

    //     const fields = {}; 
    //     fields[CANAL_FIELD.fieldApiName] = event.detail.draftValues[0].inwiB2C_Canal__c;
    //     fields[TYPE_ACTE_GESTION_FIELD.fieldApiName] = event.detail.draftValues[0].InwiB2C_type_acte_de_gestion__c;
    //     fields[TYPE_D_INCLUSION_FIELD.fieldApiName] = event.detail.draftValues[0].InwiB2C_Type_d_inclution__c;

    //     const recordInput = {fields};

    //     updateRecord(recordInput)
    //     .then(() => {
    //         this.dispatchEvent(
    //             new ShowToastEvent({
    //                 title: 'Success',
    //                 message: 'Contact updated',
    //                 variant: 'success'
    //             })
    //         );
    //         // Display fresh data in the datatable
    //         return refreshApex(this.promotion).then(() => {

    //             // Clear all draft values in the datatable
    //             this.draftValues = [];

    //         });
    //     }).catch(error => {
    //         this.dispatchEvent(
    //             new ShowToastEvent({
    //                 title: 'Error updating or reloading record',
    //                 message: error.body.message,
    //                 variant: 'error'
    //             })
    //         );
    //     });
    // }




    async handleSave(event) {
        const updatedFields = event.detail.draftValues;
        
        // Prepare the record IDs for getRecordNotifyChange()
        const notifyChangeIds = updatedFields.map(row => { return { "recordId": row.Id } });
    
        try {
            // Pass edited fields to the updateContacts Apex controller
            const result = await updateContacts({data: updatedFields});
            console.log(JSON.stringify("Apex update result: "+ result));
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Contact updated',
                    variant: 'success'
                })
            );
    
            // Refresh LDS cache and wires
            getRecordNotifyChange(notifyChangeIds);
    
            // Display fresh data in the datatable
            refreshApex(this.promotion).then(() => {
                // Clear all draft values in the datatable
                this.draftValues = [];
            });
       } catch(error) {
               this.dispatchEvent(
                   new ShowToastEvent({
                       title: 'Error updating or refreshing records',
                       message: error.body.message,
                       variant: 'error'
                   })
             );
        };
    }

}




























// import { LightningElement, api, wire } from 'lwc';

// import { getRecord, getFieldValue } from 'lightning/uiRecordApi';


// // import Promotion objects fields 

// import PROMOTION_OBJECT from '@salesforce/schema/InwiB2C_Promotion__c';
// import  NAME_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.Name";
// import  TYPE_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.InwiB2C_Type_promotion__c";
// import  CODE_PRODUIT_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.inwiB2C_Code_Produit__c";
// import  CODE_PROMOTION_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.inwiB2C_code_promotion__c";
// import  DATE_FIN_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.inwiB2C_date_fin__c";
// import  DATE_DEBUT_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.InwiB2C_date_Debut__c";

// // import methode in to class manageconfPromotion 

//  import get_applied_product from '@salesforce/apex/InwiB2C_Version2_ManageConfPromotionLWC.get_applied_product';
//  import get_promotion_result from '@salesforce/apex/InwiB2C_Version2_ManageConfPromotionLWC.get_promotion_result';
//  import get_scop_determinant from '@salesforce/apex/InwiB2C_ManageConfPromotionLWC.get_scop_determinant';
//  import get_determinant from '@salesforce/apex/InwiB2C_Version2_ManageConfPromotionLWC.get_determinant';

// // import Scope determinant Object fields 
// import SCOPE_DETERMINANT_OBJECT from '@salesforce/schema/inwiB2C_scop_determinant__c'
// import CANAL_FIELD from '@salesforce/schema/inwiB2C_scop_determinant__c.inwiB2C_Canal__c'
// import TYPE_ACTE_GESTION_FIELD from '@salesforce/schema/inwiB2C_scop_determinant__c.InwiB2C_type_acte_de_gestion__c'
// import TYPE_D_INCLUSION_FIELD from '@salesforce/schema/inwiB2C_scop_determinant__c.InwiB2C_Type_d_inclution__c'




// import { ShowToastEvent } from 'lightning/platformShowToastEvent';

// const PROMOTION_FIELDS = [ 
//     'InwiB2C_Promotion__c.Name',
//     'InwiB2C_Promotion__c.inwiB2C_Code_Produit__c',
//     'InwiB2C_Promotion__c.inwiB2C_code_promotion__c',
//     'InwiB2C_Promotion__c.inwiB2C_date_fin__c',
//     'InwiB2C_Promotion__c.InwiB2C_date_Debut__c',
//     'InwiB2C_Promotion__c.inwiB2C_Libelle_promotion__c',
//     'InwiB2C_Promotion__c.InwiB2C_Type_promotion__c'];





// export default class InwiB2C_Version2configPromotion extends LightningElement {
 
// // TABLE FIELD OBJECTS PROMOTION 
// promotion_fields_display = [NAME_FIELD, TYPE_FIELD, CODE_PRODUIT_FIELD, CODE_PROMOTION_FIELD, DATE_FIN_FIELD, DATE_DEBUT_FIELD]

// // TABLE FIELD OBJECTS SCOPE DETERMINANT 
// Scope_Determinant_fields_display=[CANAL_FIELD,TYPE_ACTE_GESTION_FIELD, TYPE_D_INCLUSION_FIELD]
    

// @api recordId;
// @api objectApiName_Promotion= PROMOTION_OBJECT;
// @api objectApiName_Scope= SCOPE_DETERMINANT_OBJECT;


// connectedCallback(){

//     get_scop_determinant({idPromotion: this.recordId })
//         .then(result => {
//            this.related_scop_determinant = result;
//            console.log('connectedCallback get_scop_determinant result' + JSON.stringify(result));
//         })
//  }



// // EVENT FORM PROMOTION 

// handleCancelPromotionEdited(event){
//       console.log(event.type);
//       console.log(JSON.stringify(event.detail));

// }
// handleChangePromotionEdited(event) {
//     var ChangeMessage = event.detail;
//     console.log('ChangeMessage : ' +JSON.stringify(ChangeMessage));
// }
// handleSubmiPromotionEdited(event) {
//     var SubmitMessage = event.detail;
//     console.log('SubmitMessage : ' +JSON.stringify(SubmitMessage));
// }
// handleSuccessPromotionEdited(event) {
//    event.preventDefault();
//     const toastEvent = new ShowToastEvent({
//     title: 'Success',
//     message: 'Record Created!',
//     variant: 'success'
//     })
//     this.dispatchEvent(toastEvent);

// }

// // EVENT FORM SCOPE DETERMINANT TO

// is_creation_Scope_Determinant = false;

// AddScopeDeterminant(event){
//     if(this.is_creation_Scope_Determinant == false)
//      this.is_creation_Scope_Determinant =true;

//    else
//       this.is_creation_Scope_Determinant = false;
// }


// //Les action dans chaque ligne
// actions_scope_determinant = [
//     { label: 'Show details', name: 'show_details' },
//     { label: 'Delete', name: 'delete' }
// ];
// scope_determinant_columns = [
//     { label: "Name", fieldName: "Name", hideDefaultActions: true },
//     { label: "Canal", fieldName: "inwiB2C_Canal__c", hideDefaultActions: true },
//     { label: "Type Acte de gestion", fieldName: "InwiB2C_type_acte_de_gestion__c", hideDefaultActions: true },
//     { label: "Type d'inclusion", fieldName: "InwiB2C_Type_d_inclution__c", hideDefaultActions: true },
//     {
//         type: 'action',
//         typeAttributes: { rowActions: this.actions_scope_determinant },
//         hideDefaultActions: true
//     }
// ];

// handleScopeDeterminantRowAction(event) {

//     const actionName = event.detail.action.name;
//     const row = event.detail.row;
//     switch (actionName) {
//         case 'delete':
//             this.deleteRecordById(row.Id);

//             console.log('handleScopeDeterminantRowAction_ delete');
//             break;
//         case 'show_details':
//             console.log('handleScopeDeterminantRowAction_ show_details');
//             this.showDetails_SD(row);
//             break;
//         default:
//     }
// }

// __related_scope_determinant = [];
// get related_scope_determinant() { return this.__related_scope_determinant;} 
// set related_scope_determinant(value) {this.__related_scope_determinant = value;}


// get has_scope_determinants(){
//     return this.related_scope_determinant.length !=0;
// }
// }







// // import { LightningElement, api, wire } from 'lwc';
// // // import Promotion objects fields 

// // import PROMOTION_OBJECT from '@salesforce/schema/InwiB2C_Promotion__c';
// // import  NAME_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.Name";
// // import  TYPE_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.InwiB2C_Type_promotion__c";
// // import  CODE_PRODUIT_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.inwiB2C_Code_Produit__c";
// // import  CODE_PROMOTION_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.inwiB2C_code_promotion__c";
// // import  DATE_FIN_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.inwiB2C_date_fin__c";
// // import  DATE_DEBUT_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.InwiB2C_date_Debut__c";

// // // import methode in to class manageconfPromotion 

// //  import get_applied_product from '@salesforce/apex/InwiB2C_Version2_ManageConfPromotionLWC.get_applied_product';
// //  import get_promotion_result from '@salesforce/apex/InwiB2C_Version2_ManageConfPromotionLWC.get_promotion_result';
// //  import get_scop_determinant from '@salesforce/apex/InwiB2C_ManageConfPromotionLWC.get_scop_determinant';
// //  import get_determinant from '@salesforce/apex/InwiB2C_Version2_ManageConfPromotionLWC.get_determinant';

// // // import Scope determinant Object fields 
// // import SCOPE_DETERMINANT_OBJECT from '@salesforce/schema/inwiB2C_scop_determinant__c'
// // import CANAL_FIELD from '@salesforce/schema/inwiB2C_scop_determinant__c.inwiB2C_Canal__c'
// // import TYPE_ACTE_GESTION_FIELD from '@salesforce/schema/inwiB2C_scop_determinant__c.InwiB2C_type_acte_de_gestion__c'
// // import TYPE_D_INCLUSION_FIELD from '@salesforce/schema/inwiB2C_scop_determinant__c.InwiB2C_Type_d_inclution__c'




// // import { ShowToastEvent } from 'lightning/platformShowToastEvent';

// // //Les action dans chaque ligne
// // actions_scope_determinant = [
// //     { label: 'Show details', name: 'show_details' },
// //     { label: 'Delete', name: 'delete' }
// // ];
// // scope_determinant_columns = [
// //     { label: "Name", fieldName: "Name", hideDefaultActions: true },
// //     { label: "Canal", fieldName: "inwiB2C_Canal__c", hideDefaultActions: true },
// //     { label: "Type Acte de gestion", fieldName: "InwiB2C_type_acte_de_gestion__c", hideDefaultActions: true },
// //     { label: "Type d'inclusion", fieldName: "InwiB2C_Type_d_inclution__c", hideDefaultActions: true },
// //     {
// //         type: 'action',
// //         typeAttributes: { rowActions: this.actions_scope_determinant },
// //         hideDefaultActions: true
// //     }
// // ];
// // export default class InwiB2C_Version2configPromotion extends LightningElement {
   
// //     @api objectApiName_Promotion= PROMOTION_OBJECT;
// //     @api objectApiName_Scope= SCOPE_DETERMINANT_OBJECT;
   
// //     data = [];
// //     columns = columns;
// //     record = {};

// //     // eslint-disable-next-line @lwc/lwc/no-async-await
// //     async connectedCallback() {
       
// //         this.data = await  get_scop_determinant({idPromotion: this.record })
// //     }

// //     handleRowAction(event) {
// //         const actionName = event.detail.action.name;
// //         const row = event.detail.row;
// //         switch (actionName) {
// //             case 'delete':
// //                 this.deleteRow(row);
// //                 break;
// //             case 'show_details':
// //                 this.showRowDetails(row);
// //                 break;
// //             default:
// //         }
// //     }

// //     deleteRow(row) {
// //         const { id } = row;
// //         const index = this.findRowIndexById(id);
// //         if (index !== -1) {
// //             this.data = this.data
// //                 .slice(0, index)
// //                 .concat(this.data.slice(index + 1));
// //         }
// //     }

// //     findRowIndexById(id) {
// //         let ret = -1;
// //         this.data.some((row, index) => {
// //             if (row.id === id) {
// //                 ret = index;
// //                 return true;
// //             }
// //             return false;
// //         });
// //         return ret;
// //     }

// //     showRowDetails(row) {
// //         this.record = row;
// //     }
// // }