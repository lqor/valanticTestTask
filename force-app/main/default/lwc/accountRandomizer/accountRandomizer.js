import { LightningElement, wire, api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Account.Name';

import doStringRandomizerCallout from '@salesforce/apex/StringGeneratorCallout.doStringRandomizerCallout';

export default class AccountRandomizer extends LightningElement {
    accountFields = [NAME_FIELD];

    @api recordId;
    @api objectApiName;

    randomName;
    isTrigger;
    error;
    isLoading;

    @wire( getRecord, { 
            recordId: '$recordId', 
            fields: ['$accountFields']
    }) account;

    get name() {
        return getFieldValue(this.account.data, NAME_FIELD);
    }

    handleRandomized(event) {
        this.isLoading = true;

        doStringRandomizerCallout({ accountId: this.recordId })
            .then(result => {
                this.randomName = result;
            })
            .catch(error => {
                this.error = error;
            })
            .finally(() => {
                this.isLoading = false;
            })
    }

    handleSubmit(event){
        event.preventDefault();     

        console.log(this.isTrigger);
        if(!this.isTrigger) {
            return;
        }

        const fields = event.detail.fields;
        fields.Name = this.randomName;
        
        this.template.querySelector('lightning-record-edit-form').submit(fields);
        this.toggleCheckbox();
    }

    toggleCheckbox() {
        this.isTrigger = !this.isTrigger;
    }
}