import { LightningElement, api, wire,track} from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { deleteRecord } from 'lightning/uiRecordApi';
import { refreshApex } from "@salesforce/apex";
import { getRecordNotifyChange } from "lightning/uiRecordApi";









// import Promotion objects fields 

import PROMOTION_OBJECT from '@salesforce/schema/InwiB2C_Promotion__c';
import  NAME_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.Name";
import  TYPE_FIELD  from "@salesforce/schema/InwiB2C_V2_Promotion__c.InwiB2C_Type_promotion__c";
import  CODE_PRODUIT_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.inwiB2C_Code_Produit__c";
import  CODE_PROMOTION_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.inwiB2C_code_promotion__c";
import  DATE_FIN_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.inwiB2C_date_fin__c";
import  DATE_DEBUT_FIELD  from "@salesforce/schema/InwiB2C_Promotion__c.InwiB2C_date_Debut__c";




// import methode in to class manageconfPromotion 

 import get_applied_product from '@salesforce/apex/InwiB2C_ManageConfPromotionLWC.get_applied_product';
 import get_promotion_result from '@salesforce/apex/InwiB2C_ManageConfPromotionLWC.get_promotion_result';
 import get_scop_determinant from '@salesforce/apex/InwiB2C_ManageConfPromotionLWC.get_scop_determinant';
 import get_determinant from '@salesforce/apex/InwiB2C_ManageConfPromotionLWC.get_determinant';

// import Scope determinant Object fields 
import SCOPE_DETERMINANT_OBJECT from '@salesforce/schema/inwiB2C_scop_determinant__c'
import CANAL_FIELD from '@salesforce/schema/inwiB2C_scop_determinant__c.inwiB2C_Canal__c'
import TYPE_ACTE_GESTION_FIELD from '@salesforce/schema/inwiB2C_scop_determinant__c.InwiB2C_type_acte_de_gestion__c'
import TYPE_D_INCLUSION_FIELD from '@salesforce/schema/inwiB2C_scop_determinant__c.InwiB2C_Type_d_inclution__c'

// import  determinant Object fields 

import DETERMINANT_OBJECT from '@salesforce/schema/inwiB2C_determinant__c'
import SCOPE_FIELDS    from '@salesforce/schema/inwiB2C_determinant__c.inwiB2C_scope__c';
import CODE_PRODUIT from '@salesforce/schema/inwiB2C_determinant__c.inwiB2C_Code_Produit__c'
import CODE_ATTRIBUTE from '@salesforce/schema/inwiB2C_determinant__c.inwiB2C_code_attribute__c'
import VALEUR_ATTRIBUTE from '@salesforce/schema/inwiB2C_determinant__c.inwiB2C_Valeur_attribut__c'

import VALUE from '@salesforce/schema/inwiB2C_determinant__c.inwiB2C_value__c'

import FIELD from '@salesforce/schema/inwiB2C_determinant__c.inwiB2C_field__c'

import { ShowToastEvent } from 'lightning/platformShowToastEvent';


// import  Applied Product Object Fields 

import APPLIED_PRODUCT_OBJECT from '@salesforce/schema/inwiB2C_Applied_Product__c'
import CODE_PRODUIT_FIELDS from '@salesforce/schema/inwiB2C_Applied_Product__c.inwiB2C_Code_Produit__c'
import CODE_LABELLE_PRODUIT_FIELDS from '@salesforce/schema/inwiB2C_Applied_Product__c.inwiB2C_Libelle_du_produit__c'




// import Promotion Result Object Fields
import PROMOTION_RESULT_OBJECT from '@salesforce/schema/inwiB2C_promotion_result__c'
import RESULT_TYPE_FIELDS from '@salesforce/schema/inwiB2C_promotion_result__c.inwiB2C_Result_type__c'
import CODE_ATTRIBUT_RESULT from '@salesforce/schema/inwiB2C_promotion_result__c.inwiB2C_code_attribute__c'
import VALEUR_ATTRIBUT_RESULT from '@salesforce/schema/inwiB2C_promotion_result__c.inwiB2C_valeur_attribut__c'
import TYPE_PRIX_RESULT from '@salesforce/schema/inwiB2C_promotion_result__c.inwiB2C_type_de_prix__c'
import PERCENT_RESULT from '@salesforce/schema/inwiB2C_promotion_result__c.inwiB2C_percent__c'


