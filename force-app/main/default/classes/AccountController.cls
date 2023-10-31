/**
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* appex Class for AccountController
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Kiran Kumar       <kiran.kumar@raagvitech.com>
* @modifiedBy     Kiran Kumar       <kiran.kumar@raagvitech.com>
* @maintainedBy   Kiran Kumar       <kiran.kumar@raagvitech.com>
* @version        1.0
* @created        2021-10-22
* @modified
* @systemLayer    AccountController Handler
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public with sharing class AccountController {
    //account controller class
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountData(){
/** 
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description Getting the records from Account
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param    None
* @return   Account
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
            return [SELECT Id, Name, NumberOfEmployees, AnnualRevenue,Phone
                    FROM Account WHERE Phone<>null];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsRelatedToAccount(String accId) {
        /** 
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description Getting the Contact records from Account
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param    RecId
* @return   ContactList
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
    system.debug('accId  ' + accId);
    return [SELECT Id, FirstName, LastName, Email, Phone
            FROM Contact 
            WHERE AccountId =:accId];
    }

    @AuraEnabled(Cacheable = false)
    public static List<Contact> getContacts(Id sourceAccount){
        /** 
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description Getting the Contact records from Account for the custom table
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param    sourceAccount
* @return   ContactList
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
        
        return [SELECT Id, LastName, FirstName, Email, Phone, MobilePhone
                FROM Contact 
                WHERE AccountId =: sourceAccount]; 
                
    } 
    @AuraEnabled(Cacheable = false) 
    public static void updateContacts(List<Contact> conList){
         /** 
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description Updating the Contact records from Account for the custom table
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param    conList
* @void   ContactList
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
       update conList;
    }
}