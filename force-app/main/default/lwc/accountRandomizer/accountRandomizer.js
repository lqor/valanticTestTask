import { LightningElement, wire, api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Account.Name';

export default class AccountRandomizer extends LightningElement {
    accountFields = [NAME_FIELD];
    @api recordId;
    clickedButtonLabel = '';

    @wire( getRecord, { 
            recordId: '001456789012345678', 
            fields: ['$accountFields']
    }) account;

    handleRandomized(event) {
        console.log(event.target.label);
        this.clickedButtonLabel = event.target.label;
    }
}