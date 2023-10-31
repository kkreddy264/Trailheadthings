public class callWebserviceClass {
    private string cKey ='3MVG9fe4g9fhX0E6q9YxgAOhJ8G9ThSkXIhIBuUCPcWcKWRh1RkYmVjaxZ2wKqAZWhpUP.KXAj_0kT_FpZfpy';
    private string cSecret = 'D5DDEBAA7C5AD9F7BC08D8DBD4A3DF349006EA06C6C4AE333228B077F03FE605';
    private string uName = 'venky@raagvitech.com';
    private string passwd = 'Navya@1234UunShEG6NKVpEsqIVOhoDheFb';
    public class responseWrapper {
        public string id;
        public string access_token;
        public string instance_url;
    }
    public string getRequestToken() {
        string reqBody = 'grant_type=password&client_id=' + cKey + '&client_secret=' + cSecret + '&username=' + uName + '&password=' + passwd;
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setBody(reqBody);
        req.setMethod('POST');
        req.setEndpoint('https://raagvitech97-dev-ed.my.salesforce.com/services/oauth2/token');
        HttpResponse hresp = h.send(req);
        responseWrapper wResp = (responseWrapper) JSON.deserialize(hresp.getBody(), responseWrapper.class);
        system.debug('Instance url' + wResp.instance_url);
        system.debug('session id' + wResp.access_token);
        return wResp.access_token;
    }
    @future(callout = true)
    public static void getConList(Set<id> conIdSet) {
        String accToken;
        string responseBody;
        string endPoint = 'https://raagvitech97-dev-ed.my.salesforce.com/services/apexrest/createContactRecord';
        callWebserviceClass obj = new callWebserviceClass();
        accToken = obj.getRequestToken();
        system.debug('access token' + accToken);
        if (accToken != '') {
            for (Contact con: [SELECT id, firstName, lastName, email from contact where id in: conIdSet]) {
                 system.debug('JSON' + JSON.serialize(con));
                Http h1 = new Http();
                HttpRequest req1 = new HttpRequest();
                req1.setHeader('Authorization', 'Bearer ' + accToken);
                req1.setHeader('Content-Type', 'application/json');
                req1.setMethod('POST');
                req1.setBody(JSON.serialize(con));
                req1.setEndpoint(endPoint);
                HttpResponse hresp1 = h1.send(req1);
                system.debug('hresp1' + hresp1);
            }
        }
    }
}