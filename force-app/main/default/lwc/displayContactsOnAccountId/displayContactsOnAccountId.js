import { LightningElement, track, wire } from 'lwc';
import retrieveContactRecords from '@salesforce/apex/ContactsOnAccount.retrieveContactRecords';
 
export default class DisplayContactsOnAccountId extends LightningElement {
      
    @track accountId;
    @track records;
    @track errorMsg;    
 
    @wire (retrieveContactRecords, {accId:'$accountId'})
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