const PROMOTION_FIELDS = [
    'InwiB2C_Promotion__c.Name',
    'InwiB2C_Promotion__c.inwiB2C_Code_Produit__c',
    'InwiB2C_Promotion__c.inwiB2C_code_promotion__c',
    'InwiB2C_Promotion__c.inwiB2C_date_fin__c',
    'InwiB2C_Promotion__c.InwiB2C_date_Debut__c',
    'InwiB2C_Promotion__c.inwiB2C_Libelle_promotion__c',
    'InwiB2C_Promotion__c.InwiB2C_Type_promotion__c'];




export default class InwiB2C_Version2configPromotion extends LightningElement {
 
// TABLE FIELD OBJECTS PROMOTION 
promotion_fields_display = [NAME_FIELD, TYPE_FIELD, CODE_PRODUIT_FIELD, CODE_PROMOTION_FIELD, DATE_FIN_FIELD, DATE_DEBUT_FIELD]

// TABLE FIELD OBJECTS SCOPE DETERMINANT 
add_Scope_Determinant_fields=[CANAL_FIELD,TYPE_ACTE_GESTION_FIELD, TYPE_D_INCLUSION_FIELD]

scop_determinant_fields_display=[CANAL_FIELD, TYPE_ACTE_GESTION_FIELD,  TYPE_D_INCLUSION_FIELD]
     


//TABLE FIELDS OBJECTS DETERMINANT

add_Determinant_fields=[SCOPE_FIELDS]

add_Determinant_fields_order_item = [SCOPE_FIELDS, CODE_PRODUIT,CODE_ATTRIBUTE, VALEUR_ATTRIBUTE ]


add_Determinant_fields_assets=[SCOPE_FIELDS, CODE_PRODUIT]

add_Determinant_fields_infoclient= [SCOPE_FIELDS, VALUE, FIELD
]

//TABLE FIELDS OBJECTS APPLIED PRODUCT 

add_applied_product_fields =[CODE_PRODUIT_FIELDS, CODE_LABELLE_PRODUIT_FIELDS]

applied_product_fields_display=[CODE_PRODUIT_FIELDS, CODE_LABELLE_PRODUIT_FIELDS]

//TABLE FIELDS OBJECTS PROMOTION RESULT 

add_promotion_result_fields =[RESULT_TYPE_FIELDS]

promotion_result_fields_display_action =[RESULT_TYPE_FIELDS, CODE_ATTRIBUT_RESULT, VALEUR_ATTRIBUT_RESULT ]

promotion_result_fields_display_discount =[RESULT_TYPE_FIELDS, TYPE_PRIX_RESULT, PERCENT_RESULT ]



@api recordId;
@api objectApiName_Promotion= PROMOTION_OBJECT;
@api objectApiName_Scope= SCOPE_DETERMINANT_OBJECT;
@api objectApiName_Determinant = DETERMINANT_OBJECT;
@api objectApiName_APPLIED_PRODUCT= APPLIED_PRODUCT_OBJECT;
@api objectApiName_PROMOTION_RESULT = PROMOTION_RESULT_OBJECT;

connectedCallback() {
  

    get_scop_determinant({ idPromotion: this.recordId })
        .then(result => {

            this.related_scope_determinant = result;
            console.log('connectedCallback get_scop_determinant result' + JSON.stringify(result));

        })
        .catch(error => {
            console.error('connectedCallback get_scop_determinant error' + error);

        });
        get_applied_product({idPromotion :this.recordeId})
        .then(result => {
            this.related_applied_product = result;
        })
        .catch(error => {
            console.error('connectedCallback get_promotion_result error' + error);
    
        })
    

        get_promotion_result({ idPromotion: this.recordId })
            .then(result => {

                this.related_promotion_result = result;
                console.log('connectedCallback get_promotion_result result' + JSON.stringify(result));

            })
            .catch(error => {
                console.error('connectedCallback get_promotion_result error' + error);

            });

}



// // EVENT FORM PROMOTION 

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
    message: 'Promotion a été créé',
    variant: 'success'
    })
    this.dispatchEvent(toastEvent);

}





