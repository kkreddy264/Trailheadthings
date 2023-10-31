public with sharing class sortingLwc {
    @AuraEnabled(Cacheable=true)
    public static List <Contact> getContacts() {
        List<Contact> contList = [ SELECT Name, Email, Title, Phone
                                   FROM Contact
                                   LIMIT 10 ];
        return contList;
    }   
}