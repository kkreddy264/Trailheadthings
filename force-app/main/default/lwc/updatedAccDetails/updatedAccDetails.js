import { LightningElement, wire, track, api } from 'lwc';
import{CurrentPageReference} from 'lightning/navigation';
import{registerListener, unregisterAllListeners} from 'c/pubsub';
import{refreshApex} from '@salesforce/apex';

export default class updatedAccDetails extends LightningElement {
    @wire(CurrentPageReference) pageRef;
    @track accData;
    @api recordId;
    @track @track columns = [{
        label: 'Name',
        fieldName: 'Name',
        type: 'text',
    },
    {
        label: 'Employees',
        fieldName: 'NumberofEmployees',
        type: 'Number',
    },
    {
        label: 'Annual Revenue',
        fieldName: 'AnnualRevenue',
        type: 'Currency',
    },
    {
        label: 'Phone',
        fieldName: 'Phone',
        type: 'Number',
    }];
    connectedCallback(){

        registerListener('accUpdateEvent',this.handleUpdateEvent, this);
    }
    handleUpdateEvent(res){
        console.log('event',res);
        res.then(res=>{
            console.log('event1',res);
        });
        this.accData = res;
       return this.refresh();
    }
    disconnectedCallback(){
        unregisterAllListeners(this);
    }
    async refresh(){
        await refreshApex(this.accData);
    }
}