// BUTTON OBJECT SCOPE DETERMINANT
is_creation_Scope_Determinant = false;


AddScopeDeterminant(event){
    if(this.is_creation_Scope_Determinant == false)
     this.is_creation_Scope_Determinant =true;

     else
      this.is_creation_Scope_Determinant = false;
}


 // EVENT OBJECT SCOPE DETERMINANT 
handleCancelScopeDeterminantCreated(event) {
    console.log(event.type);
    console.log(JSON.stringify(event.detail));
    this.is_creation_Scope_Determinant=false;
}

handleSubmitScopeDeterminantCreated(event) {
    console.log('s handleSubmitScopeDeterminantCreated');

    try {
        event.preventDefault(); // stop the form from submitting
        const fields = event.detail.fields;
        fields.inwiB2C_Promotion_Discount__c = this.recordId;
        console.log('handleSubmitScopeDeterminantCreated fields: ' + JSON.stringify(fields));
        this.template.querySelector(".addscopedeterminant").submit(fields);

        this.related_scope_determinant.push(fields);
        console.log('e handleSubmitScopeDeterminantCreated');


    } catch (error) {
        console.log('handleSubmitScopeDeterminantCreated error ' + error);

    }


}
    handleSuccessScopeDeterminantCreated(e) {

        this.is_creation_Scope_Determinant = false;

        get_scop_determinant({ idPromotion: this.recordId })
            .then(result => {
                 this.related_scope_determinant = result;

              // showing success message
                 this.dispatchEvent(new ShowToastEvent({
                    title: 'Success!!',
                    message: 'Scope Determinant a été Créé',
                    variant: 'success'
                }),);
            })
        .catch(error => {
            window.console.log('Error ====> '+error);
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error!!', 
                message: error.message, 
                variant: 'error'
            }),);
        });
      
 }


   

      
     

// METHODE SCOPE DETERMINANT TO INSERT


__related_scope_determinant = [];
get related_scope_determinant() { 
    return  this.__related_scope_determinant;} 
set related_scope_determinant(value) {
    this.__related_scope_determinant = value;}


get has_scope_determinants(){
    return this.related_scope_determinant.length !=0;
}

 


// TABLE  SCOPE DETERMINANT

actions_scope_determinant = [
    { label: 'Afficher les Détails',
     name: 'show_details',
     iconName:'action:preview' },
    {  label: 'Supprimé', 
      name: 'delete' ,
     iconName:'action:delete'}
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


 // METHODE DELETE SCOPE DETERMINANT
 deleteRecordById(id) {


    deleteRecord(id);

    setTimeout(() => {
        
        get_scop_determinant({ idPromotion: this.recordId })
        .then(result => {
           
            this.related_scope_determinant = result;
            this.dispatchEvent(new ShowToastEvent({
                title: 'Success!!',
                message: ' Scope Determinant a été Supprimé',
                variant: 'success'
            }),);
            eval("$A.get('e.force:refreshView').fire();");    
        })
.catch(error => {
        window.console.log('Error ====> '+error);
        this.dispatchEvent(new ShowToastEvent({
            title: 'Error!!', 
            message: error.message, 
            variant: 'error'
        }),);
    });


          
    }, 1000);

    }




 
 //  ACTION ROW RECORD OBJECT SCOPE DETERMINANTS 


      handleScopeDeterminantRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'delete':
                this.deleteRecordById(row.Id);
            break;
            case 'show_details':
               this.showDetails_SD(row)
    
           break;
        }

    }

    
    showDetails_SD(row) {
        console.log('showDetails_SD show_details');
        console.log('showDetails_SD row : ' + JSON.stringify(row));

        try {
            let tempRow = JSON.parse(JSON.stringify(row));

            this.selected_scope_determinant = tempRow;

        } catch (error) {
            console.error('showDetails_SD_error : ' + error);

        }
        //  
    }

//METHODE SCOPE DETERMINANT TO EDITED

__selected_scope_determinant = [];
get selected_scope_determinant() { 
    return this.__selected_scope_determinant; } 
set selected_scope_determinant(value) 
{ this.__selected_scope_determinant = value; }


