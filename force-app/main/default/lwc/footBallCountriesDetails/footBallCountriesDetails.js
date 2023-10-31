import { LightningElement,wire,api,track } from 'lwc';
import footBallApiDetails from '@salesforce/apex/FootBallDetailsAPI.footBallApiDetails';

export default class footBallCountriesDetails extends LightningElement {

    countriesDetails;
    error;
    handleClick(){

        footBallApiDetails({}).then(response=>{
            console.log('response',response);
            this.countriesDetails = response.body;
            console.log('response1',this.countriesDetails);
        }).catch(error=>{
            this.error = error.body;
        })
    }  
}