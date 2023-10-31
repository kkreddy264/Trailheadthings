/**
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* appex Trigger for UpdateAccSalary
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Kiran Kumar       <kiran.kumar@raagvitech.com>
* @modifiedBy     Kiran Kumar       <kiran.kumar@raagvitech.com>
* @maintainedBy   Kiran Kumar       <kiran.kumar@raagvitech.com>
* @version        1.0
* @created        2021-12-07
* @modified
* @systemLayer    UpdateAccSalary
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
trigger UpdateAccSalary on Contact (after insert, after update, after delete, after undelete) {

    List<ID> accID = new List<ID>();
    //Check for type of DML Operation, For Insert, Update and Undelete we have Trigger.New
    if(Trigger.IsInsert || Trigger.IsUpdate || Trigger.IsUndelete){
        for(Contact conObj1: Trigger.new){
            //Add all new AccountID in the List 
            if(conObj1.AccountID != null)
            accID.add(conObj1.AccountID);
        }
    }
    //Check for type of DML Operation, For Delete we have Trigger.Old
    if(Trigger.IsDelete){
        for(Contact conObj2: Trigger.old){
            if(conObj2.AccountID != null)
            accID.add(conObj2.AccountID);
        }
    }
    if(accID !=null && accID.size()>0){
    
          UpdationOnAccount.accSalaryUpdate(accID);
    }
}