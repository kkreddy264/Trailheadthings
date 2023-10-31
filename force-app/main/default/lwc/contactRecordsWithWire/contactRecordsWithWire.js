import { LightningElement, wire } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import Title_FIELD from '@salesforce/schema/Contact.Title';
import getContacts from '@salesforce/apex/ContactController.getContacts';
const COLUMNS = [
    {label: 'Name', fieldName: NAME_FIELD.fieldApiName, type: 'text'},
        {label: 'Email', fieldName: EMAIL_FIELD .fieldApiName, type: 'Email'},
        {label: 'Phone', fieldName: PHONE_FIELD.fieldApiName, type: 'Phone'},
        {label: 'Title', fieldName: Title_FIELD.fieldApiName, type: 'text'}
];
export default class contactRecordsWithWire extends LightningElement {
    columns = COLUMNS;
    @wire(getContacts)
    contacts;
}