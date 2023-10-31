//import { reduceErrors } from 'c/ldsUtils';
import { LightningElement, wire,api,track } from 'lwc';
// import FIRST_NAME_FIELD from '@salesforce/schema/Contact.FirstName';
// import LAST_NAME_FIELD from '@salesforce/schema/Contact.LastName';
// import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import { subscribe, unsubscribe, onError, setDebugFlag, isEmpEnabled } from 'lightning/empApi';
import getContacts1 from '@salesforce/apex/ContactController.getContacts1';
import updateContacts from '@salesforce/apex/ContactController.updateContacts';
import {RefreshEvent} from 'lightning/refresh';
//import customlabels from 'c/customLabels';

// const COLUMNS = [{
//         label: 'First Name',
//         fieldName: FIRST_NAME_FIELD.fieldApiName,
//         type: 'text'
//     },
//     {
//         label: 'Last Name',
//         fieldName: LAST_NAME_FIELD.fieldApiName,
//         type: 'text'
//     },
//     {
//         label: 'Email',
//         fieldName: EMAIL_FIELD.fieldApiName,
//         type: 'email'
//     },
// ];

export default class ContactList extends LightningElement {

    // columns = COLUMNS;
    //errors;
    @api channelName='/event/Contact__e';
    @api recordId;
    @track data;
    subscription;
    runOnce  = false;
    levelField;
    @track myLabels = customlabels;
    connectedCallback(){
        this.getData();    
    }

    renderedCallback(){
        if(!this.runOnce){
            this.handleSubscribe();
            this.runOnce =  !this.runOnce;
        }
    }

    getData(){
        getContacts1()
        .then(result=>{
            console.log('result; ', result);
            this.data = result;
            this.error=undefined;
            // console.log('contacts',JSON.stringify(this.data));
        })
        .catch(error=>{
            this.error= "error";
            this.data=undefined;
        })
    }

    handleSubscribe(){
        // Invoke subscribe method of empApi. Pass reference to messageCallback
        subscribe(this.channelName, -1, this.messageCallback).then((response) => {
            // Response contains the subscription information on subscribe call
            console.log('Subscription request sent to: ',JSON.stringify(response.channel));
            this.subscription = response;
            console.log('response',JSON.stringify(this.subscription));
        })       
    }

    
        messageCallback = (response) => {
            console.log('New message received: ', JSON.stringify(response));

            this.getData();
            this.levelField = response.data.payload.Level__c;
            console.log('value',this.levelField);
            this.updateFields();
        };

        
    registerErrorListener() {
        // Invoke onError empApi method
        onError((error) => {
            console.log('Received error from server: ', JSON.stringify(error));
            // Error contains the server-side error
        });
    }
    updateFields(){
        
        updateContacts({level:this.levelField,recordId:this.recordId})
        .then(result=>{
            console.log('result--->',result);
            this.dispatchEvent(new RefreshEvent());
        })
        .catch(error=>{
            console.log('errror-->',error);
        })

    }
}