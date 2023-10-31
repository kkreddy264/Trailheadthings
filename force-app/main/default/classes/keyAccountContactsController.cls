public with sharing class keyAccountContactsController {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String accountId) {
        return [SELECT Id, Name, Title, Email, Phone, AccountId
                FROM Contact
                WHERE AccountId = :accountId];
    }
}