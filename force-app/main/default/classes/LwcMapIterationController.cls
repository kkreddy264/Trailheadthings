/**
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* appex Class for LwcMapIterationController
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Kiran Kumar       <kiran.kumar@raagvitech.com>
* @modifiedBy     Kiran Kumar       <kiran.kumar@raagvitech.com>
* @maintainedBy   Kiran Kumar       <kiran.kumar@raagvitech.com>
* @version        52.0
* @created        2021-11-10
* @modified
* @systemLayer    LwcMapIterationController Handler
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public with sharing class LwcMapIterationController {
    /** 
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description Getting the records from Opportunity
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param    None
* @return   mapOppAccount
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
**/

    @AuraEnabled(cacheable=true)
    public static Map <String, String> fetchMapData() {
        Map <String, String> mapOppAccount = new Map <String, String>();
        for(Opportunity opp : [SELECT ID, Account.Name, Name 
                                FROM Opportunity LIMIT 5])
        	mapOppAccount.put(opp.Name, opp.Account.Name);
        return mapOppAccount;
    }
}