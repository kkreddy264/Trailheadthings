import { LightningElement, track } from 'lwc';
import isEmailExist from '@salesforce/apex/CommunityAuthController.isEmailExist';
import registerUser from '@salesforce/apex/CommunityAuthController.registerUser';

export default class RegisterComponent extends LightningElement {

    @track firstName = null;
    @track lastName = null;
    @track email = null;
    @track userName = null;
    @track password = null;
    @track confirmPassword = null;
    @track errorCheck;
    @track errorMessage;
    showUserName;
    @track showTermsAndConditions;
    @track showTermsAndConditionsLoading = false;
    @track infoTooltipDisplayData = {};
    @track requiredTooltipDisplayData = {};
    @track errorTooltipDisplayData = {};
    @track emailError;
    @track passwordError;


    connectedCallback(){

        this.showUserName = false;

        this.infoTooltipDisplayData.username = "tooltiptext usernameTooltiptext";
        this.infoTooltipDisplayData.password = "tooltiptext";

        this.requiredTooltipDisplayData.firstName = 'tooltiptext tooltipHide';
        this.requiredTooltipDisplayData.lastName = 'tooltiptext tooltipHide';
        this.requiredTooltipDisplayData.email = 'tooltiptext tooltipHide';
        this.requiredTooltipDisplayData.username = 'tooltiptext tooltipHide';        
        this.requiredTooltipDisplayData.hearAboutUs = 'tooltiptext tooltipHide';
        this.requiredTooltipDisplayData.password = 'tooltiptext tooltipHide';
        this.requiredTooltipDisplayData.confirmPassword = 'tooltiptext tooltipHide';

        this.errorTooltipDisplayData.email = 'tooltiptext tooltipHide';
        this.errorTooltipDisplayData.password = 'tooltiptext tooltipHide';
    }

    onEmailInvalid(event){

        if (!event.target.validity.valid) {
            event.target.setCustomValidity('Enter a valid email address')
        }
        
    }

    onEmailInput(event){

        event.target.setCustomValidity('')
    }

    onEmailClick(event){

        let parent = event.target.parentElement.parentElement.parentElement;
        console.log('parent-', parent);
        parent.classList.remove('tooltipEmail');
    }

    onEmailBlur(event){

        let parent = event.target.parentElement.parentElement.parentElement;
        console.log('parent-', parent);
        parent.classList.add('tooltipEmail');
    }