get is_scope_determinant_selected() {
    return this.selected_scope_determinant.length != 0;
}



     
get is_selected_scope_determinant_has_Determinants() {
    if (typeof 
        this.selected_scope_determinant.Determinants__r != "undefined")
        return this.selected_scope_determinant.Determinants__r.length != 0;
    else
        return false;
    
    }

       
 // EVENT SELECTED SCOPE DETERMINANT

 handleChangeScopeDeterminantEdited(e) {
    console.log('handleChangeScopeDeterminantEdited');
}
handleCancelScopeDeterminantEdited(e) {
    console.log('handleCancelScopeDeterminantEdited');
}
handleSubmiScopeDeterminantEdited(e) {
    console.log('handleSubmiScopeDeterminantEdited');
}

handleSuccessScopeDeterminantEdited(e) {
    console.log('handleSuccessScopeDeterminantEdited');
    get_scop_determinant({ idPromotion: this.recordId })
    .then(result => {

        this.related_scope_determinant = result;
    // showing success message
    this.dispatchEvent(new ShowToastEvent({
        title: 'Success!!',
        message: ' Scope Determinant a été Enregistrée',
        variant: 'success'
    }),);
})
 .catch(error => {
    window.console.log('Error ====> '+error);
    this.dispatchEvent(new ShowToastEvent({
       title: 'Error!!', 
       message: error.message, 
       variant: 'error'
   }),);
 });

}

 // BUTTON OBJECT DETERMINANT

AddDeterminant(e) {
   
    if (this.is_creation_Determinant == false) 
       this.is_creation_Determinant = true;
    else
    this.is_creation_Determinant = false;

    
}


// START  METHODE OBJECT DETERMINAT 

is_creation_Determinant = false;
ss
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



get is_determinant_selected() {
 

    return Object.keys(this.selected_determinant).length != 0;
}

// TABLE DETERMINANT 

actions_determinant = [
    { label: 'Afficher les Détails',
     name: 'show_details',
     iconName:'action:preview' },
    { label: 'Supprimé', 
      name: 'delete',
      iconName:'action:delete' 
 }
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


// EVENT OBJECT DETERMINANT 

handleChangeDeterminantCreate(event) {
      
  try{

      let val = event.detail.value;

      if(val == 'inwiB2C_Order_item')
         this.add_Determinant_fields = this.add_Determinant_fields_order_item;

     else if (val == 'inwiB2C_Assets')
     this.add_Determinant_fields = this.add_Determinant_fields_assets;

     else if (val == 'inwiB2C_Infos_client' || val == 'inwiB2C_Order' )
     this.add_Determinant_fields = this.add_Determinant_fields_infoclient;

   }
    catch(error){
         console.log('error:' +error);
    }
 
}

handleCancelDeterminantCreated(e){
    this.is_creation_Determinant=false;
}
 handleSubmiDeterminantCreated(event) {
     

    try {
        event.preventDefault(); // stop the form from submitting
        const fields = event.detail.fields;
        fields.inwiB2C_scope_determinant__c = this.selected_scope_determinant.Id;
        this.template.querySelector(".adddeterminant").submit(fields);
        // this.related_scope_determinan.push(fields);
        this.selected_scope_determinant.Determinants__r.push(fields);
        // eval("$A.get('e.force:refreshView').fire();");  

    } catch (error) {
        console.log('handleSubmiDeterminantCreated error ' + error);

    }

}


  handleSuccessDeterminantCreated(e) {
     
    this.is_creation_Determinant = false;
    this.add_Determinant_fields = [  'inwiB2C_scope__c' ];
     e.preventDefault()
    get_determinant({ idScopDeterminant: this.selected_scope_determinant.Id })
        .then(result => {

        this.selected_scope_determinant.Determinants__r = result;
          // showing success message
                 this.dispatchEvent(new ShowToastEvent({
                    title: 'Success!!',
                    message: ' Determinant a été créé',
                    variant: 'success'
                }),);
              
               
            })
        .catch(error => {
            window.console.log('Error ====> '+error);
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error!!', 
                message: error.message, 
                variant: 'error'
            }),);
        });
   
}







// EVENT EDITED FORME DETERMINANT

