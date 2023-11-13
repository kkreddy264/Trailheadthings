import { LightningElement,wire,track,api } from 'lwc';
import getBoats from '@salesforce/apex/BoatDataService.getBoats';
import { publish, MessageContext } from 'lightning/messageService';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import updateBoatList from '@salesforce/apex/BoatDataService.updateBoatList';
import BOATMC from '@salesforce/messageChannel/BoatMessageChannel__c';

export default class BoatSearchResults extends LightningElement {

    @api selectedBoatId;
    @track boats;
    @track draftValues;
    boatTypeId='';
    error;
    isLoading = false;
    columns = [
        { label: 'Name', fieldName: 'Name', editable: true },
        { label: 'Length', fieldName: 'Length__c', type: 'number'},
        { label: 'Price', fieldName: 'Price__c', type: 'currency'},
        { label: 'Description', fieldName: 'Description__c'},        
    ];
    
    @wire(MessageContext)
    messageContext;
    
    @wire(getBoats,{boatTypeId:'$boatTypeId'})
    wiredBoats({error,data}){
        if(data){
            console.log('data',data);
            this.boats = data;
        }
        else{
            this.error = error;
        }
    }
    @api
    searchBoats(boatTypeId){
        this.boatTypeId = boatTypeId;
        this.isLoading = true;
        this.notifyLoading = (this.isLoading);
    }
    @api
    async refresh() {
        this.isLoading = true;
        this.notifyLoading(this.isLoading);      
        await refreshApex(this.boats);
        this.isLoading = false;
        this.notifyLoading(this.isLoading);
    }
    updateSelectedTile(event){
       this.selectedBoatId = event.detail.boatId;
       this.sendMessageService(this.selectedBoatId)
    }
    sendMessageService(boatId) { 
        // explicitly pass boatId to the parameter recordId
        publish(this.messageContext, BOATMC, { recordId: boatId });
    }

    handleSave(event){
        const updatedFields = event.detail.draftValues;
        updateBoatList({data:updatedFields})
        .then(result => {
            const toast = new ShowToastEvent({
                title: SUCCESS_TITLE,
                message: MESSAGE_SHIP_IT,
                variant: SUCCESS_VARIANT,
            });
            this.dispatchEvent(toast);
            this.draftValues = [];
            return this.refresh();
        })
        .catch(error => {
            const toast = new ShowToastEvent({
                title: ERROR_TITLE,
                message: error.message,
                variant: ERROR_VARIANT,
            });
            this.dispatchEvent(toast);
        })
        .finally(() => {
            
        });
    }
    notifyLoading(isLoading) {
        if (isLoading) {
            this.dispatchEvent(new CustomEvent('loading'));
        } else {
            this.dispatchEvent(CustomEvent('doneloading'));
        }        
    }
}