import { LightningElement, track, api } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
        const columns =[
            {label:'Name', fieldName: 'name'},
            {label:'Type', fieldName:'mimeType'}
        ];
export default class FileUploder extends LightningElement {

    @api recordId;
    @track columns=columns;
    @track uploadedFiles=[];
        get acceptedFormats(){

            return ['.pdf', '.jpg', '.pnj', '.jpeg'];
        }
        handleUploadFinished(event){

            this.uploadedFiles = event.detail.files;
            console.log('files',this.uploadedFiles);
            let uploadedFileNames = ''; 
            for(let i = 0; i < uploadedFiles.length; i++) { 
                uploadedFileNames += uploadedFiles[i].name + ', '; 
            } 
            this.dispatchEvent( 
                new ShowToastEvent({ 
                    title: 'Success', 
                    message: uploadedFiles.length + ' Files uploaded Successfully: ' + uploadedFileNames, 
                    variant: 'success', 
                }), 
            ); 
        }
}