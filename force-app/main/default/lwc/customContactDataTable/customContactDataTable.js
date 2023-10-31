import { LightningElement, wire, api,track } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';
import { refreshApex } from '@salesforce/apex';
import { updateRecord } from 'lightning/uiRecordApi';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import FirstName from '@salesforce/schema/Contact.FirstName';
export default class CustomContactDataTable extends LightningElement {

    @api contactList;
    connectedCallback(){
        console.log('Display contact', JSON.stringify(this.contactList))
    }
    handleOnEdit(event){
        console.log('edit',event.target.dataset.id)
        var selectedId = event.target.dataset.id;
        // console.log('event',this.contactList)
        const custEvent = new CustomEvent(
            'editclick', {
                detail: selectedId
            });
            
        this.dispatchEvent(custEvent);
    
        }
        handleOnChange(event){
            console.log('event',event.target.name)
            var selectedId = event.target.dataset.id;
            var firstName = event.target.name;
            console.log('name',firstName)
            var fieldValue = event.target.value;
            console.log('name',fieldValue)
            var selectedList ={Id:selectedId, name:firstName, value:fieldValue};
            const custEvent = new CustomEvent(
                'changevalue', {
                    detail: selectedList
                });
                
            this.dispatchEvent(custEvent);
            }   

}