import { LightningElement,wire,track,api } from 'lwc';
import getBoatTypes from '@salesforce/apex/BoatDataService.getBoatTypes';
export default class BoatSearchForm extends LightningElement {

  selectedBoatTypeId = '';
  error = undefined;
  @track searchOptions;
  
   @wire(getBoatTypes)
   wiredboatTypes({ data,error }) {
    if (data) {
      
      this.searchOptions = data.map(type => {
        
        return{label:type.Name,value:type.Id};

      });
      this.searchOptions = JSON.parse(JSON.stringify(this.searchOptions));
      this.searchOptions.unshift({ label: 'All Types', value:''});
    } else if (error) {
      this.searchOptions = undefined;
      this.error = error;

    }
  }
  
  // Fires event that the search option has changed.
  // passes boatTypeId (value of this.selectedBoatTypeId) in the detail
  handleSearchOptionChange(event) {
    this.selectedBoatTypeId =  event.detail.value;
    const searchEvent = new CustomEvent('search',{
      detail:{
        boatTypeId :this.selectedBoatTypeId
      }
    });
    this.dispatchEvent(searchEvent);
  }
}