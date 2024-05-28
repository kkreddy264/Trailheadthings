import { LightningElement } from 'lwc';

export default class FlowFromLwc extends LightningElement {
    get inputVariables() {
        return [];
    }

    message;

    handleStatusChange(event) {
        console.log('Message from Flow', event.detail);
        if (event.detail.status === 'FINISHED' && event.detail.outputVariables) {
            this.message = event.detail;
        }
    }

    get messageFromFlow() {
        return this.message
            ? JSON.stringify(this.message, null, 2)
            : '';
    }
}