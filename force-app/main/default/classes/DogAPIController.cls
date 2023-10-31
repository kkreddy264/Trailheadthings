public with sharing class DogAPIController {
    @AuraEnabled
    public static String fetchRandomDog() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
         
        // Provide the Named Credentials
        request.setEndpoint('callout:Dog_API');
        request.setMethod('GET');        
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            return response.getBody();
        }
        return null;
    }
}