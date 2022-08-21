import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

import getCustOxygeneURLParam from '@salesforce/apex/inwiB2C_openLegacy360.getCustOxygeneURLParam';
import getSubscriptionOxygeneURLParam from '@salesforce/apex/inwiB2C_openLegacy360.getSubscriptionOxygeneURLParam';
import getBillAcctOxygeneURLParam from '@salesforce/apex/inwiB2C_openLegacy360.getBillAcctOxygeneURLParam';
import getCustPeopleSoftURLParam from '@salesforce/apex/inwiB2C_openLegacy360.getCustPeopleSoftURLParam';
import getSubscriptionPeopleSofURLParam from '@salesforce/apex/inwiB2C_openLegacy360.getSubscriptionPeopleSofURLParam';
import getBillAcctPeopleSofURLParam from '@salesforce/apex/inwiB2C_openLegacy360.getBillAcctPeopleSofURLParam';


export default class InwiB2C_openLegacy360 extends NavigationMixin(LightningElement) {

    @api recordId;
    @api objectType;
    @api community;

    targetURL;


    open360PeopleSoft(event){

        console.log(event.target.label);
        console.log(this.recordId);

        if (this.objectType == 'Consumer'){

            console.log('in consumer');

            getCustPeopleSoftURLParam({AccountId: this.recordId})
                .then(result => {
                    this.targetURL = result;

                    console.log(result);

                   this[NavigationMixin.Navigate]({
                        type: 'standard__webPage',
                        attributes: {
                            url: this.targetURL
                            }
                        },
                        false 
                    );
                })
                .catch(error => {
                    console.log(error);
                });

        }else if (this.objectType == 'Billing'){

            getBillAcctPeopleSofURLParam({billAcctId: this.recordId})
            .then(result => {
                this.targetURL = result;

                this[NavigationMixin.Navigate]({
                        type: 'standard__webPage',
                        attributes: {
                            url: this.targetURL
                        }
                    },
                    false // Replaces the current page in your browser history with the URL
                );

            })
            .catch(error => {
                console.log(error);
            });

        }else if (this.objectType == 'Subscription'){

            getSubscriptionPeopleSofURLParam({subscriptionId: this.recordId})
            .then(result => {
                this.targetURL = result;

                this[NavigationMixin.Navigate]({
                    type: 'standard__webPage',
                    attributes: {
                        url: this.targetURL
                    }
                },
                false // Replaces the current page in your browser history with the URL
            );
            })
            .catch(error => {
                console.log(error);
            });

        }

    }

    open360Oxygene (event){

        console.log(event.target.label);
        console.log(this.recordId);

        if (this.objectType == 'Consumer'){

            console.log('in consumer');

            getCustOxygeneURLParam({AccountId: this.recordId})
                .then(result => {
                    this.targetURL = result;

                    console.log(result);

                   this[NavigationMixin.Navigate]({
                        type: 'standard__webPage',
                        attributes: {
                            url: this.targetURL
                            }
                        },
                        false 
                    );
                })
                .catch(error => {
                    console.log(error);
                });

        }else if (this.objectType == 'Billing'){

            getBillAcctOxygeneURLParam({billAcctId: this.recordId})
            .then(result => {
                this.targetURL = result;

                this[NavigationMixin.Navigate]({
                        type: 'standard__webPage',
                        attributes: {
                            url: this.targetURL
                        }
                    },
                    false // Replaces the current page in your browser history with the URL
                );

            })
            .catch(error => {
                console.log(error);
            });

        }else if (this.objectType == 'Subscription'){

            getSubscriptionOxygeneURLParam({subscriptionId: this.recordId})
            .then(result => {
                this.targetURL = result;

                this[NavigationMixin.Navigate]({
                    type: 'standard__webPage',
                    attributes: {
                        url: this.targetURL
                    }
                },
                false // Replaces the current page in your browser history with the URL
            );
            })
            .catch(error => {
                console.log(error);
            });

        }

    }





}