/**
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* appex Class for LwcAccountsPageController
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Kiran Kumar       <kiran.kumar@raagvitech.com>
* @modifiedBy     Kiran Kumar       <kiran.kumar@raagvitech.com>
* @maintainedBy   Kiran Kumar       <kiran.kumar@raagvitech.com>
* @version        1.0
* @created        2021-11-24
* @modified
* @systemLayer    LwcAccountsPageController Handler
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public with sharing class LwcAccountsPageController {
    @AuraEnabled(cacheable=true)
   public static List<Account> getAccountList(String searchKey, String sortBy, String sortDirection) {
 /** 
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description Getting the records from Account
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param    None
* @return   Account
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
      
       String query = 'SELECT Id, Name, AccountNumber, Industry, AnnualRevenue FROM Account';

           if ( searchKey != null && searchKey != '' ) {
                String key = '%' + searchKey + '%';
                query += ' WHERE Name LIKE :key';
            }
            if ( sortBy != null && sortDirection != null ) {
                query += ' ORDER BY ' + sortBy + ' ' + sortDirection;
            }
            return Database.query( query );
     
   }
}