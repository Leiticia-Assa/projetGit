import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { deleteRecord } from 'lightning/uiRecordApi';

import get_applied_product from '@salesforce/apex/InwiB2C_ManageConfPromotionLWC.get_applied_product';
import get_promotion_result from '@salesforce/apex/InwiB2C_ManageConfPromotionLWC.get_promotion_result';
import get_scop_determinant from '@salesforce/apex/InwiB2C_ManageConfPromotionLWC.get_scop_determinant';
import get_determinant from '@salesforce/apex/InwiB2C_ManageConfPromotionLWC.get_determinant';

import template from "./inwiB2C_configPromotion.html";

const PROMOTION_FIELDS = [
    'InwiB2C_Promotion__c.Name',
    'InwiB2C_Promotion__c.inwiB2C_Code_Produit__c',
    'InwiB2C_Promotion__c.inwiB2C_code_promotion__c',
    'InwiB2C_Promotion__c.inwiB2C_date_fin__c',
    'InwiB2C_Promotion__c.InwiB2C_date_Debut__c',
    'InwiB2C_Promotion__c.inwiB2C_Libelle_promotion__c',
    'InwiB2C_Promotion__c.InwiB2C_Type_promotion__c'];



export default class InwiB2C_configPromotion extends LightningElement {

    @api objectApiName;
    @api recordId;
    //   recordId = 'a753M000000AsxdQAC';

    connectedCallback() {
        console.log('connectedCallback');

        console.log('connectedCallback_this.recordId: ' + this.recordId);
        console.log('connectedCallback PicklistValuesss: ' + this.PicklistValuesss);

        console.log('connectedCallback record: ' + this.recordId);


        get_scop_determinant({ idPromotion: this.recordId })
            .then(result => {

                this.related_scope_determinant = result;
                console.log('connectedCallback get_scop_determinant result' + JSON.stringify(result));

            })
            .catch(error => {
                console.error('connectedCallback get_scop_determinant error' + error);

            });


            get_promotion_result({ idPromotion: this.recordId })
            .then(result => {

                this.related_promotion_result = result;
                console.log('connectedCallback get_promotion_result result' + JSON.stringify(result));

            })
            .catch(error => {
                console.error('connectedCallback get_promotion_result error' + error);

            });


        get_applied_product({ idPromotion: this.recordId })
            .then(result => {

                this.related_applied_product = result;
                console.log('connectedCallback get_promotion_result result' + JSON.stringify(result));

            })
            .catch(error => {
                console.error('connectedCallback get_promotion_result error' + error);

            });

    }

    @wire(getRecord, { recordId: '$recordId', fields: PROMOTION_FIELDS })
    promotion;

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
    
    
    
