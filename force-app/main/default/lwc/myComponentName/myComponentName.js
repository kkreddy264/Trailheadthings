import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
 
export default class myComponentName extends LightningElement {
 
    currentPageReference = null; 
    urlStateParameters = null;
    /* Params from Url */
    pageUrlId = null;
    urlLanguage = null;
    urlType = null;
 
    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
       if (currentPageReference) {
          this.urlStateParameters = currentPageReference.state;
          console.log('state',this.urlStateParameters);
          this.setParametersBasedOnUrl();
       }
    //    playerOptions.playerVars.domain = window.location.domain
    //    this.youtubePlayer = new YT.Player(element,playerOptions);
    //    this.youtubePlayer.sendMessage = function (a) {
    //       a.id = this.id, a.channel = "widget", a = JSON.stringify(a);
    //       var url = new URL(this.h.src), origin = url.searchParams.get("domain");
    //       console.log('url',url);
    //       if (origin && this.h.contentWindow) {
    //           this.h.contentWindow.postMessage(a, domain)
    //       }
    //    }
    }
    getQueryParameters() {

        var params = {};
        var search = location.search.substring(1);

        if (search) {
            params = JSON.parse('{"' + search.replace(/&/g, '","').replace(/=/g, '":"') + '"}', (key, value) => {
                return key === "" ? value : decodeURIComponent(value)
            });
        }

        return params;
    }
    setParametersBasedOnUrl() {
        console.log('this.parameters');
  
        this.parameters = this.getQueryParameters();
        console.log('adsfgh',this.parameters);
       this.pageUrlId = this.urlStateParameters.id || null;
       console.log('id',this.pageUrlId);
       this.urlLanguage = this.urlStateParameters.lang || null;
       console.log('lag',this.urlLanguage)
       this.urlType = this.urlStateParameters.type || null;
       console.log('lag',this.urlType)
    }
}