/**
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* appex Trigger on Opportunity
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Kiran Kumar       <kiran.kumar@raagvitech.com>
* @modifiedBy     Kiran Kumar       <kiran.kumar@raagvitech.com>
* @maintainedBy   Kiran Kumar       <kiran.kumar@raagvitech.com>
* @version        1.0
* @created        2021-11-29
* @modified
* @systemLayer    UpdateAccountInfoOppCustomer
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
trigger UpdateAccountInfoOppCustomer on Opportunity (after insert, after update, after delete) {
  
    OpportunityTriggerHandler.updateOnAccountOfOpp((List<Opportunity>)Trigger.new);
  
    Set<Id> accID = new Set<Id>();
    if(Trigger.isInsert){
        for(Opportunity opp : Trigger.New){
            accID.add(opp.AccountId);
        }
    }
    else if(Trigger.isDelete){
        for(Opportunity opp : Trigger.old){
            accID.add(opp.AccountId);
        }
    }
    OpportunityTriggerHandler.updateAcc(accID);
}