handleChangeDeterminantEdited(event) {
   
    let val = event.detail.value

    try {
        if (val == 'inwiB2C_Order_item')
            this.determinant_fields_display = this.add_Determinant_fields_order_item;
        else if (val == 'inwiB2C_Assets')
            this.determinant_fields_display = this.add_Determinant_fields_assets;
        else if (val == 'inwiB2C_Infos_client' ||val == 'inwiB2C_Order')
            this.determinant_fields_display = this.add_Determinant_fields_infoclient;


    } catch (error) {
        console.error('handleChangeDeterminantEdited: ' + error);

    }
}
handleSubmiDeterminantEdited(e) {
    console.log('handleSubmiDeterminantEdited')
    eval("$A.get('e.force:refreshView').fire();");

}

handleSuccessDeterminantEdited(e) {
get_determinant({ idScopDeterminant: this.selected_scope_determinant.Id })
.then(result => {
    this.related_scope_determinant= result;
    this.related_determinant = result;
    // showing success message
    this.dispatchEvent(new ShowToastEvent({
        title: 'Success!!',
        message: 'Determinant a été Enregistrée',
        variant: 'success'
    }),);
})
  .catch(error => {
 window.console.log('Error ====> '+error);
 this.dispatchEvent(new ShowToastEvent({
    title: 'Error!!', 
    message: error.message, 
    variant: 'error'
}),);
});

}


 // METHODE DELETE SCOPE DETERMINANT
 deleteDeterminantRecordById(id) {

    deleteRecord(id);

    setTimeout(() => {


        get_scop_determinant({ idPromotion: this.recordId })
        .then(result => {
              this.related_scope_determinant = result;
            })

     .catch(error => {
        consolelog('error')       
     });

        get_determinant({ idScopDeterminant: this.selected_scope_determinant.Id })
        .then(result => {
            this.selected_scope_determinant.Determinants__r= result;
            this.dispatchEvent(new ShowToastEvent({
                            title: 'Success!!',
                            message: ' Determinant a été Supprimé',
                            variant: 'success'
                        }),);
                        eval("$A.get('e.force:refreshView').fire();");
        })
        .catch(error => {
                    window.console.log('Error ====> '+error);
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Error!!', 
                        message: error.message, 
                        variant: 'error'
                    }),);
                });

          
    }, 1000);

    }


handleDeterminantRowAction(event) {
        let actionName = event.detail.action.name;

        window.console.log('actionName ====> ' + actionName);

        let row = event.detail.row;

        window.console.log('row ====> ' + row);
        switch (actionName) {
           case 'delete':
                this.deleteDeterminantRecordById(row.Id);
                break;
                case 'show_details':
                this.showDetails_Determinant(row);
                 break;
                default:
        }
    }


    showDetails_Determinant(row) {
       
        try {
            let tempRow = JSON.parse(JSON.stringify(row));
    
            this.selected_determinant = {};
            this.selected_determinant = tempRow;
    
    
            get_determinant({ idScopDeterminant: row.Id })
                .then(result => {
    
                    this.related_determinant = result;
               
                })
                .catch(error => {
                    console.error('connectedCallback_error' + error);
    
                });
    
    
        } catch (error) {
            console.error('showDetails_Determinant_error : ' + error);
    
        }


}


 // BUTTON OBJECT APPLIED PRODUCT
 is_creation_applied_product = false;

    addAppliedProduct(e) {
        console.log('addAppliedProduct s');

        if (this.is_creation_applied_product == false) 
         this.is_creation_applied_product = true;
        else 
         this.is_creation_applied_product = false;


    }

