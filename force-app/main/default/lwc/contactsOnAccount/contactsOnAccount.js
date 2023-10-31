import { LightningElement, api, track, wire } from "lwc";
import getContacts from "@salesforce/apex/keyAccountContactsController.getContacts";

const columns = [
  { label: "Name", fieldName: "Name" },
  { label: "Title", fieldName: "Title" },
  { label: "Phone", fieldName: "Phone", type: "phone" },
  { label: "Email", fieldName: "Email", type: "email" }
];

export default class ContactsOnAccount extends LightningElement {
  @api recordId;
  @track data = [];
  @track columns = columns;
  @track tableLoadingState = "true";

  @wire(getContacts, { accountId: "$recordId" })
  wiredRecordsMethod({ error, data }) {
    if (data) {
       this.result = JSON.parse(JSON.stringify(data));
        this.data = this.data;
      this.error = undefined;
    } else if (error) {
      this.error = error;
      this.data = undefined;
    }
    this.tableLoadingState = false;
  }
}