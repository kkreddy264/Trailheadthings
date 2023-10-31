import { LightningElement, api, wire, track } from 'lwc';
import getOppData from '@salesforce/apex/OpportunityController.getOppData';
import { NavigationMixin } from 'lightning/navigation';
import {updateRecord} from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import insertAccount from '@salesforce/apex/OpportunityController.insertAccount';
import { CloseActionScreenEvent } from 'lightning/actions';


export default class UpdateOnOpportunity extends LightningElement {

   @api recordId;
   @track data;
   @track Opportunity;
   @wire(getOppData, {oppId: '$recordId' })
   getOpportunity({error, data}){
        if (error) {
            let message = 'Unknown error';
            if (Array.isArray(error.body)) {
                message = error.body.map(e => e.message).join(', ');
            } else if (typeof error.body.message === 'string') {
                message = error.body.message;
            }
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error loading contact',
                    message,
                    variant: 'error',
                }),
            );
        } else if (data) {
            this.Opportunity = data;
            //this.name = this.contact.fields.Name.value;
            //this.phone = this.contact.fields.Phone.value;
        }
   }

    handleOnChange(event){
    console.log('edit',event.target.dataset.id);
    var amount = event.target.value;
    console.log('data',amount);
    if(event.target.name === 'amount')
    {
        this.Amount =  event.target.value;
        console.log('amount',this.Amount);
    }
    else if(event.target.name === 'nextStep'){
        this.NextStep =  event.target.value;
        console.log('nextStep',this.NextStep);
    }
    else if(event.target.name === 'stageName'){
        this.StageName =  event.target.value;
        console.log('stageName',this.StageName);
    }
    else {
        this.CloseDate =  event.target.value;
        console.log('CloseDate',this.CloseDate);
    }   
}
handleOnSave(){
        let record = {
            fields: {
                Id: this.recordId,
                Amount: this.Amount,
                NextStep:this.NextStep ,
                StageName:this.StageName ,
                CloseDate:this.CloseDate,
            },
        };
        updateRecord(record)
            // eslint-disable-next-line no-unused-vars
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record Is Updated',
                        variant: 'success',
                    }),
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error on data save',
                        message: error.message.body,
                        variant: 'error',
                    }),
                );
            }); 
            
     let myAccount = {};
    console.log('account1',myAccount);
    console.log('value',this.Amount);
    // set any additional fields
    if(this.Amount >= 50000){
        console.log('value1',this.Amount);
        myAccount.sobjectType = 'Account';
        console.log('value2',myAccount.sobjectType);
        myAccount.Name = 'Example';
        console.log('value3',myAccount.Name);
        myAccount.AccountNumber = '7645738293';
        console.log('value3',myAccount.AccountNumber);
        myAccount.Industry = 'OilIndustry';
        console.log('account'+JSON.stringify(myAccount));
        insertAccount({toInsert: myAccount})
            .then(result => {
                console.log(result);
            })
            .catch(error => {
                console.log(error);
            });
            console.log('insert',toInsert)
    }
}

   handleSuccess(e) {

// Close the modal window and display a success toast

        this.dispatchEvent(new CloseActionScreenEvent());

        this.dispatchEvent(

            new ShowToastEvent({

                title: 'Success',

                message: 'Opportunity Record Updated!',

                variant: 'success'

            })

        );

   }
//    insertAccount(){
//        // declare an object with a property `sobjectType` to help the middleware parse 
//     // this object into an `Account` on the server
//     let myAccount = {};
//     console.log('account1',myAccount);
//     console.log('value',this.Amount);
//     // set any additional fields
//     if(this.Amount >= 50000){
//         console.log('value1',this.Amount);
//         myAccount.sobjectType = 'Account';
//         console.log('value2',myAccount.sobjectType);
//         myAccount.Name = 'Example';
//         console.log('value3',myAccount.Name);
//         myAccount.AccountNumber = 7645738293;
//         console.log('value3',myAccount.AccountNumber);
//         myAccount.Industry = 'OilIndustry';
//         console.log('account'+JSON.stringify(myAccount));
//         insertAccount({toInsert: myAccount})
//             .then(result => {
//                 console.log(result);
//             })
//             .catch(error => {
//                 console.log(error);
//             });
//     }
    
//    }   
// createRecord() {
//     // Navigate to the Account home page
//     if(this.Amount > 50000){
//         this[NavigationMixin.Navigate]({
//             type: 'standard__objectPage',
//             attributes: {
//                 objectApiName: 'Account',
//                 actionName: 'new'                
//             },
//             state : {
//                 nooverride: '1',
//                 defaultFieldValues:"Name=Tushar Sharma,AccountNumber=55555,NumberOfEmployees=35000,Phone=9988776655"
//             }
//         });
//     }
    
// }   
showToast(type,msg,variant){

}
}