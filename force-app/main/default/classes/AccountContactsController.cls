public with sharing class AccountContactsController {
@AuraEnabled
public static List<Contact> getContacts(String accountId) {
    return [SELECT Id, Name, Title, Email, Phone
            FROM Contact
            WHERE Id = :accountId];
}
}