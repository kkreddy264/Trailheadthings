import { LightningElement } from 'lwc';

export default class DependentLookup extends LightningElement {
    parentAccountSelectedRecord;
    parentContactSelectedRecord;

    handleValueSelectedOnAccount(event) {
        this.parentAccountSelectedRecord = event.detail;
    }

    handleValueSelectedOnContact(event) {
        this.parentContactSelectedRecord = event.detail;
    }
}