            get_promotion_result({ idPromotion: this.recordId })
                .then(result => {
    
                    this.related_promotion_result = result;
                    console.log('connectedCallback get_promotion_result result' + JSON.stringify(result));
    
                })
                .catch(error => {
                    console.error('connectedCallback get_promotion_result error' + error);
    
                });        
        
        }, 1000);

        }

    // PROMOTION METHODES START

    promotion_fields_display = [
        'Name',
        'InwiB2C_Type_promotion__c',
        'inwiB2C_Code_Produit__c',
        'inwiB2C_code_promotion__c',
        'inwiB2C_date_fin__c',
        'InwiB2C_date_Debut__c'
    ];


    handleCancelPromotionEdited(e){
        console.log('handleCancelPromotionEdited');

    }
    handleChangePromotionEdited(e) {
        console.log('handleChangePromotionEdited');
    }
    handleSubmiPromotionEdited(event) {
        console.log('handleSubmiPromotionEdited');
    }
    handleSuccessPromotionEdited(e) {
        console.log('handleSuccessPromotionEdited');
    }

    // PROMOTION METHODES END







        // APPLIED PRODUCT METHODES START 






        // APPLIED PRODUCT METHODES END 

    is_creation_applied_product = false;
    addAppliedProduct(e) {
        console.log('addAppliedProduct s');

        if (this.is_creation_applied_product == false) this.is_creation_applied_product = true;
        else this.is_creation_applied_product = false;

        console.log('end addAppliedProduct');

    }


    
    selected_applied_product = {};

    get selected_applied_product_str(){
        return JSON.stringify(this.selected_applied_product)
    }
    get applied_product_fields_display_str(){
        return JSON.stringify(this.applied_product_fields_display)
    }

    __related_applied_product = [];
    get related_applied_product() { return this.__related_applied_product; } 
    set related_applied_product(value) { this.__related_applied_product = value; }
    

    get has_applied_product(){
        return this.related_applied_product.length !=0;
    }

    get is_applied_product_selected() {
        return Object.keys(this.selected_applied_product).length != 0
    }


    
    applied_product_fields_display_action = ['inwiB2C_Result_type__c','inwiB2C_code_attribute__c','inwiB2C_valeur_attribut__c'];

    applied_product_fields_display_discount = [
        
        'inwiB2C_Libelle_du_produit__c',
        'inwiB2C_Code_Produit__c',
    ];



    __applied_product_fields_display = [
        
        'inwiB2C_Libelle_du_produit__c',
        'inwiB2C_Code_Produit__c',
    ];
    get applied_product_fields_display() { 
/*
        if(this.__applied_product_fields_display.length==0)
            if(this.selected_applied_product.inwiB2C_Result_type__c=='inwiB2C_Action'){
                this.__applied_product_fields_display = this.applied_product_fields_display_action;
            }else if(this.selected_applied_product.inwiB2C_Result_type__c=='inwiB2C_Discount'){
                this.__applied_product_fields_display =this.applied_product_fields_display_discount;
            }else{
                this.__applied_product_fields_display =['inwiB2C_Result_type__c'];

            }
*/
        return this.__applied_product_fields_display; 
    } 
    set applied_product_fields_display(value) { this.__applied_product_fields_display = value; }


    actions_applied_product = [
        { label: 'Show details', name: 'show_details' },
        { label: 'Delete', name: 'delete' }
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


    add_applied_product_fields = [
        'inwiB2C_Libelle_du_produit__c',
        
        'inwiB2C_Code_Produit__c',
    ];




    handleCancelAppliedProducttCreated(e){
        console.log('handleCancelAppliedProducttCreated');
        this.is_creation_applied_product=false;
    }
    handleChangeAppliedProducttCreated(e){
        console.log('handleChangeAppliedProducttCreated');

        /*
        let val = e.detail.value
        console.log('handleChangeAppliedProducttCreated val : '+ val);

        try {
            if (val == 'inwiB2C_Action') {
                this.add_applied_product_fields = this.applied_product_fields_display_action;
            } else if (val == 'inwiB2C_Discount') {
                this.add_applied_product_fields = this.applied_product_fields_display_discount;
            }


        } catch (error) {
            console.error('handleChangeAppliedProducttCreated: ' + error);

        }
*/

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

            console.log('handleSubmitAppliedProducttCreated temp: ' + temp);


            this.related_applied_product.push(fields);
            console.log('end handleSubmitAppliedProducttCreated: ');


        } catch (error) {
            console.log('handleSubmitAppliedProducttCreated error ' + error);

        }

    }
    handlFailureAppliedProducttCreated(error) {
        console.error('handlFailureAppliedProducttCreated error: ' + error);
    }
    handleSuccessAppliedProducttCreated(e) {
        console.log('handleSuccessAppliedProducttCreated');
        console.log('handleSuccessScopeDeterminantCreated start');
        this.is_creation_applied_product = false;
        this.add_applied_product_fields = ['inwiB2C_Result_type__c']

        get_applied_product({ idPromotion: this.recordId })
            .then(result => {

                this.related_applied_product = result;
                console.log('handleSuccessAppliedProducttCreated get_applied_product result' + JSON.stringify(result));

            })
            .catch(error => {
                console.error('handleSuccessAppliedProducttCreated get_applied_product error' + error);

            });
        console.log('handleSuccessScopeDeterminantCreated end');
    }


    handleChangeapplied_productEdited(e) {
        console.log('handleChangeapplied_productEdited');
/*
        let val = e.detail.value
        console.log('handleChangeapplied_productEdited val : '+ val);

        try {
            if (val == 'inwiB2C_Action') {
                this.applied_product_fields_display = this.applied_product_fields_display_action;
            } else if (val == 'inwiB2C_Discount') {
                this.applied_product_fields_display = this.applied_product_fields_display_discount;
            }


        } catch (error) {
            console.error('handleChangeapplied_productEdited: ' + error);

        }
*/
    }
    handleCancelapplied_productEdited(e) {
        console.log('handleCancelapplied_productEdited');
      //  this.is_applied_product_selected=false;
    }
    handleSubmiapplied_productEdited(e) {
        console.log('handleSubmiapplied_productEdited');
    }
    handleSuccessapplied_productEdited(e) {
        console.log('handleSuccessapplied_productEdited');

        
        get_applied_product({ idPromotion: this.recordId })
        .then(result => {

            this.related_applied_product = result;
            console.log('handleSuccessAppliedProducttCreated get_applied_product result' + JSON.stringify(result));

        })
        .catch(error => {
            console.error('handleSuccessAppliedProducttCreated get_applied_product error' + error);

        });
    }
    handleFailureapplied_productEdited(error) {
        console.error('handleFailureapplied_productEdited error: ' + error);
    }

    
    handleAppliedProducttRowAction(event) {
        console.log('handleAppliedProducttRowAction');

        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'delete':
                this.deleteRecordById(row.Id);
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


            let val =row.inwiB2C_Result_type__c;
            try {
                /*
                if (val == 'inwiB2C_Action') {
                    this.applied_product_fields_display = this.applied_product_fields_display_action;
                } else if (val == 'inwiB2C_Discount') {
                    this.applied_product_fields_display = this.applied_product_fields_display_discount;
                }else {
                    this.applied_product_fields_display = ['inwiB2C_Result_type__c'];
                } 
    */
    
            } catch (error) {
                console.error('handleChangeapplied_productEdited: ' + error);
    
            }

            this.selected_applied_product = tempRow;

        } catch (error) {
            console.error('showDetails_AppliedProductt error : ' + error);

        }
        
    }







    // PROMOTION RESULT METHODES START 

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


    
    promotion_result_fields_display_action = ['inwiB2C_Result_type__c','inwiB2C_code_attribute__c','inwiB2C_valeur_attribut__c'];

    promotion_result_fields_display_discount = [
        
        'inwiB2C_Result_type__c',

        'inwiB2C_type_de_prix__c',
        'inwiB2C_percent__c'
    ];



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
    set promotion_result_fields_display(value) { this.__promotion_result_fields_display = value; }


    actions_promotion_result = [
        { label: 'Show details', name: 'show_details' },
        { label: 'Delete', name: 'delete' }
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


    add_promotion_result_fields = [
        
        'inwiB2C_Result_type__c'];

    is_creation_promotion_result = false;
    addPromotionResult(e) {
        console.log('addPromotionResult s');

        if (this.is_creation_promotion_result == false) this.is_creation_promotion_result = true;
        else this.is_creation_promotion_result = false;

        console.log('end AddDeterminant');

    }


    handleCancelPromotionResultCreated(e){
        console.log('handleCancelPromotionResultCreated');
        this.is_creation_promotion_result=false;
    }
    handleChangePromotionResultCreated(e){
        console.log('handleChangePromotionResultCreated');

        
        let val = e.detail.value
        console.log('handleChangePromotionResultCreated val : '+ val);

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
        console.log('handleSubmitPromotionResultCreated');

        try {
            event.preventDefault(); // stop the form from submitting
            const fields = event.detail.fields;
            fields.inwiB2C_Promotion_discount__c = this.recordId;
            console.log('handleSubmitPromotionResultCreated fields: ' + JSON.stringify(fields));
            console.log('handleSubmitPromotionResultCreated addpromotionresult');
            this.template.querySelector(".addpromotionresult").submit(fields);

            console.log('handleSubmitPromotionResultCreated temp: ' + temp);


            this.related_promotion_result.push(fields);
            console.log('end handleSubmitPromotionResultCreated: ');


        } catch (error) {
            console.log('handleSubmitPromotionResultCreated error ' + error);

        }

    }
    handlFailurePromotionResultCreated(error) {
        console.error('handlFailurePromotionResultCreated error: ' + error);
    }
    handleSuccessPromotionResultCreated(e) {
        console.log('handleSuccessPromotionResultCreated');
        console.log('handleSuccessScopeDeterminantCreated start');
        this.is_creation_promotion_result = false;
        this.add_promotion_result_fields = ['inwiB2C_Result_type__c']

        get_promotion_result({ idPromotion: this.recordId })
            .then(result => {

                this.related_promotion_result = result;
                console.log('handleSuccessPromotionResultCreated get_promotion_result result' + JSON.stringify(result));

            })
            .catch(error => {
                console.error('handleSuccessPromotionResultCreated get_promotion_result error' + error);

            });
        console.log('handleSuccessScopeDeterminantCreated end');
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

    handleCancelpromotion_resultEdited(e) {
        console.log('handleCancelpromotion_resultEdited');
      //  this.is_promotion_result_selected=false;
    }
    handleSubmipromotion_resultEdited(e) {
        console.log('handleSubmipromotion_resultEdited');
    }
    handleSuccesspromotion_resultEdited(e) {
        console.log('handleSuccesspromotion_resultEdited');

        
        get_promotion_result({ idPromotion: this.recordId })
        .then(result => {

            this.related_promotion_result = result;
            console.log('handleSuccessPromotionResultCreated get_promotion_result result' + JSON.stringify(result));

        })
        .catch(error => {
            console.error('handleSuccessPromotionResultCreated get_promotion_result error' + error);

        });
    }
    handleFailurepromotion_resultEdited(error) {
        console.error('handleFailurepromotion_resultEdited error: ' + error);
    }

    
    handlePromotionResultRowAction(event) {
        console.log('handlePromotionResultRowAction');

        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'delete':
                this.deleteRecordById(row.Id);
                break;
            case 'show_details':
                console.log('handlePromotionResultRowAction show_details');
                this.showDetails_PromotionResult(row);
                break;
            default:
        }
    }

    showDetails_PromotionResult(row) {
        console.log('showDetails_PromotionResult show_details');
        console.log('showDetails_PromotionResult row : ' + JSON.stringify(row));

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
        //  
    }

    // PROMOTION RESULT METHODES END









    // SCOPE DETERMINANT METHODES START


    is_creation_Scope_Determinant = false;

    
    add_Scope_Determinant_fields = [
        
        'inwiB2C_Canal__c',
        'InwiB2C_type_acte_de_gestion__c',
        'InwiB2C_Type_d_inclution__c'
    ];

    __selected_scope_determinant = [];
    get selected_scope_determinant() { return this.__selected_scope_determinant; } 
    set selected_scope_determinant(value) { this.__selected_scope_determinant = value; }
    



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

    
    scop_determinant_fields_display = [
        
        'inwiB2C_Canal__c',
        'InwiB2C_type_acte_de_gestion__c',
        'InwiB2C_Type_d_inclution__c'
    ];

    __related_scope_determinant = [];
    get related_scope_determinant() { return this.__related_scope_determinant;} 
    set related_scope_determinant(value) {this.__related_scope_determinant = value;}
    
    
    get has_scope_determinants(){
        return this.related_scope_determinant.length !=0;
    }

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

    AddScopeDeterminant(e) {
        console.log('start AddScopeDeterminant');

        if (this.is_creation_Scope_Determinant == false) this.is_creation_Scope_Determinant = true;
        else this.is_creation_Scope_Determinant = false;

        console.log('end AddScopeDeterminant');
    }

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
            console.log('handleSubmitScopeDeterminantCreated fields: ' + JSON.stringify(fields));
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
            console.log('handleSuccessScopeDeterminantEdited get_scop_determinant result' + JSON.stringify(result));

        })
        .catch(error => {
            console.error('handleSuccessScopeDeterminantEdited get_scop_determinant error' + error);

        });

    }


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

    

    // SCOPE DETERMINANT METHODES END






    // DETERMINANT METHODES START


    is_creation_Determinant = false;

    
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



    add_Determinant_fields = [
        'inwiB2C_scope__c'
    ];

    add_Determinant_fields_order_item = [
        
        'inwiB2C_scope__c',
        'inwiB2C_Code_Produit__c',
        'inwiB2C_code_attribute__c',
        'inwiB2C_Valeur_attribut__c',
    ];

    add_Determinant_fields_assets = [
        
        'inwiB2C_scope__c',
        'inwiB2C_Code_Produit__c'
    ];

    add_Determinant_fields_infoclient = [
        
        'inwiB2C_scope__c',
        'inwiB2C_field__c',
        'inwiB2C_value__c'
    ];


    get is_determinant_selected() {
        console.log('is_determinant_selected');
        console.log('is_determinant_selected this.selected_determinant: ' + JSON.stringify(this.selected_determinant));
        console.log('is_determinant_selected Object.keys(this.selected_determinant).length: ' + Object.keys(this.selected_determinant).length);

        return Object.keys(this.selected_determinant).length != 0;
    }

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


    AddDeterminant(e) {
        console.log('start AddDeterminant');

        if (this.is_creation_Determinant == false) this.is_creation_Determinant = true;
        else this.is_creation_Determinant = false;

        console.log('end AddDeterminant');

    }

    
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

            })
            .catch(error => {
                console.error('handleSuccessDeterminantCreated error' + error);

            });
       
    }


    handleChangeDeterminantEdited(e) {
        console.log('handleChangeDeterminantEdited');
        
        let val = e.detail.value
        console.log('handleChangeDeterminantEdited val : '+ val);

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
        console.log('handleSubmiDeterminantEdited');

    }
    handleSuccessDeterminantEdited(e) {
        console.log('handleSuccessDeterminantEdited');

    }




    handleDeterminantRowAction(event) {

        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'delete':
                this.deleteRecordById(row.Id);
                break;
            case 'show_details':
                console.log('handleScopeDeterminantRowAction_ show_details');
                this.showDetails_Determinant(row);
                break;
            default:
        }
    }
    showDetails_Determinant(row) {
    console.log('showDetails_Determinant show_details');
    console.log('showDetails_Determinant row : ' + JSON.stringify(row));

    try {
        let tempRow = JSON.parse(JSON.stringify(row));

        this.selected_determinant = {};
        this.selected_determinant = tempRow;

        console.log('showDetails_Determinant this.selected_determinant : ' + JSON.stringify(this.selected_determinant));
        console.log('showDetails_Determinant row.Id : ' + row.Id);

        get_determinant({ idScopDeterminant: row.Id })
            .then(result => {

                this.related_determinant = result;
                console.log('connectedCallback_result' + JSON.stringify(result));

            })
            .catch(error => {
                console.error('connectedCallback_error' + error);

            });


    } catch (error) {
        console.error('showDetails_Determinant_error : ' + error);

    }
    //  
    }


    // DETERMINANT METHODES END



    render() {
        return template;
    }

}