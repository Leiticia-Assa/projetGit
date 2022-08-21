import { LightningElement, wire , track} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { subscribe, unsubscribe, onError, setDebugFlag, isEmpEnabled } 
    from 'lightning/empApi';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import template from './inwiB2C_IncidentReseauDisplay.html';
import getIncidentReseau from '@salesforce/apex/inwiB2C_IncidentReseauController.getIncidentReseau';
import { refreshApex } from '@salesforce/apex';


export default class InwiB2C_IncidentReseauDisplay extends NavigationMixin(LightningElement) {

    channelName = '/event/inwiB2C_Incident_Reseau__e';
    isSubscribeDisabled = false;
    isUnsubscribeDisabled = !this.isSubscribeDisabled;
    @track choix=null;
    subscription = {};
    subscribed = false;
    rendered = false;

    columns = [
        { label: 'Titre', fieldName: 'inwib2c_Titre__c', cellAttributes:
                { iconName: { fieldName: 'inwiB2C_Icon' }, iconPosition: 'left' }, hideDefaultActions: true , editable: false, initialWidth: 400},
        { label: 'Etat', fieldName: 'inwib2c_Etat__c',  hideDefaultActions: true , editable: false , initialWidth: 100},
        {label: 'Détails', type: "button-icon", typeAttributes: { label: "Voir Details", name: "view_details", title: 'Click to View Details', iconName: 'utility:link'},  hideDefaultActions: true , editable: false}
    ];

    //custom:custom53 custom95 custom109
    get options() {
        return [
            { label: 'GSM', value: 'InwiB2C_GSM' },
            { label: 'FTTH/ADSL', value: 'InwiB2C_FTTH_ADSL' },
            { label: 'Tout', value: 'All' }


        ];
    }
    selectedincident(event){        
        this.choix = event.detail.value;
        console.log(this.choix);
    }

   get records (){

        let result = [];



        let yesterday = new Date();
  
        // subtract one day from current time                           
        yesterday.setDate(yesterday.getDate() - 1); 

        //console.log (yesterday);

        //console.log(JSON.stringify(this.incidentReseau));
        
        if (this.incidentReseau ) { 

            this.incidentReseau.forEach(incident => {

                let newIncident = {
                    inwib2c_Titre__c: incident.inwib2c_Titre__c,
                    inwib2c_Etat__c: incident.inwib2c_Etat__c,
                    Id: incident.Id
                }

                if (incident.inwib2c_Severite__c == 'Critique'){
                    newIncident.inwiB2C_Icon = 'custom:custom53';
                }else {
                    newIncident.inwiB2C_Icon = 'custom:custom109';
                }
                /*let createdDate = new Date(incident.CreatedDate);

                if (createdDate >=  yesterday) {
                    newIncident.inwiB2C_Icon = 'custom:custom53';
                } else if (incident.inwib2c_Etat__c === 'En cours'){
                    newIncident.inwiB2C_Icon = 'custom:custom109';
                } else {
                    newIncident.inwiB2C_Icon = 'custom:custom95';
                }*/
                //console.log(JSON.stringify(newIncident));

                result.push (newIncident);

            });
        }

        return result;

   }



    incidentReseau = [];
    error;
    @track wiredIncidentList;


    @wire(getIncidentReseau,{choix:'$choix'}) incidentReseauReply(result) {
        this.wiredIncidentList = result;
        if (result.data) {
            this.incidentReseau = result.data;
            console.log('test'+result)
            

            
        } else if (result.error) {
            this.error = result.error;
        }
    }

    refreshData(){

        console.log('in refresh data');
        return refreshApex(this.wiredIncidentList);
    }

    render(){

        return template;
    }

    handleRowAction(event){
        

        const action = event.detail.action;
        const row = event.detail.row;
        switch (action.name) {
            case 'view_details':
                console.log ('button clicked');
                console.log(row.Id);
                this.navigateToRecordPage('inwib2c_IncidentReseau__c',row.Id );
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


    // Callback invoked whenever a new event message is received
    messageCallbackHandler (response) {


        
        console.log('New message received: ', JSON.stringify(response));

        this.dispatchEvent(
            new ShowToastEvent({
            title: 'Nouvel Incident Reseau',
            message: 'Titre: ' + response.data.payload.inwib2c_Titre__c,
            variant: 'error',
            messageData: [{
                url: '/'+response.data.payload.InwiB2C_Id_Incident__c,
                label: 'Click Here',
                }]
            }),
        );

        this.refreshData();
        

        
        // Response contains the payload of the new message received
    };

    handleSubscribe() {   

        console.log('subscribe : ' + this.subscribed + '---' + JSON.stringify(isEmpEnabled()));
        
        const messageCallback = this.messageCallbackHandler.bind(this);

        setDebugFlag(true);

        // Invoke subscribe method of empApi. Pass reference to messageCallback
        subscribe(this.channelName, -1, messageCallback).then(response => {
            // Response contains the subscription information on subscribe call
            console.log('Subscription request sent to: ', JSON.stringify(response.channel));
            this.subscription = response;
            this.subscribed = true;
            //this.toggleSubscribeButton(true);
        });
    }

    // Handles unsubscribe button click
    handleUnsubscribe() {
       console.log('unsubscribe');

        // Invoke unsubscribe method of empApi
        unsubscribe(this.subscription, response => {
            console.log('unsubscribe() response: ', JSON.stringify(response));
            // Response is true for successful unsubscribe
            this.subscribed = false;
        });
    }

    /*connectedCallback(){

        console.log('in connectedCallback : ' + this.subscribed + ' - ' + this.rendered);
        if (! this.subscribed && ! this.rendered) {

            this.rendered = true;
            this.handleSubscribe();
        }
    }*/

    registerErrorListener() {
        // Invoke onError empApi method
        onError(error => {
            console.log('Received error from server: ', JSON.stringify(error));
            // Error contains the server-side error
        });
    }

    // Initializes the component
    connectedCallback() {       
        // Register error listener   
        this.choix;    
        this.registerErrorListener();      
    }

 
    renderedCallback(){
        onclick="console.log(1)"; 
    }


    
}