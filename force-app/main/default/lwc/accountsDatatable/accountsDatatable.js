import { LightningElement, api, wire,track } from 'lwc';
import getAccountData from '@salesforce/apex/AccountController.getAccountData';
import { updateRecord } from 'lightning/uiRecordApi';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {refreshApex} from '@salesforce/apex';
import {CurrentPageReference} from 'lightning/navigation';
import {fireEvent} from 'c/pubsub';

export default class accountsDatatable extends LightningElement {
    @api recordId;
    @track accountsData = [];
    updatedFields = [];
    error;
    @wire(CurrentPageReference) pageRef;
    @track columns = [{
        label: 'Name',
        fieldName: 'Name',
        type: 'text',
        editable:true,
    },
    {
        label: 'Employees',
        fieldName: 'NumberofEmployees',
        type: 'Number',
        editable:true,
    },
    {
        label: 'Annual Revenue',
        fieldName: 'AnnualRevenue',
        type: 'Currency',
        editable:true,
    },
    {
        label: 'Phone',
        fieldName: 'Phone',
        type: 'Number',
        editable:true,
    }];

    @wire(getAccountData)
    wiredAccounts({data, error}){
        if(data){

            console.log('data-->',data);
            this.accountsData = data;
            console.log('this.accountsData',JSON.stringify(this.accountsData));
            this.error=undefined;
        }
        if(error){
            this.error='error',
            this.accountsData=undefined;
        }
    }
    updateSelectedRecords(event){

        this.updatedFields = event.detail.draftValues;
        console.log('fields',JSON.stringify(this.updatedFields));
       const inputFields = this.updatedFields.slice().map(draft=>{

            const fields = Object.assign({},draft);
            return {fields};
       });
       console.log('value',JSON.stringify(inputFields));
        
       const promises = inputFields.map(recordInput => updateRecord(recordInput));
       
       Promise.all(promises).then(res=>{
        console.log('result',res);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'success',
                    message:'Record Updated Successfully',
                    Variant:'success'
                })
            );
            fireEvent(this.pageRef,'accUpdateEvent',res);
            this.updatedFields =[];
            return this.refresh();
       })
       .catch(error=>{
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'error',
                    message:'Getting Error On Update',
                    Variant:'error'
                })
            );
       })
       .finally(()=>{
            this.updatedFields=[];
       })
       
    }
    async refresh(){
        await refreshApex(this.accountsData);
        
    }
}