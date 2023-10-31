public with sharing class ContactDataTable {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String accId){
        return [
            SELECT AccountId, Id, FirstName, LastName, Title, Phone, Email
            FROM Contact
            WHERE AccountId = :accId
            WITH SECURITY_ENFORCED
        ];
    }
    @AuraEnabled
    public static void deleteAccount(List<Contact> conList){
        delete conList;

    }
}