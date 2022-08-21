import { LightningElement, api, track,wire } from 'lwc';
//import {NavigationMixin} from'lightning/navigation';
//  import deleteRecord from '@salesforce/apex/InwiB2C_ManageConfPromotionLWC.deleteRecord';
import {deleteRecord} from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
//import { CloseActionScreenEvent } from 'lightning/actions';

// import Promotion objects fields

import PROMOTION_OBJECT from '@salesforce/schema/InwiB2C_Promotion__c';
import  NAME_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.Name";
import  TYPE_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.InwiB2C_Type_promotion__c";
import  CODE_PRODUIT_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.inwiB2C_Code_Produit__c";
import  CODE_PROMOTION_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.inwiB2C_code_promotion__c";
import  DATE_FIN_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.inwiB2C_date_fin__c";
import  DATE_DEBUT_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.InwiB2C_date_Debut__c";
// import Scope determinant Object fields 
import SCOPE_DETERMINANT_OBJECT from '@salesforce/schema/inwiB2C_scop_determinant__c';
import CANAL_FIELD from '@salesforce/schema/inwiB2C_scop_determinant__c.inwiB2C_Canal__c';
import TYPE_ACTE_GESTION_FIELD from '@salesforce/schema/inwiB2C_scop_determinant__c.InwiB2C_type_acte_de_gestion__c';
import TYPE_D_INCLUSION_FIELD from '@salesforce/schema/inwiB2C_scop_determinant__c.InwiB2C_Type_d_inclution__c';
//import Determinant Object fields
import DETERMINANT_OBJECT from'@salesforce/schema/inwiB2C_determinant__c';
import SCOPE_FIELD from'@salesforce/schema/inwiB2C_determinant__c.inwiB2C_scope__c';
import CODE_PRODUIT_DETERMINANT_FIELD from'@salesforce/schema/inwiB2C_determinant__c.inwiB2C_Code_Produit__c';
import CODE_ATTRIBUTE_FIELD from'@salesforce/schema/inwiB2C_determinant__c.inwiB2C_code_attribute__c';
import VALEUR_ATTRIBUT_FIELD from'@salesforce/schema/inwiB2C_determinant__c.inwiB2C_Valeur_attribut__c';
import FIELD_DETERMINANT_FIELD from'@salesforce/schema/inwiB2C_determinant__c.inwiB2C_field__c';
import VALUE_FIELD from'@salesforce/schema/inwiB2C_determinant__c.inwiB2C_value__c';


// import methode in to class manageconfPromotion 

// import get_applied_product from '@salesforce/apex/InwiB2C_ManageConfPromotionLWC.get_applied_product';
// import get_promotion_result from '@salesforce/apex/InwiB2C_ManageConfPromotionLWC.get_promotion_result';


import get_scop_determinant from '@salesforce/apex/InwiB2C_ManageConfPromotionLWC.get_scop_determinant';
import get_determinant from '@salesforce/apex/InwiB2C_ManageConfPromotionLWC.get_determinant';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
const PROMOTION_FIELDS = [ 
    'InwiB2C_Promotion__c.Name',
    'InwiB2C_Promotion__c.inwiB2C_Code_Produit__c',
    'InwiB2C_Promotion__c.inwiB2C_code_promotion__c',
    'InwiB2C_Promotion__c.inwiB2C_date_fin__c',
    'InwiB2C_Promotion__c.InwiB2C_date_Debut__c',
    'InwiB2C_Promotion__c.inwiB2C_Libelle_promotion__c',
    'InwiB2C_Promotion__c.InwiB2C_Type_promotion__c'];




export default class InwiB2C_ScopeDeterminant extends LightningElement {

