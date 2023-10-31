/**
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* appex Class for AccountRelatedCon
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Kiran Kumar       <kiran.kumar@raagvitech.com>
* @modifiedBy     Kiran Kumar       <kiran.kumar@raagvitech.com>
* @maintainedBy   Kiran Kumar       <kiran.kumar@raagvitech.com>
* @version        1.0
* @created        2021-10-22
* @modified
* @systemLayer    AccountRelatedCon Handler
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public with sharing class AccountRelatedCon {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsRelatedToAccount(String accId) {
        
/** 
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description Getting the records from Account and Contact
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param    RecId
* @return   Contact
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
system.debug('accId  ' + accId);
return [SELECT Id, FirstName, LastName, Email, Phone
        FROM Contact 
        WHERE AccountId =:accId];
}

    

}