    handleRegister(event){

        this.errorCheck = false;
        this.errorMessage = null;

        this.errorTooltipDisplayData.email = 'tooltiptext tooltipHide';
        this.errorTooltipDisplayData.password = 'tooltiptext tooltipHide';

        if(!this.firstName){

            this.requiredTooltipDisplayData.firstName = 'tooltiptext tooltipShow';

        } else {

            this.requiredTooltipDisplayData.firstName = 'tooltiptext tooltipHide';
        }

        if(!this.lastName){

            this.requiredTooltipDisplayData.lastName = 'tooltiptext tooltipShow';

        } else {
            
            this.requiredTooltipDisplayData.lastName = 'tooltiptext tooltipHide';
        }

        if(!this.email){

            this.requiredTooltipDisplayData.email = 'tooltiptext tooltipShow';

        } else {
            
            this.requiredTooltipDisplayData.email = 'tooltiptext tooltipHide';
        }

        
        if(!this.userName){

            this.requiredTooltipDisplayData.username = 'tooltiptext tooltipShow';
            this.infoTooltipDisplayData.username = "tooltiptext usernameTooltiptext tooltipHide";

        } else {
            
            this.requiredTooltipDisplayData.username = 'tooltiptext tooltipHide';
        }

        if(!this.hearAboutUs){

            this.requiredTooltipDisplayData.hearAboutUs = 'tooltiptext tooltipShow';

        } else {
            
            this.requiredTooltipDisplayData.hearAboutUs = 'tooltiptext tooltipHide';
        }

        if(!this.password){

            this.requiredTooltipDisplayData.password = 'tooltiptext tooltipShow';
            this.infoTooltipDisplayData.password = "tooltiptext tooltipHide";

        } else {
            
            this.requiredTooltipDisplayData.password = 'tooltiptext tooltipHide';
        }

        if(!this.confirmPassword){

            this.requiredTooltipDisplayData.confirmPassword = 'tooltiptext tooltipShow';

        } else {
            
            this.requiredTooltipDisplayData.confirmPassword = 'tooltiptext tooltipHide';
        }

        
        
        if(this.firstName && this.lastName && this.email && this.userName && this.hearAboutUs && this.password && this.confirmPassword){

            this.showTermsAndConditionsLoading = true;

            if(this.password != this.confirmPassword){

                this.infoTooltipDisplayData.password = "tooltiptext tooltipHide";
                this.passwordError = 'Password did not match. Please Make sure both the passwords match.';
                this.errorTooltipDisplayData.password = 'tooltiptext tooltipShow tooltipError';

                event.preventDefault();

                this.showTermsAndConditionsLoading = false;
                
                return;
            }

            let emailCheck = /^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(this.email);

            console.log('emailCheck--',emailCheck);

            if( emailCheck == null || emailCheck == undefined || emailCheck == false ){

                this.showTermsAndConditionsLoading = false;
                console.log('inside email check');
                
                this.emailError = 'Please enter a valid email address';
                this.errorTooltipDisplayData.email = 'tooltiptext tooltipShow tooltipError';
                
                return;
            }

            let passwordCheck = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/.test(this.password);

            if(passwordCheck == null || passwordCheck == undefined || passwordCheck == false){

                this.showTermsAndConditionsLoading = false;

                this.infoTooltipDisplayData.password = "tooltiptext tooltipHide";
                this.passwordError = 'Password must be Minimum eight characters, at least one letter, one number and one special character.';
                this.errorTooltipDisplayData.password = 'tooltiptext tooltipShow tooltipError';
                
                return;
            }
            
            event.preventDefault();

            isEmailExist({ username: this.userName })
            .then((result) => {

                console.log('login result---'+result, typeof result);
                
                if(result != null && result != undefined && result == true){

                    this.emailError = 'Your username already exists somewhere on the  Salesforce Ecosystem.';
                    this.errorTooltipDisplayData.email = 'tooltiptext tooltipShow tooltipError';

                    this.showTermsAndConditionsLoading = false;

                } else {

                    registerUser({ firstName: this.firstName, lastName: this.lastName, username: this.userName, email: this.email, communityNickname: this.firstName, password: this.password,
                    companyName: this.companyName, hearAboutUs: this.hearAboutUs })
                        .then((result) => {
                                        
                            if(result){            
                                          
                                window.location.href = result;
            
                            } 
							
                            this.showTermsAndConditionsLoading = false;
                        })
                        .catch((error) => {
                            this.error = error;
            
                            console.log('error-',error);
            
                            this.showTermsAndConditionsLoading = false;
            
                            if(error && error.body && error.body.message){
            
                                this.showTermsAndConditions = false;
                                this.errorCheck = true;
                                this.errorMessage = error.body.message;
                               
                            }           
                            
                        });
                }

                
            })
            .catch((error) => {
                this.error = error;
             
                if(error && error.body && error.body.message){
                    
                    console.log('error msg-', error.body.message);
                }

                this.showTermsAndConditionsLoading = false;
				
            });
        
        }

        
    }

    handleTermsAndConditions(event){

        this.showTermsAndConditions = true;
    }

    handleFirstNameChange(event){

        this.firstName = event.target.value;
    }

    handleLastNameChange(event){

        this.lastName = event.target.value;
    }

    handleEmailChange(event){

        if(event.target.value){

            this.email = event.target.value;
            this.userName = this.email + '.cydehustle';
        
        } else {

            this.email = event.target.value;
            this.userName = this.email;
        }
    }  

    handlePasswordChange(event){

        this.password = event.target.value;
    }

    handleConfirmPasswordChange(event){

        this.confirmPassword = event.target.value;
    }

    closeTermsAndConditions(event){

        this.showTermsAndConditions = false;
    }


    handleEmailHover(event){
    }

}