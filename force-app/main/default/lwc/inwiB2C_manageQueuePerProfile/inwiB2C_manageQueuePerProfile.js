import { LightningElement,wire,api, track } from 'lwc';

import template from './inwiB2C_manageQueuePerProfile.html';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';



import getProfilesList from '@salesforce/apex/InwiB2C_manageQueuePerProfile.getProfilesList';
import getQueuesList from '@salesforce/apex/InwiB2C_manageQueuePerProfile.getQueuesList';
import getQueuesByProfile from '@salesforce/apex/InwiB2C_manageQueuePerProfile.getQueuesByProfile';
import InsertProfileQueues from '@salesforce/apex/InwiB2C_manageQueuePerProfile.InsertProfileQueues';

export default class InwiB2C_manageQueuePerProfile extends LightningElement {

    @track profileList;

    @track profileListolumns = [
        {fieldName: 'Name', label: 'Nom', hideDefaultActions: true}
        ];

    @track error;

    @track queueList;
    
    @track selectedProfile;
    
    @track receivedProfileQueues= [];

    _selectedQueueList = [];


    @wire(getProfilesList,{
        
        }) ProfileTemp({ error, data }) {
            if (data) {
                this.profileList = data;

                
            } else if (error) {
                this.error = error;
            }
        }
    
    @wire(getQueuesList,{
        
        }) QueuesTemp({ error, data }) {
            if (data) {

                this.queueList = [];

                data.forEach(item => {

                    this.queueList.push({
                        value: item.Name,
                        label: item.Name

                    });

                })
                
                
                
            } else if (error) {
                this.error = error;
            }
        }


    get profileQueueList() {
        return this.receivedProfileQueues;
    }
    
    retrieveProfileQueueList (){

        getQueuesByProfile ({
            Profile: this.selectedProfile
        }).then(( data) => {

            if (data) {
                let tempProfileQueueList = [];

                data.forEach(item => {

                    tempProfileQueueList.push(item.Name);

                })
                        
                //console.log('ProfileQueueListsdfsd: ' + JSON.stringify(tempProfileQueueList));

                this.receivedProfileQueues=  tempProfileQueueList;
            }
            
        })
        .catch((error) => {
            const message = 'Error received: code' + error.errorCode;

            console.log(error);

                const evt = new ShowToastEvent({
                    title: 'Erreur',
                    message: 'Erreur à la récupération des Files d attente ',
                    variant: 'error',
                });
                this.dispatchEvent(evt);
            
        });
        


    }

    render() {

        //console.log(this.omniJsonData);
        return template;
    }

    handleProfileSelection(event) {
        const selectedRows = event.detail.selectedRows;

        //console.log(JSON.stringify(selectedRows));

        // Display that fieldName of the selected rows
        for (let i = 0; i < selectedRows.length; i++){
            this.selectedProfile = selectedRows[i].Name;
        }

        this.retrieveProfileQueueList();
        

        //console.log(this.selectedProfile);
    }
    
    handleQueueListChange(event) {
       
        this._selectedQueueList = event.detail.value;
        //console.log(this._selectedQueueList);
    }

    handleQueueSave(){
        InsertProfileQueues ({
            Profile: this.selectedProfile,
            Queues: this._selectedQueueList
        }).then(() => {
            this.retrieveProfileQueueList();

            const evt = new ShowToastEvent({
                title: 'Succès',
                message: 'La liste des Files est bien sauvegardée',
                variant: 'success',
            });
            this.dispatchEvent(evt);
            //console.log('ok');
            
        })
        .catch((error) => {
            const message = 'Error received: code' + error.errorCode;

            console.log(error);

            const evt = new ShowToastEvent({
                    title: 'Erreur',
                    message: 'Erreur à la sauvegarde',
                    variant: 'error',
                });
            this.dispatchEvent(evt);
            
        });

    }

}