// EVENT FROM  APPLIED PRODUCT CREATED

    handleCancelAppliedProducttCreated(e){
        console.log('handleCancelAppliedProducttCreated');
        this.is_creation_applied_product = false;
    }

    handleChangeAppliedProducttCreated(e){
        console.log('handleChangeAppliedProducttCreated');
    }


    handleSubmitAppliedProducttCreated(event) {
        console.log('handleSubmitAppliedProducttCreated');

        try {
            event.preventDefault(); // stop the form from submitting
            const fields = event.detail.fields;
            fields.inwiB2C_Promotion_discount__c = this.recordId;
            console.log('handleSubmitAppliedProducttCreated fields: ' + JSON.stringify(fields));
            console.log('handleSubmitAppliedProducttCreated addappliedproduct');
            this.template.querySelector(".addappliedproduct").submit(fields);

           this.related_applied_product.push(fields);
        


        } catch (error) {
            console.log('handleSubmitAppliedProducttCreated error ' + error);

        }

    }

    handlFailureAppliedProducttCreated(error) {
        console.error('handlFailureAppliedProducttCreated error: ' + error);
    }

    handleSuccessAppliedProducttCreated(e) {
        this.is_creation_applied_product = false;

        get_applied_product({ idPromotion: this.recordId })
            .then(result => {

                this.related_applied_product = result;
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Success!!',
                    message: ' Applied Product a été Créé',
                    variant: 'success'
                }),);
            }).catch(error => {
                window.console.log('Error ====> '+error);
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Error!!', 
                    message: error.message, 
                    variant: 'error'
                }),);
            });
           
    }



    __related_applied_product = [];

    get related_applied_product() {
         return this.__related_applied_product; } 
    set related_applied_product(value) {
         this.__related_applied_product = value; }
    
    get has_applied_product(){
        return this.related_applied_product.length !=0;

    }
   
    __selected_applied_product = [];
    get selected_applied_product() { 
        return this.__selected_applied_product; } 
    set selected_applied_product(value) {
         this.__selected_applied_product = value; }
    



    get is_applied_product_selected() {
        return this.selected_applied_product.length != 0
    }


// TABLE APPLIED PRODUCT

    actions_applied_product = [
        { label: 'Afficher les Détails', name: 'show_details',iconName:'action:preview' },
        { label: 'Supprimé', name: 'delete' ,iconName:'action:delete'  }
    ];
    applied_product_columns = [
        { label: "Name", fieldName: "Name", hideDefaultActions: true },
        { label: "Libellé du produit", fieldName: "inwiB2C_Libelle_du_produit__c", hideDefaultActions: true },
        { label: "Code Produit", fieldName: "inwiB2C_Code_Produit__c", hideDefaultActions: true },
        {
            type: 'action',
            typeAttributes: { rowActions: this.actions_applied_product },
            hideDefaultActions: true
        }
    ];

 // DELETE APPLIED PRODUCT

 DeleteRecordById(id) {

    deleteRecord(id);

    setTimeout(() => {
        
       get_applied_product({ idPromotion: this.recordId })
      .then(result => {
        this.related_applied_product = result;
        this.dispatchEvent(new ShowToastEvent({
                  title: 'Success!!',
                  message: ' Applied Product a été Supprimé',
                  variant: 'success'
             }),);
             eval("$A.get('e.force:refreshView').fire();");         
                })
     .catch(error => {
             window.console.log('Error ====> '+error);
             this.dispatchEvent(new ShowToastEvent({
                    title: 'Error!!', 
                    message: error.message, 
                    variant: 'error'
               }),);
         });
          
    }, 1000);

    }

    handleAppliedProducttRowAction(event) {
        console.log('handleAppliedProducttRowAction');

        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'delete':
                this.DeleteRecordById(row.Id);
                break;
            case 'show_details':
                console.log('handleAppliedProducttRowAction show_details');
                this.showDetails_AppliedProductt(row);
                break;
            default:
        }
    }

    showDetails_AppliedProductt(row) {
        console.log('showDetails_AppliedProductt show_details');
        console.log('showDetails_AppliedProductt row : ' + JSON.stringify(row));
/**/
        try {
            let tempRow = JSON.parse(JSON.stringify(row));
        
            this.selected_applied_product = tempRow;

        } catch (error) {
            console.error('showDetails_AppliedProductt error : ' + error);

        }
        
    }

