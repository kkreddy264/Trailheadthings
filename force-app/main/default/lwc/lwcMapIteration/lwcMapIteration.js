import { LightningElement, wire, track } from 'lwc';
import fetchMapData from '@salesforce/apex/LwcMapIterationController.fetchMapData';

export default class LwcMapIteration extends LightningElement {
    @track mapData= [];

    @wire(fetchMapData)
    wiredResult(result) { 
        if (result.data) {
            //mapData = [];
            var conts = result.data;
            for(var key in conts){
                this.mapData.push({value:conts[key], key:key}); //Here we are creating the array to show on UI.
            }
        }
    }
}