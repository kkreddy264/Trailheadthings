import { LightningElement, api, wire, track } from 'lwc';
import getContactsRelatedToAccount from '@salesforce/apex/AccountController.getContactsRelatedToAccount';
import getContacts from '@salesforce/apex/AccountController.getContacts';
import updateContacts from '@salesforce/apex/AccountController.updateContacts';
//import { NavigationMixin } from 'lightning/navigation';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';
export default class AccountRecordEditForm extends LightningElement {
    @api recordId;
    @track contacts;
    @track contactList=[];
    @track renderTable = false;
    @track isChanged=false;
    @track isEdit=false;

    handleSubmit(event) {
        console.log('onsubmit event recordEditForm'+ event.detail.fields);
    }
    handleSuccess(event) {
        console.log('onsuccess event recordEditForm', event.detail.id);
    }
    
    //contact datatable related to the Account
    @track columns = [
        { label: 'First Name', fieldName: 'FirstName', type: 'text' },
        { label: 'Last Name', fieldName: 'LastName', type: 'text' },
        { label: 'Phone', fieldName: 'Phone', type: 'phone' },
        { label: 'Email', fieldName: 'Email', type: 'email'}
    ];
    


    @wire(getContactsRelatedToAccount, {accId: '$recordId'}) 
    WireContactRecords({error, data}){
        if(data){
            this.contacts = data;
            this.error = undefined;
        }else{
            this.error = error;
            this.contacts = undefined;
        }
    }
    
    connectedCallback() {
        getContacts({ sourceAccount: this.recordId})
            .then(result => {
                result.forEach(ele => {
                    console.log('name',ele.FirstName)
                    this.contactList.push({
                        Id: ele.Id,
                        LastName:ele.LastName ,
                        FirstName: ele.FirstName,
                        Email: ele.Email,
                        Phone: ele.Phone,
                        isEdit : false,
                        isChanged : false
                    })
                   
                })
                if (this.contactList.length === 0) {
                    this.renderTable = false;
                }
                else {
                    this.renderTable = true;
                }
            })
        
    }
    // handleOnChange(event){
    //     console.log('event',event.target.dataset.name)
    //     console.log('Id',event.target.dataset.id)
    //     var element = this.contactList.find(ele => ele.Id === event.target.dataset.id);
    //     if(event.target.name=='FirstName'){
    //         element.FirstName = event.target.value;
    //         console.log('name',element.FirstName )
    //     }
    //     else if(event.target.name=='LastName'){
    //         element.LastName = event.target.value;
    //         console.log('name',element.LastName )
    //     }
    //    else if(event.target.name=='Email'){
    //         element.Email = event.target.value;
    //         console.log('name',element.Email )
    //     }
    //     else{
    //         element.Phone = event.target.value;
    //         console.log('name',element.Phone)
    //     }
        
    //     this.contactList=[...this.contactList];
    //     console.log(JSON.stringify(this.contactList));
    //     this.isChanged=true;
    //   }
    //   handleOnEdit(event){
    //     console.log('edit',event.target.dataset.id)
    //     console.log('contact',JSON.stringify(event.target.dataset.id))
    //     var contact = this.contactList.find(ele => ele.Id === event.target.dataset.id);
    //     console.log('contact',JSON.stringify(contact))
    //     this.isEdit = true;
    //     this.contactList=[...contact];
    //     console.log(JSON.stringify(this.contactList));
    //   }

    //handle on update records
    handleOnEditable(event){
        var selectedId = event.detail;
        console.log('Id',selectedId);
        var contact = this.contactList.find(ele => ele.Id === selectedId);
        console.log('contact',JSON.stringify(contact))
        contact.isEdit = true;
        console.log('Id',selectedId);
        this.contactList=JSON.stringify(contact);
        console.log('Id',selectedId);
        console.log(JSON.stringify(this.contactList));
        
        this.isEdit=true
    }

    handleOnChangeValue(event){
        console.log('jag',JSON.stringify(event.detail))
        var selectedList = event.detail;
        console.log('list',JSON.stringify(selectedList));
        
        var element = this.contactList.find(ele => ele.Id === selectedList.Id);
        console.log('elements',JSON.stringify(element));
        console.log('elements',JSON.stringify(element.FirstName));
        if(selectedList.name=="FirstName"){
            element.FirstName = selectedList.value;
            console.log('name',element.FirstName )
        }
        else if(selectedList.name=='LastName'){
                    element.LastName = selectedList.value;
                    console.log('name',element.LastName )
                }
        else if(selectedList.name=='Email'){
                    element.Email = selectedList.value;
                    console.log('name',element.Email )
                }
                else{
                    element.Phone = selectedList.value;
                    console.log('name',element.Phone)
                }
        element.isChanged=true
        console.log('list',JSON.stringify(this.contactList))
    }
    handleOnUpdate(){

        updateContacts({conList:this.contactList})  
        this.isEdit=true         
}
    //To delete the selected contact
    deleteContact(event) {
        this.isLoading = true;
        deleteRecord(event.currentTarget.dataset.id)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record Is Deleted',
                        variant: 'success',
                    }),
                );
                this.connectedCallback();
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: error.message,
                        variant: 'error',
                    }),
                );
                this.connectedCallback();
            });
    }
}