/**
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* appex Class for UpdationOnAccount
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Kiran Kumar       <kiran.kumar@raagvitech.com>
* @modifiedBy     Kiran Kumar       <kiran.kumar@raagvitech.com>
* @maintainedBy   Kiran Kumar       <kiran.kumar@raagvitech.com>
* @version        1.0
* @created        2021-12-07
* @modified
* @systemLayer    UpdationOnAccount
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public class UpdationOnAccount {
 /** 
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description updating the Total_Salary__c field on Account
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param     accID
* @void      accSalaryUpdate
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
    
    public static void accSalaryUpdate(List<ID> accID)
    {
        Map<ID,Account> accountMap = new Map<ID,Account>(); 

        //Add all the accounts in the Map, to map ID with the Account Cost
        for(ID AccountID : accID){
            accountMap.put(AccountID, new Account(ID = AccountID, Total_Salary__c = 0));
        }
          
            //Calculate the Total Account Cost based on the Contact Cost
        for(Contact ConObj : [SELECT ID, AccountID, Salary__c FROM Contact WHERE AccountID IN :accID]){
            accountMap.get(ConObj.AccountID).Total_Salary__c = ConObj.Salary__c;
        }
        //Commit to the Database
        Database.update(accountMap.values());    
  }  
}