    // TABLE FIELD OBJECTS PROMOTION 
promotion_fields_display = [NAME_FIELD, TYPE_FIELD, CODE_PRODUIT_FIELD, CODE_PROMOTION_FIELD, DATE_FIN_FIELD, DATE_DEBUT_FIELD]
// TABLE FIELD OBJECTS SCOPE DETERMINANT 
add_Scope_Determinant_fields=[CANAL_FIELD,TYPE_ACTE_GESTION_FIELD, TYPE_D_INCLUSION_FIELD]

// TABLE FIELD OBJECTS SCOPE DETERMINANT edited 
scop_determinant_fields_display=[CANAL_FIELD,TYPE_ACTE_GESTION_FIELD, TYPE_D_INCLUSION_FIELD]
//TABLE FIELD OBJECT DETERMINANT
add_Determinant_fields = [
  SCOPE_FIELD
];

add_Determinant_fields_order_item = [SCOPE_FIELD,CODE_PRODUIT_DETERMINANT_FIELD,CODE_ATTRIBUTE_FIELD,VALEUR_ATTRIBUT_FIELD
];
add_Determinant_fields_assets = [SCOPE_FIELD,CODE_PRODUIT_DETERMINANT_FIELD
];
add_Determinant_fields_infoclient = [SCOPE_FIELD,FIELD_DETERMINANT_FIELD,VALUE_FIELD
];
//declarer les proprieties
@api recordId;
@api objectApiName_Promotion= PROMOTION_OBJECT;
@api objectApiName_Scope= SCOPE_DETERMINANT_OBJECT;
@api objectApiName_determinant=DETERMINANT_OBJECT;
//@track deleteList = [];
//les var pour le modale


// @track contactRow={};

// @track rowOffset = 0;

// @track modalContainer = false;
// @track modalContainer2 = false;

// @wire(get_scop_determinant) wireRecord;

//Appel a la methode  Callback

connectedCallback(){

    get_scop_determinant({idPromotion: this.recordId })
        .then(result => {
           this.related_scope_determinant = result;
        })
        .catch(error =>  {
            console.error('connectedCallback get_scop_determinant error' + error);
        });

}

//PROMOTION METHODE START
//Event promotion
handleCancelPromotionEdited(event){
    console.log(event.type);
    console.log(JSON.stringify(event.detail));

}
handleChangePromotionEdited(event) {
  var ChangeMessage = event.detail;
  console.log('ChangeMessage : ' +JSON.stringify(ChangeMessage));
}
handleSubmiPromotionEdited(event) {
  var SubmitMessage = event.detail;
  console.log('SubmitMessage : ' +JSON.stringify(SubmitMessage));
}
handleSuccessPromotionEdited(event) {
 event.preventDefault();
  const toastEvent = new ShowToastEvent({
  title: 'Success',
  message: 'Record Created!',
  variant: 'success'
  })
  this.dispatchEvent(toastEvent);

}

//PROMOTION METHODE END


//SCOPE DETERMINANT METHODE START

// BUTTON SCOPE DETERMINANT 
is_creation_Scope_Determinant = false;

AddScopeDeterminant(e) {
  console.log('start AddScopeDeterminant');

  if (this.is_creation_Scope_Determinant == false) this.is_creation_Scope_Determinant = true;
  else this.is_creation_Scope_Determinant = false;

  console.log('end AddScopeDeterminant');
}
// EVENT FORM SCOPE DETERMINANT 
handleCancelScopeDeterminantCreated(event) {
  console.log('s handleCancelScopeDeterminantCreated');
  this.is_creation_Scope_Determinant=false;
}
handleSubmitScopeDeterminantCreated(event) {
  console.log('s handleSubmitScopeDeterminantCreated');

  try {
      event.preventDefault(); // stop the form from submitting
      const fields = event.detail.fields;
      fields.inwiB2C_Promotion_discount__c = this.recordId;
      
      this.template.querySelector(".addscopedeterminant").submit(fields);

      this.related_scope_determinant.push(fields);
      console.log('e handleSubmitScopeDeterminantCreated');


  } catch (error) {
      console.log('handleSubmitScopeDeterminantCreated error ' + error);

  }


}
handleSuccessScopeDeterminantCreated(e) {
    console.log('handleSuccessScopeDeterminantCreated start');
    this.is_creation_Scope_Determinant = false;

    get_scop_determinant({ idPromotion: this.recordId })
        .then(result => {

            this.related_scope_determinant = result;
            console.log('handleSuccessScopeDeterminantCreated result' + JSON.stringify(result));

        })
        .catch(error => {
            console.error('handleSuccessScopeDeterminantCreated error' + error);

        });
    console.log('handleSuccessScopeDeterminantCreated end');
  
}

// METHODE for scope determinant

//pour afficher la template de scope determinate afficher la table
__related_scope_determinant = [];
get related_scope_determinant() { return this.__related_scope_determinant;} 
set related_scope_determinant(value) {this.__related_scope_determinant = value;}

//Afficher la template de show scope determinant
get is_scope_determinant_selected() {
  return this.selected_scope_determinant.length != 0;
}
__selected_scope_determinant = [];
get selected_scope_determinant() { return this.__selected_scope_determinant; } 
set selected_scope_determinant(value) { this.__selected_scope_determinant = value; }

//Les defffirents actions pour la table scope determinent
actions_scope_determinant = [
  { label: 'showDetails', name: 'show_details' },
  { label: 'Delete', name: 'delete' },
  
];

//les columns de la tables scope determinant
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
 
//la fonction pour gerer les differentes action dant la table scope determinant

handleScopeDeterminantRowAction(event) {

  const actionName = event.detail.action.name;
  const row = event.detail.row;
  switch (actionName) {
      case 'delete':
          this.deleteRecordById(row.Id);

          console.log('handleScopeDeterminantRowAction_ delete');
          break;
      case 'show_details':
          console.log('handleScopeDeterminantRowAction_ show_details');
          this.showDetails_SD(row);
          break;
      default:
  }
}

showDetails_SD(row) {
  console.log('showDetails_SD show_details');
  console.log('showDetails_SD row : ' + JSON.stringify(row));

  try {
      let tempRow = JSON.parse(JSON.stringify(row));


      let temp2 = [tempRow['inwiB2C_determinant__r']];

      tempRow['inwiB2C_determinant__r'] = temp2;

      this.selected_scope_determinant = tempRow;

  } catch (error) {
      console.error('showDetails_SD_error : ' + error);

  }
  //  
}

//EVENT FOR SHOW DETAILS
handleCancelScopeDeterminantEdited(e) {
  console.log('handleCancelScopeDeterminantEdited');
}
handleChangeScopeDeterminantEdited(e) {
  console.log('handleChangeScopeDeterminantEdited');
}
handleSubmiScopeDeterminantEdited(e) {
  console.log('handleSubmiScopeDeterminantEdited');
}
handleSuccessScopeDeterminantEdited(e) {
  console.log('handleSuccessScopeDeterminantEdited');
  get_scop_determinant({ idPromotion: this.recordId })
  .then(result => {

      this.related_scope_determinant = result;
      console.log('handleSuccessScopeDeterminantEdited get_scop_determinant result' + JSON.stringify(result));
      this.dispatchEvent(new ShowToastEvent({
        title:'Success',
        message:'Record updating with success',
        variant:'success'
      },
      console.log(this.dispatchEvent)
  
      
     
      ))
  })
  .catch(error => {
      console.error('handleSuccessScopeDeterminantEdited get_scop_determinant error' + error);
      this.dispatchEvent(new ShowToastEvent({
        title:'Error',
        message:' Error Record updating',
        variant:'error'
      },
      console.log(this.dispatchEvent)
  
      
     
      ))
  });

}

//GERER LE BUTTON ADD DETERMINANT
is_creation_Determinant = false;
AddDeterminant(e) {
  console.log('start AddDeterminant');

  if (this.is_creation_Determinant == false) this.is_creation_Determinant = true;
  else this.is_creation_Determinant = false;

  console.log('end AddDeterminant');

}
//POUR AFFICHER LE FORMULAIRE DE L'OBJET DETERMINANT
related_determinant = [];
selected_determinant = {};


__determinant_fields_display = [] ;
get determinant_fields_display() { 

    if(this.__determinant_fields_display.length==0)
        if(this.selected_determinant.inwiB2C_scope__c=='inwiB2C_Order_item'){
            this.__determinant_fields_display = this.add_Determinant_fields_order_item;
        }else if(this.selected_determinant.inwiB2C_scope__c=='inwiB2C_Assets'){
            this.__determinant_fields_display =this.add_Determinant_fields_assets;
        }else if(this.selected_determinant.inwiB2C_scope__c=='inwiB2C_Infos_client'  ||this.selected_determinant.inwiB2C_scope__c == 'inwiB2C_Order'){
            this.__determinant_fields_display =this.add_Determinant_fields_infoclient;
        }else{
            this.__determinant_fields_display =['inwiB2C_scope__c'];
        }

    return this.__determinant_fields_display; 
} 
set determinant_fields_display(value) { this.__determinant_fields_display = value; }

//EVENT FOR DETERMINANT
handleChangeDeterminantCreate(event) {

  console.log('handleChangeDeterminantCreate s');
  try {


      let val = event.detail.value;
      console.log('handleChangeDeterminantCreate val: ' + val);

      if (val == 'inwiB2C_Order_item')
          this.add_Determinant_fields = this.add_Determinant_fields_order_item;
      else if (val == 'inwiB2C_Assets')
          this.add_Determinant_fields = this.add_Determinant_fields_assets;
      else if (val == 'inwiB2C_Infos_client' ||val == 'inwiB2C_Order')
          this.add_Determinant_fields = this.add_Determinant_fields_infoclient;


  } catch (error) {
      console.error('handleChangeDeterminantCreate error: ' + error);

  }
  console.log('handleChangeDeterminantCreate e');

}
handleCancelDeterminantCreated(e){
  console.log('s handleCancelDeterminantCreated');
  this.is_creation_Determinant=false;
}
handleSubmiDeterminantCreated(event) {
  console.log('s handleSubmiDeterminantCreated');

  try {
      
      event.preventDefault(); // stop the form from submitting
      const fields = event.detail.fields;
      fields.inwiB2C_scope_determinant__c = this.selected_scope_determinant.Id;
      console.log('handleSubmiDeterminantCreated fields: ' + JSON.stringify(fields));
      console.log('handleSubmiDeterminantCreated querySelector: ' + JSON.stringify(this.template.querySelector('lightning-record-form')));
      this.template.querySelector(".adddeterminant").submit(fields);
      
      this.related_scope_determinant.push(fields);
  
      console.log('e handleSubmiDeterminantCreated');


  } catch (error) {
      console.log('handleSubmiDeterminantCreated error ' + error);

  }


}
handleSuccessDeterminantCreated(e) {
  console.log('handleSuccessDeterminantCreated start');
  this.is_creation_Determinant = false;
  this.add_Determinant_fields = [
      
      'inwiB2C_scope__c'
  ];
  console.log('handleSuccessDeterminantCreated this.selected_scope_determinant.Id: ' + this.selected_scope_determinant.Id);

  get_determinant({ idScopDeterminant: this.selected_scope_determinant.Id })
      .then(result => {

          console.log('handleSuccessDeterminantCreated this.selected_scope_determinant.Determinants__r befor:' +
          JSON.stringify(this.selected_scope_determinant.Determinants__r));

          this.selected_scope_determinant.Determinants__r = result;
          console.log('handleSuccessDeterminantCreated this.selected_scope_determinant.Determinants__r after: ' +
           JSON.stringify(this.selected_scope_determinant.Determinants__r));
          console.log('handleSuccessDeterminantCreated result ' + JSON.stringify(result));
  // let datadet=[...this.selected_scope_determinant.Determinants__r];
            // let datadetr= datadet.push(fields);
            // this.selected_scope_determinant=datadetr;
     
        })
      .catch(error => {
          console.error('handleSuccessDeterminantCreated error' + error);

      });
 
}
//methode pour rentre dans la table determinant
get is_selected_scope_determinant_has_Determinants() {
 return this.selected_scope_determinant.Determinants__r.length != 0;

}

//determinant data table row action
actions_determinant = [
  { label: 'Show details', name: 'show_details' },
  { label: 'Delete', name: 'delete' }
];
get determinant_columns() {
  return [
      { label: "Name", fieldName: "Name", hideDefaultActions: true },
      { label: "Scope", fieldName: "scopevalue", hideDefaultActions: true },
      { label: "Code Produit", fieldName: "inwiB2C_Code_Produit__c", hideDefaultActions: true },
      { label: "Code attribut", fieldName: "inwiB2C_code_attribute__c", hideDefaultActions: true },
      { label: "Valeur attribut", fieldName: "inwiB2C_Valeur_attribut__c", hideDefaultActions: true },
      { label: "Field", fieldName: "inwiB2C_field__c", hideDefaultActions: true },
      { label: "Value", fieldName: "inwiB2C_value__c", hideDefaultActions: true },
      {
          type: 'action',
          typeAttributes: { rowActions: this.actions_determinant },
          hideDefaultActions: true
      }

  ]
}





// delete record by id
deleteRecordById(id) {
  deleteRecord(id);

  setTimeout(() => {
      
      get_scop_determinant({ idPromotion: this.recordId })
      .then(result => {
          this.related_scope_determinant = result;
          console.log('connectedCallback get_scop_determinant result' + JSON.stringify(result));
      })
      .catch(error => {
          console.error('connectedCallback get_scop_determinant error' + error);
      });
        
  
  }, 1000);
}

  }