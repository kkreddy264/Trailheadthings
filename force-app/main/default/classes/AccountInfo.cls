/**
* ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* handler Class for Account
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Kiran Kumar       <kiran.kumar@raagvitech.com>
* @modifiedBy     Kiran Kumar       <kiran.kumar@raagvitech.com>
* @maintainedBy   Kiran Kumar       <kiran.kumar@raagvitech.com>
* @version        52
* @created        2021-10-08
* @modified       2021-10-19
* @systemLayer    AccountInfo Handler
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public class AccountInfo {
    
    
    @AuraEnabled
    public static Account getAccountRecord(Id accId ){
       /**
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description Fetching the records from Account
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param    accId
* @return   sObject
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
*/  
    
         Account accObj = ([SELECT Id, Name, NumberOfEmployees, Description 
                                  FROM Account  
                                  WHERE Id =: accId]);
        
        return accObj;
    }
    @AuraEnabled
    public static Account saveEditForm(Id accId,String Name,Integer NumberOfEmployees,String Description) {
/**
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description Updating the Existingrecord
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param    accId
* @param    Name
* @param    NumberOfEmployees
* @param    Description
* @return   sObject
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
*/    
        System.debug('save Name and called: '+Name);
        System.debug('save NumberOfEmployees and called: '+NumberOfEmployees);
        System.debug('save Description and called: '+Description);
        
        Account accObj = ([SELECT Id, Name, NumberOfEmployees, Description 
                                  FROM Account  
                                  WHERE Id =: accId]);
        accObj.Id = accId;
        accObj.Name = Name;
        accObj.NumberOfEmployees = NumberOfEmployees;
        accObj.Description = Description;
        
        update accObj;
        return accObj;
    }
}