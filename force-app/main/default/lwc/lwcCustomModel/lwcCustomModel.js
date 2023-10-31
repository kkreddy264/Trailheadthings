import { LightningElement,track,api} from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import contactLastName from '@salesforce/schema/Contact.LastName';
import contactPhone from '@salesforce/schema/Contact.Phone';
import contactEmail from '@salesforce/schema/Contact.Email';
import contactDescription from '@salesforce/schema/Contact.Description';
 
export default class LwcCustomModal extends LightningElement {
    @track customFormModal = false; 
    @api contactId;
    lastName = '';
    phoneNo = '';
    email = '';
    description = '';

    customShowModalPopup() {            
        this.customFormModal = true;
    }
 
    customHideModalPopup() {    
        
        this.customFormModal = false;
    }
    handleOnChange(event){
        console.log(event.target.label);
        console.log(event.target.value);

            if(event.target.label === 'LastName'){
                this.lastName = event.target.value;
                console.log('name ',this.lastName);
            }
           else if(event.target.label === 'Phone'){
                this.phoneNo = event.target.value;
                console.log('ph ',this.phoneNo);
            }
           else if(event.target.label === 'Email'){
                this.email = event.target.value;
                console.log('mail ',this.email);
            }
            else{
                this.description = event.target.value;
                console.log('des ',this.description)
            }
    }
    createContactAction(){
        var fields = {};
        fields[contactLastName.fieldApiName] = this.lastName;
        fields[contactPhone.fieldApiName] = this.phoneNo;
        fields[contactEmail.fieldApiName] = this.email;
        fields[contactDescription.fieldApiName] = this.description;
        console.log('fields===> ',fields)
        var recordInput = {'apiName': 'Contact', fields};
        createRecord(recordInput)
        console.log('input>>>> ',recordInput)
                   .then(contactobj=> {
                this.contactId = contactobj.id;
                console.log('Id ',this.contactId)
                this.fields={};
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Contact created successfully..!',
                        variant: 'success',
                    }),
                );
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: contactobj.id,
                        objectApiName: 'Contact',
                        actionName: 'view'
                    },
                });
 
 
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
    }
   
}