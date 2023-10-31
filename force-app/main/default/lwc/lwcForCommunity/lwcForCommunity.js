import {LightningElement, api, track, wire} from 'lwc';
 
// We can get the community Id for use in the callout
import communityId from '@salesforce/community/Id';
 
// Get the base path for navigating to non-named pages
import communityBasePath from '@salesforce/community/basePath';

export default class lwcForCommunity extends LightningElement {

    currentcommunityId;
    currentcommunityBasePath;

    connectedCallback() {
        this.currentcommunityId = communityId;
        this.currentcommunityBasePath = communityBasePath;
    }

}