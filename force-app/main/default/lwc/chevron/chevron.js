/**
 * @File Name          : chevron.js
 * @Description        : 
 * @Author             : Swarup Satpti
 * @Group              : 
 * @Last Modified By   : Swarup satpati
 * @Last Modified On   : 8/3/2020, 5:30:00 PM
**/
import { LightningElement, api, wire, track } from 'lwc';
import { getObjectInfo, getPicklistValues} from 'lightning/uiObjectInfoApi';
import { getFieldValue } from 'lightning/uiRecordApi';
import {getRecord} from 'lightning/uiRecordApi';

export default class Chevron extends LightningElement {
    @api objectName = 'Demo__c';
    @api fieldName = 'Status__c';
    /*component with a recordId property is used on a Lightning record page, 
    the page sets the property to the ID of the current record.*/
    @api recordId; 

    @track picklistvalues;
    @track record;
    @track error;
    @track chevrondata=[];
    @track itemList;
    @track fieldValue;
    @track fieldArray;

    recordtypeId;
    index=0;
    isFound=false;
    isfoundindex=0;
    fieldapi;


  connectedCallback(){
    this.fieldArray = [`${this.objectName}.${this.fieldName}`,`${this.objectName}.RecordTypeId`];
    this.fieldapi=`${this.objectName}.${this.fieldName}` ;
    }
    
    /*Use this wire adapter to get a record’s data : 
       Recordtype ID and value of status field pass through API
    */
    @wire(getRecord, { recordId: '$recordId', fields:'$fieldArray'})
    wiredAccount({ error, data }) {
        if (data) {
            this.record = data;
            console.log(JSON.stringify(data));
            this.fieldvalue=getFieldValue(data,`${this.objectName}.${this.fieldName}`);
            this.recordtypeId=this.record.fields.RecordTypeId.value;
            this.error = undefined;
            console.log('selected value..'+this.fieldvalue);
        } else if (error) {
            console.log('error..');

            this.error = error;
            this.record = undefined;
        }
    }

   /*Use this wire adapter to get the picklist values for a specified field.*/

    @wire(getPicklistValues, {
        fieldApiName: '$fieldapi',
        recordTypeId: '$recordtypeId'
    })
    fetchRecordTypeInfo({ data, error }) {
        if (data) {
            console.log('data..'+JSON.stringify(data.values));

           // this.picklistvalues = data.picklistFieldValues.Status_EI__c.values;
              this.picklistvalues = data.values ;

            this.picklistvalues.forEach(item=>{
               // console.log('rec..'+item.value);
                let classType;
                if(this.fieldvalue==item.value){
                    classType = 'slds-path__item slds-is-current slds-is-active';
                    this.isFound=true;
                    this.isfoundindex=this.index;
                }
                else{ 
                   classType='slds-path__item slds-is-incomplete';
                   this.index ++; 
                }
                this.chevrondata.push({
                 stages :item,
                 classType:classType
                });


            });
            if(this.isFound){
                for(let i=0;i<this.isfoundindex;i++){
                   this.chevrondata[i].classType='slds-path__item slds-is-complete';
                }

            }
           
             console.log('chevron data..'+JSON.stringify(this.chevrondata));
           
            //console.log(JSON.stringify(this.picklistvalues));
        }
        else if (error) {
            console.log(" Error  ---> " + JSON.stringify(error));
        }
    }
}