//  EVENT FORM OBJECT APPLIED PRODUCT EDITED


    handleChangeapplied_productEdited(e) {
        console.log('handleChangeapplied_productEdited');

    }
    handleCancelapplied_productEdited(e) {
        console.log('handleCancelapplied_productEdited');
      
    }
    handleSubmiapplied_productEdited(e) {
        console.log('handleSubmiapplied_productEdited');
    }

    handleSuccessapplied_productEdited(e) {
        console.log('handleSuccessapplied_productEdited');

        
        get_applied_product({ idPromotion: this.recordId })
        .then(result => {

            this.related_applied_product = result;
            this.dispatchEvent(new ShowToastEvent({
                title: 'Success!!',
                message: ' Applied Product a eté Enregistrée',
                variant: 'success'
            }),);
        })
          .catch(error => {
         window.console.log('Error ====> '+error);
         this.dispatchEvent(new ShowToastEvent({
            title: 'Error!!', 
            message: error.message, 
            variant: 'error'
        }),);
        });
      
       
    }
    handleFailureapplied_productEdited(error) {
        console.error('handleFailureapplied_productEdited error: ' + error);
    }



// BUTTON OBJECT PROMOTION RESULT

is_creation_promotion_result = false;


addPromotionResult(e) {
 
    if (this.is_creation_promotion_result == false)
      this.is_creation_promotion_result = true;
    else 
    this.is_creation_promotion_result = false;
 

}

selected_promotion_result = {};

get selected_promotion_result_str(){
    return JSON.stringify(this.selected_promotion_result)
}


get promotion_result_fields_display_str(){
    return JSON.stringify(this.promotion_result_fields_display)
}
__related_promotion_result = [];
get related_promotion_result() { return this.__related_promotion_result; } 
set related_promotion_result(value) { this.__related_promotion_result = value; }


get has_promotion_result(){
    return this.related_promotion_result.length !=0;
}

get is_promotion_result_selected() {
    return Object.keys(this.selected_promotion_result).length != 0
}





__promotion_result_fields_display = [] ;
get promotion_result_fields_display() { 

    if(this.__promotion_result_fields_display.length==0)
        if(this.selected_promotion_result.inwiB2C_Result_type__c=='inwiB2C_Action'){
            this.__promotion_result_fields_display = this.promotion_result_fields_display_action;
        }else if(this.selected_promotion_result.inwiB2C_Result_type__c=='inwiB2C_Discount'){
            this.__promotion_result_fields_display =this.promotion_result_fields_display_discount;
        }else{
            this.__promotion_result_fields_display =['inwiB2C_Result_type__c'];

        }

    return this.__promotion_result_fields_display; 
} 
set promotion_result_fields_display(value) {
     this.__promotion_result_fields_display = value; }



// TABLE PROMOTION RESULT

    actions_promotion_result = [
        { label: 'Afficher les Détails', name: 'show_details',iconName:'action:preview' },
        { label: 'Supprimé', name: 'delete' ,iconName:'action:delete'  }
    ];
    promotion_result_columns = [
        { label: "Name", fieldName: "Name", hideDefaultActions: true },
        { label: "Result type", fieldName: "resultTypeLabel", hideDefaultActions: true },
        { label: "Code attribut", fieldName: "inwiB2C_code_attribute__c", hideDefaultActions: true },
        { label: "Valeur attribut", fieldName: "inwiB2C_valeur_attribut__c", hideDefaultActions: true },
        { label: "Type de prix", fieldName: "inwiB2C_type_de_prix__c", hideDefaultActions: true },
        { label: "Percent", fieldName: "inwiB2C_percent__c", hideDefaultActions: true },
        {
            type: 'action',
            typeAttributes: { rowActions: this.actions_promotion_result },
            hideDefaultActions: true
        }
    ];
    


// EVENT FROM  PROMOTION RESULT CREATED

handleCancelPromotionResultCreated(e){
    console.log('handleCancelPromotionResultCreated');
    this.is_creation_promotion_result=false;
}


handleChangePromotionResultCreated(e){
  
    let val = e.detail.value
   
    try {
        if (val == 'inwiB2C_Action') {
            this.add_promotion_result_fields = this.promotion_result_fields_display_action;
        } else if (val == 'inwiB2C_Discount') {
            this.add_promotion_result_fields = this.promotion_result_fields_display_discount;
        }

    } catch (error) {
        console.error('handleChangePromotionResultCreated: ' + error);

    }


}

