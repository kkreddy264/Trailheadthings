import { LightningElement, track, api} from 'lwc';
import accountFields from '@salesforce/apex/AccountListControllerLwc.accountFields';
import { getRecord } from 'lightning/uiRecordApi';
export default class CustomLightningDatatable extends LightningElement {
      @api recordId;
      @track AccountFields =[];
      @track error;
      connectedCallback(){
        accountFields()
        .then(result =>{
            
            this.AccountFields = result;
            console.log('fields',this.AccountFields);
            this.error = undefined;
        })
        .catch(error=>{
            this.error = error;
            this.accountFields= undefined;
        })
      }
}