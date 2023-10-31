import { LightningElement, wire, api, track } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class UpdateData extends LightningElement {
    @track Account = {};

    handleLoad(event) {
        if (!this.loadedForm) {
            let fields = Object.values(event.detail.records)[0].fields;
            const recordId = Object.keys(event.detail.records)[0];
            this.Account = {
                Id: recordId,
                ...Object.keys(fields)
                    .filter((field) => !!this.template.querySelector(`[data-field=${field}]`))
                    .reduce((total, field) => {
                        total[field] = fields[field].value;
                        return total;
                    }, {})
            };
            this.loadedForm = true;
        }
    }
    handleFieldChange(e) {
        this.Account[e.currentTarget.dataset.field] = e.target.value;
    }
    saveForm() {
        // if(this.validated())
        console.log('Account for save => ', JSON.stringify(this.Account));
        updateRecord({ fields: this.Account })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Account updated',
                        variant: 'success'
                    })
                );
            })
            .catch((error) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }
}