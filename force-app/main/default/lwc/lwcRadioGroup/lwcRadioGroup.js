import { LightningElement, track } from 'lwc';
 
export default class LwcRadioGroup extends LightningElement {
    value = 'Blog';
 
    get options() {
        return [
            { label: 'Blog', value: 'Blog' },
            { label: 'Tutorial', value: 'Tutorial' },
            { label: 'Tech Guide', value: 'Tech Guide' },
            { label: 'Aura Component', value: 'Aura Component' },
            { label: 'Salesforce LWC', value: 'Salesforce LWC' },
        ];
    }
 
    @track blogFieldValue = true;
    @track tutorialFieldValue = false;
    @track techGuideFieldValue = false;
    @track auraCompFieldValue = false;
    @track salesforceLwcFieldValue = false;
 
    handleRadioChange(event) {
        const selectedOption = event.detail.value;
        //alert('selectedOption ' + selectedOption);
        if (selectedOption == 'Blog'){
            this.blogFieldValue = true;
        }else{
            this.blogFieldValue = false;
        }
      
        
        if (selectedOption == 'Tutorial'){
            this.tutorialFieldValue = true;
        }else{
            this.tutorialFieldValue = false;
        }
        
 
        if (selectedOption == 'Tech Guide'){
            this.techGuideFieldValue = true;
        }else{
            this.techGuideFieldValue = false;
        }
        
 
      if (selectedOption == 'Aura Component'){
            this.auraCompFieldValue = true;
        }
        else{
            this.auraCompFieldValue = false;
        }
      
        if (selectedOption == 'Salesforce LWC'){
            this.salesforceLwcFieldValue = true;
        }
        else{
            this.salesforceLwcFieldValue = false;
        }
        
        
    }
    
 
}