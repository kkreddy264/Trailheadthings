import { LightningElement, wire, api, track } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';
import { refreshApex } from '@salesforce/apex';
import { updateRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';
import { deleteRecord } from 'lightning/uiRecordApi'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import ID_FIELD from '@salesforce/schema/Contact.Id';

const actions = [{ label: 'Edit', name: 'edit'},{ label: 'Delete', name: 'delete'}];
const COLS = [
    { label: 'First Name', fieldName: 'FirstName', editable: true },
    { label: 'Last Name', fieldName: 'LastName', editable: true },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { type: 'action', typeAttributes: { rowActions: actions, menuAlignment : 'right'}}
];
export default class LwcContactDataTable extends LightningElement {

    @api recordId;
    columns = COLS;
    actions = actions;
    @track draftValues = [];
    @track bShowModal = false;
    @track currentRecordId;
    @track isEditForm = false;
    @track contactList = [];

    @wire(getContacts, { accId: '$recordId' })
    contact;

    handleSave(event) {

        const fields = {}; 
        fields[ID_FIELD.fieldApiName] = event.detail.draftValues[0].Id;
        fields[FIRSTNAME_FIELD.fieldApiName] = event.detail.draftValues[0].FirstName;
        fields[LASTNAME_FIELD.fieldApiName] = event.detail.draftValues[0].LastName;

        const recordInput = {fields};

        updateRecord(recordInput)
        .then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Contact updated',
                    variant: 'success'
                })
            );
            // Display fresh data in the datatable
            return refreshApex(this.contact).then(() => {

                // Clear all draft values in the datatable
                this.draftValues = [];

            });
        }).catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error updating or reloading record',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        });
    }

    handleRowActions(event) {
        let actionName = event.detail.action.name;
        let row = event.detail.row;
        switch (actionName) {
            case 'edit':
                this.editCurrentRecord(row);
                break;
                case 'delete':
                    deleteRecord(row.Id)
        return refreshApex(this.contact).then(() => {
                        this.draftValues = [];
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Success',
                                message: 'Record deleted',
                                variant: 'success'
                            })
                        );
                        // Navigate to a record home page after
                        // the record is deleted, such as to the
                        // contact home page
                        this[NavigationMixin.Navigate]({
                            type: 'standard__objectPage',
                            attributes: {
                                objectApiName: 'Contact',
                                actionName: 'delete',
                            },
                        });
                    })
                    .catch(error => {
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Error deleting record',
                                message: error.body.message,
                                variant: 'delete'
                            })
                        );
                    });
                break;
                

        }
    }
    editCurrentRecord(currentRow) {
        this.bShowModal = true;
        this.isEditForm = true;
        this.currentRecordId = currentRow.Id;
    }
    closeModal() {
        this.bShowModal = false;    
    }

    
    handleSubmit(event) {
        
        event.preventDefault();

        this.template.querySelector('lightning-record-edit-form').submit(event.detail.fields);
        this.bShowModal = false;
        this.dispatchEvent(new ShowToastEvent({
            title: 'Success',
            message: event.detail.fields.FirstName + ' '+ event.detail.fields.LastName +' Contact updated Successfully!.',
            variant: 'success'
        }),);

    }

    handleSuccess() {
        return refreshApex(this.refreshTable);
    }
    // handleRemove(event) {
    //     console.log('event',event.detail.row)
    //    let contact = this.contactList.filter(val => val.Id== event.detail.row.Id);
    //     console.log('Id',contact)
    //     var row = event.detail.row;
    //     deleteRecord({conList:row});
    //   }

}