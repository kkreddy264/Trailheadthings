import { LightningElement , wire, track} from 'lwc';
import sortContactList from '@salesforce/apex/lwcSortingDataTableCtrl.sortContactList';
const columns = [
    {
        label: 'Name',
        fieldName: 'Name',
        sortable: "true"
    }, {
        label: 'Email',
        fieldName: 'Email',
        type: 'email',
        sortable: "true"
    }, {
        label: 'Phone',
        fieldName: 'Phone',
        type: 'phone',
        sortable: "true"
    }, {
        label: 'Title',
        fieldName: 'Title',
        type: 'Picklist',
        sortable: "true"
    }, 
    {
        label: 'Account_Name',
        fieldName: 'AccountName',
        type: 'text',
        sortable: "true"
    },
    {
        label: 'Owner_Name',
        fieldName: 'OwnerName',
        type: 'text',
        sortable: "true"
    },
    {
        label: 'View', fieldName: 'URL', type: 'url',
        typeAttributes: {
            tooltip: { fieldName: 'Name' },
            label: {
                fieldName: 'Name'
            },
            target: '_blank'
        }
    },
    { label: 'View', type:  'button', typeAttributes: { 
            label: 'View',  name: 'View',  variant: 'brand-outline',
            iconName: 'utility:preview', iconPosition: 'right'
        } 
    },
];
export default class lwcSortingDataTable extends LightningElement {
    @track data;
    @track columns = columns;
    @track sortBy;
    @track sortDirection;
    @wire(sortContactList)
    contacts(result) {
        if (result.data) {
            this.data = result.data;
            this.error = undefined;
 
        } else if (result.error) {
            this.error = result.error;
            this.data = undefined;
        }
    }
 
 
    handleSortContactData(event) {       
        this.sortBy = event.detail.fieldName;       
        this.sortDirection = event.detail.sortDirection;       
        this.sortContactData(event.detail.fieldName, event.detail.sortDirection);
    }
    handleKeyWordChange(event){
        this.pageNumber=1;
        this.keyword=event.traget.value;
        console.log("search keyword: "+this.keyword);
        this.handlePageChange();
    }
     
 
    sortContactData(fieldname, direction) {
        
        let parseData = JSON.parse(JSON.stringify(this.data));
       
        let keyValue = (a) => {
            return a[fieldname];
        };
 
       let isReverse = direction === 'asc' ? 1: -1;
 
           parseData.sort((x, y) => {
            x = keyValue(x) ? keyValue(x) : ''; 
            y = keyValue(y) ? keyValue(y) : '';
           
            return isReverse * ((x > y) - (y > x));
        });
        
        this.data = parseData;
 
    }
 
}