import { LightningElement,api,wire} from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { getRecord } from 'lightning/uiRecordApi';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import CONTACTFIRSTNAME from '@salesforce/schema/Contact.FirstName';
import CONTACTLASTNAME from '@salesforce/schema/Contact.LastName';
import CONTACTEMAIL from '@salesforce/schema/Contact.Email';
import CONTACTPHONE from '@salesforce/schema/Contact.Phone';
//import { updateRecord } from 'lightning/uiRecordApi';
//import { deleteRecord } from 'lightning/uiRecordApi';

export default class RecordCreationByJavaScript extends LightningElement {

    @api recordId;
    FirstName ='';
    LastName='';
    Email='';
    Phone='';

    @wire(getRecord,{recordId:'$recordId'})
    Contacts;
    changedValues(event){
        
        if(event.target.label == 'First Name'){
            this.FirstName = event.target.value;
        }
        if(event.target.label == 'Last Name'){
            this.LastName = event.target.value;
        }
        if(event.target.label == 'Email'){
            this.Email = event.target.value;
        }   
        if(event.target.label == 'Phone'){
            this.Phone = event.target.value;
        }   
        console.log('name',this.FirstName);
    }
    handleCreate(event){
        const data = {};
        console.log('detail',event.detail);
        data[CONTACTFIRSTNAME.fieldApiName] = this.FirstName;
        data[CONTACTLASTNAME.fieldApiName] = this.LastName;
        data[CONTACTEMAIL.fieldApiName] = this.Email;
        data[CONTACTPHONE.fieldApiName] = this.Phone;
        
        console.log('data',data);
        const recordInput =  {apiName:CONTACT_OBJECT.objectApiName,data};
        createRecord(recordInput)
        .then(response =>{
            console.log('response',response);
            this.showToast("success", "Record is Created Successfully", "success");
        })
        .catch(error =>{
            console.log('error',error.body.message);
            this.showToast("error", "Failed to create a record", "error");
        });
        
    }

    showToast(title, message, variant){
        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message,
                variant: variant
            }),
        );
    }
}