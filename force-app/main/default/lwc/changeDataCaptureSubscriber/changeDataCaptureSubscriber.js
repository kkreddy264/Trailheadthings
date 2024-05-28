import { LightningElement, api } from 'lwc';
import { subscribe, unsubscribe, onError } from 'lightning/empApi';
import assignTask from '@salesforce/apex/ChangeDataCaptureController.assignTask';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class ChangeDataCaptureSubscriber extends LightningElement {
    channelName = '/data/OpportunityChangeEvent';
    subscription = {};
    @api recordId;

    subscribed;
    responsePayload;
    handleChannelName(event) {
        this.channelName = event.target.value;
    }

    renderedCallback() {
        if (!this.subscribed) {
            this.handleSubscribe();
            this.subscribed = true;
        }
    }
    connectedCallback() {
        this.registerErrorListener();

    }
    handleSubscribe() {
        subscribe(this.channelName, -1, messageCallback).then(response => {
            console.log('Subscription request sent to: ', JSON.stringify(response.channel));
            this.subscription = response;
        });
        const messageCallback = (response) => {
            console.log('New message received: ', JSON.stringify(response));
            this.handleMessage(response);
        };

        
    }
    handleUnsubscribe() {
        unsubscribe(this.subscription, (response) => {
            console.log('unsubscribe() response: ', JSON.stringify(response));
        });
    }
    registerErrorListener() {
        onError((error) => {
            console.log('Received error from server: ', JSON.stringify(error));
        });
    }

    handleMessage(response) {
        if (response) {
            if (response.hasOwnProperty('data')) {
                 responsePayload = response.data.payload;
                console.log('Payload ',responsePayload);
                if (responsePayload.hasOwnProperty('StageName') && responsePayload.hasOwnProperty('ChangeEventHeader')) {
                    if (responsePayload.ChangeEventHeader.hasOwnProperty('recordIds') && responsePayload.StageName == 'Closed Won') {
                        let currentRecordId = responsePayload.ChangeEventHeader.recordIds.find(element => element == this.recordId);
                        console.log('currentRecordId', currentRecordId);
                        if (currentRecordId) {
                            assignTask({
                                recordid: this.recordId
                            }).then(result => {
                                const event = new ShowToastEvent({
                                    title: 'Task Assigned',
                                    message: 'A task has been assigned to you, please complete them.',
                                    variant: 'success'
                                });
                                this.dispatchEvent(event);
                            }).catch(error => {
                                console.log(error);
                            })
                        }
                    }

                }
            }
        }
    }
}