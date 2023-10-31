import { LightningElement } from 'lwc';
 
export default class LwcFormValidation extends LightningElement {
 
    handleChangeValidation(event){
      let getFirstName = event.target.name;
      let getLstName = event.target.name;
      let getUserEmail = event.target.name;
      let getUserPhone = event.target.name;
      let getStatusActive = event.target.name;
      let getCityName = event.target.name;
 
 
      if(getFirstName === "firstName"){
          let firstName = this.template.querySelector('.firstName');
          let firstNameVal = firstName.value;
          if(!firstNameVal){
            firstName.setCustomValidity('Please Enter the First Name');
          }else{
            firstName.setCustomValidity('');
          }
          firstName.reportValidity();
      }
 
 
      else if(getLstName === "lastName"){
        let lastName = this.template.querySelector('.lastName');
        let lastNameVal = lastName.value;
        if(!lastNameVal){
            lastName.setCustomValidity('Please Enter the Larst Name');
        }else{
            lastName.setCustomValidity('');
        }
        lastName.reportValidity();
       }
 
      
       else if(getUserEmail === "userEmail"){
        let userEmail = this.template.querySelector('.userEmail');
        let userEmailVal = userEmail.value;
        if(!userEmailVal){
            userEmail.setCustomValidity('Please Enter the Email Id');
        }else{
            userEmail.setCustomValidity('');
        }
        userEmail.reportValidity();
       }
 
 
       else if(getUserPhone === "userPhone"){
        let userPhone = this.template.querySelector('.userPhone');
        let userPhoneVal = userPhone.value;
        if(!userPhoneVal){
            userPhone.setCustomValidity('Please Enter the Email Id');
        }else{
            userPhone.setCustomValidity('');
        }
        userPhone.reportValidity();
       }
        
       else if(getCityName === "userCity"){

        let userCity = this.template.querySelector('.userCity');
        let userCityVal = userCity.value;
        if(!userCityVal){
            userCity.setCustomValidity('Please Enter the cityname');
        }
        else{
            userCity.setCustomValidity('');
        }

        userCity.reportValidity();
       }
 
 
       else if(getStatusActive === "statusCheckbox"){
        let statusCheckbox = this.template.querySelector('.statusActive');
        let statusCheckboxVal = statusCheckbox.checked;
        if(!statusCheckboxVal){
            statusCheckbox.setCustomValidity('Please Check Mark the Status Checkbox');
        }else{
            statusCheckbox.setCustomValidity('');
        }
        statusCheckbox.reportValidity();
       }        
 
    }
 
}