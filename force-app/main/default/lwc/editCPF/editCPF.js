import { LightningElement, api } from 'lwc';

import CPF_FIELD from '@salesforce/schema/Account.CPF__c';

export default class RecordFormStaticAccount extends LightningElement {
    // Flexipage provides recordId and objectApiName
    @api recordId;
    @api objectApiName;

    fields = [CPF_FIELD];
}