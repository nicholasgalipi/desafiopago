import { LightningElement, api } from 'lwc';

import CNPJ_FIELD from '@salesforce/schema/Account.CNPJ__c';

export default class EditCNPJ extends LightningElement {
    // Flexipage provides recordId and objectApiName
    @api recordId;
    @api objectApiName;

    fields = [CNPJ_FIELD];
}