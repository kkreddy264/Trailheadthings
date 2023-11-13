/**
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* appex Class for OpportunityTriggerHandler
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Kiran Kumar       <kiran.kumar@raagvitech.com>
* @modifiedBy     Kiran Kumar       <kiran.kumar@raagvitech.com>
* @maintainedBy   Kiran Kumar       <kiran.kumar@raagvitech.com>
* @version        1.0
* @created        2021-11-29
* @modified
* @systemLayer    OpportunityTriggerHandler
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public with sharing class OpportunityTriggerHandler {

    public static void updateOnAccountOfOpp(List<Opportunity> oppList) {

 /** 
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description updating the fields on Account
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param    oppList
* @void     updateOnAccountOfOpp
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
        Set<Id> associatedAccId = new Set<Id>();
        List<Account> acctToUpdate = new List<Account>();
        List<Opportunity> oppList1 = new List<Opportunity>([SELECT Id, AccountId, StageName, Account.Type 
                                                            FROM Opportunity 
                                                            WHERE AccountId =:associatedAccId]); 
         List<Task> taskList = new List<task>();
        
        
        for (Opportunity oppObj : oppList) {
            associatedAccId.add(oppObj.AccountId) ;
        }
        
        
        for (Opportunity oppObj1 : oppList1) {
                if (oppObj1.StageName == 'Closed Won - One Time' 
                    || oppObj1.StageName == 'Closed Won - Recurring' 
                    || oppObj1.StageName == 'Customer Reseller'
                    || oppObj1.StageName == 'Closed Won') {   
                   
                    oppObj1.Account.Type  = 'Customer';
                    acctToUpdate.add(oppObj1.Account) ; 
                    taskList.add(new Task(Subject= 'Follow Up Test Task', WhatId = oppObj1.Id));
                }
               else if(taskList.size()>=0) {        
                    insert taskList;        
                   }
               else {
                oppObj1.Account.Type = 'Prospect';
                    acctToUpdate.add(oppObj1.Account) ;
                }
        }
        update acctToUpdate;
    }
    public static void updateAcc(Set<Id> accIds){
/** 
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description updating the fields on Account
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param    accIds
* @void     updateAcc
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
**/

        List<Account> accList = [SELECT Id, TotalOpp__c 
                                 FROM Account 
                                 WHERE Id in :accIds];

        List<Opportunity> oppsList = [SELECT Id 
                                      FROM Opportunity 
                                      WHERE AccountId in :accIds];
                                      
        for(Account accObj : accList){
            accObj.TotalOpp__c= oppsList.size();
        }
        update accList;
    }
    
    Public static void accFieldUpdateBasedOnOpp(List<Opportunity> oppList,Map<Id,Opportunity> oldMap){
	/** 
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description updating the fields on Account
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param    oppList,oldMap
* @void     accFieldUpdateBasedOnOpp
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
**/ 
		Set<Id> accIds = new Set<Id>();
        Map<Id,Decimal> accMap = new Map<Id,Decimal>();
        
        for(Opportunity oppObj:oppList){
            if(oppObj.AccountId != NULL){
                accIds.add(oppObj.AccountId);
            }
        }
        List<Opportunity> accOppList = [SELECT Id,Amount,AccountId,Account.Total_Amount__c 
                                        FROM Opportunity 
                                        WHERE AccountId IN:accIds];

		for(Opportunity oppObj:accOppList){
	
		
			if((oppObj.AccountId != NULL && oppObj.Amount !=null) || oldMap.get(oppObj.Id).Amount != oppObj.Amount){
			
				if(accMap.containskey(oppObj.AccountId)){

				 oppObj.Account.Total_Amount__c =oppObj.Account.Total_Amount__c+oppObj.Amount; 
				accMap.put(oppObj.AccountId,oppObj.Account.Total_Amount__c);	
				}
				else{	
				oppObj.Account.Total_Amount__c = oppObj.Amount;
				accMap.put(oppObj.AccountId,oppObj.Account.Total_Amount__c);
				}		
			}
		}
		/*for(Opportunity oppObj:oldMap.Values()){
			
			if(oppObj.AccountId != NULL && oppObj.Amount !=null 
			   && accMap.containskey(oppObj.AccountId)){
				
				Decimal amt =accMap.get(oppObj.AccountId)-oppObj.Amount; 
				accMap.put(oppObj.AccountId,amt);
			}
		}*/

		List<Account> accList = [SELECT Id,Total_Amount__c FROM Account];
		List<Account> updateAccList = new List<Account>();
		for(Account accObj: accList){
		
			if(accMap.containskey(accObj.Id)){
			
				accObj.Total_Amount__c = accMap.get(accObj.Id);
				updateAccList.add(accObj);
			}
		}
		update updateAccList;
   }
    
}