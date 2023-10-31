public with sharing class FootBallDetailsAPI {
    @AuraEnabled
    public static string footBallApiDetails() {

        Http http = new Http();
        HttpRequest request =new HttpRequest();

        request.setEndPoint('callout:FootBallAPI');
        request.setMethod('GET');

        HttpResponse response = new HttpResponse();
        if(response.getStatusCode() == 200){

            return response.getBody();
        }
        return null;
    }
}