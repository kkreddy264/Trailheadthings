/**
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* appex Class for OpportunityController
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Kiran Kumar       <kiran.kumar@raagvitech.com>
* @modifiedBy     Kiran Kumar       <kiran.kumar@raagvitech.com>
* @maintainedBy   Kiran Kumar       <kiran.kumar@raagvitech.com>
* @version        1.0
* @created        2021-11-16
* @modified
* @systemLayer    OpportunityController Handler
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public with sharing class OpportunityController {
    @AuraEnabled(cacheable = true)
    public static Opportunity getOppData(String oppId) {
    /** 
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description Getting the records from Opportunity
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param    oppId
* @return   Opportunity
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
**/    
            System.debug('Id'+oppId);
        return [SELECT Id, Amount, NextStep, StageName, CloseDate
                FROM Opportunity
                WHERE Id =:oppId];

    }
    @AuraEnabled(cacheable = true)
    public static void updateOppData(List<Opportunity> oppList) {
    /** 
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description updating the records on Opportunity
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param    oppList
* @void     Opportunity
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
**/ 

            upsert oppList;
    }   
    @AuraEnabled
    public static Account insertAccount(Account toInsert) {
/** 
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description inserting the record into the Account
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param    toInsert
* @return   Account
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
**/ 
        System.debug('values'+toInsert);

            upsert toInsert;
            return toInsert;
    }
}