public with sharing class lwcSortingDataTableCtrl {
 
    @AuraEnabled(Cacheable = true)
    public static List<Contact> sortContactList(){
        return [
            SELECT Name, Email, Phone, Account.Name,Owner.Name,Title
            FROM Contact
        ];
    }
 
}