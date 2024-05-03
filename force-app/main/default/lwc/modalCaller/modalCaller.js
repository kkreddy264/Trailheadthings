import { LightningElement } from 'lwc';
import dynamicModal from 'c/dynamicModal';
export default class ModalCaller extends LightningElement {
    async handleShowModal() {
        this.result = await dynamicModal.open({
            size: 'small',
            description: 'understand how you can pass lwc dynamically to modal',
            header: 'Modal which accept lwc as body',
            flowName: 'CallLwcInFlow',
            inputVariables: this.inputVariables
        });
    }

    get inputVariables() {
        return [];
    }
}