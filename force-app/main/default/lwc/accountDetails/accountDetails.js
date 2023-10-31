import { LightningElement, api, wire, track } from 'lwc';
import getAccountsData from '@salesforce/apex/AccountDetails.getAccountsData';
import getFieldsAndRecords from '@salesforce/apex/AccountDetails.getFieldsAndRecords';
import AccountNumber from '@salesforce/schema/Account.AccountNumber';

export default class accountDetails extends LightningElement {
    @api recordId;
    @track accList=[];
    listAcc=[];
    @track customFormModal = false; 
    
    @track columns;   //columns for List of fields datatable
    @track data;   //data for list of fields datatable

    @wire(getAccountsData)
    WireAccountRecords({error, data}){
        if(data){
            this.accList = data;
            this.error = undefined;
        }else{
            this.error = error;
            this.accList = undefined;
        }
    }
    
    @api SFDCobjectApiName; //kind of related list object API Name e.g. 'Case'
    @api fieldSetName; // FieldSet which is defined on that above object e.g. 'CaseRelatedListFS'
   

    @track columns;   //columns for List of fields datatable
    @track tableData;   //data for list of fields datatable
    
    recordCount; //this displays record count inside the ()
    lblobjectName; //this displays the Object Name whose records are getting displayed

    connectedCallback(){
    
       // let firstFieldAPI;

        //make an implicit call to fetch records from database
        getFieldsAndRecords({ strObjectApiName: 'Account',
                                strfieldSetName: 'Account_Fieldset',
                                })
        .then(data=>{        
            //get the entire map
            let objStr = JSON.parse(data);   
            console.log('data>>>>',objStr)
            /* retrieve listOfFields from the map,
             here order is reverse of the way it has been inserted in the map */
            let listOfFields= JSON.parse(Object.values(objStr)[1]);
            
            //retrieve listOfRecords from the map
            let listOfRecords = JSON.parse(Object.values(objStr)[0]);

            let items = []; //local array to prepare columns

            /*if user wants to display first column has hyperlink and clicking on the link it will
                naviagte to record detail page. Below code prepare the first column with type = url
            */
            
                listOfFields.map(element=>{
                    items = [...items ,{label: element.label, 
                        fieldName: element.fieldPath}];
                });   
            //finally assigns item array to columns
            this.columns = items; 
            this.tableData = listOfRecords;

            console.log('listOfRecords',listOfRecords);
            /*if user wants to display first column has hyperlink and clicking on the link it will
                naviagte to record detail page. Below code prepare the field value of first column
            */
            
                //now create final array excluding firstFieldAPI
                //this.tableData = this.tableData.filter(item => item.fieldPath  != firstFieldAPI);
            

            //assign values to display Object Name and Record Count on the screen
            this.lblobjectName = this.SFDCobjectApiName;
            this.recordCount = this.tableData.length;
            this.error = undefined;   
        })
        .catch(error =>{
            this.error = error;
            console.log('error',error);
            this.tableData = undefined;
            this.lblobjectName = this.SFDCobjectApiName;
        })        
    }
    
    handleRowAction(event){
        
        var AccId=event.target.dataset.id;
        console.log('AccId-----------',AccId);
        this.accList.forEach(ele=>{
            console.log('ele ID----- ',ele.Id);
            if(ele.Id === AccId){
                console.log('INSIDE IF------- ');
                this.listAcc.push({
                    Id:ele.Id,
                    Name:ele.Name,
                    Phone:ele.Phone,
                    AccountNumber:ele.AccountNumber
                })
            }
           
        });
        this.customFormModal=true;
     }
   
     closeModalAction(){
      this.customFormModal=false;
      this.listAcc = [];
     }
}