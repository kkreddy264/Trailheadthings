import { LightningElement, track, wire } from 'lwc';
import getContacts from '@salesforce/apex/AccountContactsController.getContacts';
 
export default class ContactDataTable extends LightningElement {
      
    @track accountId;
    @track records;
    @track errorMsg;    
 
    @wire (getContacts, {accountId:'$accountId'})
      wireConRecord({error,data}){
        if(data){
          this.records = data;     
          this.errorMsg = undefined;    
        }else{         
          this.errorMsg = error;
          this.records = undefined;
        }
      }
 
    handleChangeAction(event){
      this.accountId = event.detail;
      window.console.log('accountId ' + this.accountId);
    }
 
 
}