handleSubmitPromotionResultCreated(event) {
   
    try {
        event.preventDefault(); // stop the form from submitting
        const fields = event.detail.fields;
        fields.inwiB2C_Promotion_discount__c = this.recordId;
        this.template.querySelector(".addpromotionresult").submit(fields);

        this.related_promotion_result.push(fields);

    } catch (error) {
        console.log('handleSubmitPromotionResultCreated error ' + error);

    }

}

handlFailurePromotionResultCreated(error) {
    console.error('handlFailurePromotionResultCreated error: ' + error);
}


handleSuccessPromotionResultCreated(e) {
    this.is_creation_promotion_result = false;
    this.add_promotion_result_fields = ['inwiB2C_Result_type__c']

    get_promotion_result({ idPromotion: this.recordId })
        .then(result => {

         this.related_promotion_result = result;
          
          this.dispatchEvent(new ShowToastEvent({
            title: 'Success!!',
            message: 'Promotion Result a été Créé',
            variant: 'success'
         }),);
      }).catch(error => {
        window.console.log('Error ====> '+error);
         this.dispatchEvent(new ShowToastEvent({
             title: 'Error!!', 
             message: error.message, 
             variant: 'error'
        }),);
    });
       
}


DeleteRecorResultdById(id) {

    deleteRecord(id);

    setTimeout(() => {
        get_promotion_result({ idPromotion: this.recordId })
            .then(result => {

                this.related_promotion_result = result;
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Success!!',
                    message: ' Promotion Result a eté Supprimé',
                    variant: 'success'
               }),);
               eval("$A.get('e.force:refreshView').fire();");         
                  })
       .catch(error => {
               window.console.log('Error ====> '+error);
               this.dispatchEvent(new ShowToastEvent({
                      title: 'Error!!', 
                      message: error.message, 
                      variant: 'error'
                 }),);
           });
    
    }, 1000);

    }

handlePromotionResultRowAction(event) {
    console.log('handlePromotionResultRowAction');

    const actionName = event.detail.action.name;
    const row = event.detail.row;
    switch (actionName) {
        case 'delete':
            this.DeleteRecorResultdById(row.Id);
            break;
        case 'show_details':
            this.showDetails_PromotionResult(row);
            break;
        default:
    }
}

showDetails_PromotionResult(row) {
 
    try {
        let tempRow = JSON.parse(JSON.stringify(row));
        let val =row.inwiB2C_Result_type__c;
        try {
            if (val == 'inwiB2C_Action') {
                this.promotion_result_fields_display = this.promotion_result_fields_display_action;
            } else if (val == 'inwiB2C_Discount') {
                this.promotion_result_fields_display = this.promotion_result_fields_display_discount;
            }else {
                this.promotion_result_fields_display = ['inwiB2C_Result_type__c'];
            } 
        } catch (error) {
            console.error('handleChangepromotion_resultEdited: ' + error);

        }

        this.selected_promotion_result = tempRow;

    } catch (error) {
        console.error('showDetails_PromotionResult error : ' + error);

    }
    
}

handleChangepromotion_resultEdited(e) {
    console.log('handleChangepromotion_resultEdited');

    let val = e.detail.value
    console.log('handleChangepromotion_resultEdited val : '+ val);

    try {
        if (val == 'inwiB2C_Action') {
            this.promotion_result_fields_display = this.promotion_result_fields_display_action;
        } else if (val == 'inwiB2C_Discount') {
            this.promotion_result_fields_display = this.promotion_result_fields_display_discount;
        }


    } catch (error) {
        console.error('handleChangepromotion_resultEdited: ' + error);

    }

}


// EVENT OBJECT PROMOTION RESULT EDITED S

handleCancelpromotion_resultEdited(e) {
    console.log('handleCancelpromotion_resultEdited');
 
}
handleSubmipromotion_resultEdited(e) {
    console.log('handleSubmipromotion_resultEdited');
}
handleSuccesspromotion_resultEdited(e) {
    console.log('handleSuccesspromotion_resultEdited');

    
    get_promotion_result({ idPromotion: this.recordId })
    .then(result => {

        this.related_promotion_result = result;

    })
    .catch(error => {
        console.error('handleSuccessPromotionResultCreated get_promotion_result error' + error);

    });
}
handleFailurepromotion_resultEdited(error) {
    console.error('handleFailurepromotion_resultEdited error: ' + error);
}






}