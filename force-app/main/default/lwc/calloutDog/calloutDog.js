import { LightningElement } from 'lwc';
import fetchDog from '@salesforce/apex/DogAPIController.fetchRandomDog';
export default class CalloutDog extends LightningElement {
    boolShowImage = false;
    boolShowSpinner = false;
    strUrl;
    handleClick(){
        this.boolShowSpinner = true;
        this.boolShowImage = false;
        fetchDog({}).then(response => {
            this.strUrl = JSON.parse(response).message;
            this.boolShowImage = true;
            this.boolShowSpinner = false;
        }).catch(error => {
            console.log('Error: ' +error.body.message);
        });
    }
}