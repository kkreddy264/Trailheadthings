public with sharing class AccountTriggerHandler extends TriggerHandler {

    public override void beforeInsert(){
        System.debug(LoggingLevel.INFO, 'In before insert');
    }
    public override void afterUpdate(){

        Map<Id,String> accIdMap = new Map<Id,String>();
        List<Account> clonedAccsList = new List<Account>();
        Map<Id,List<String>> clonedAccsMap = new Map<Id,List<String>>();
        List<Opportunity> oppList = new List<Opportunity>();

        for(Account accObj: (List<Account>)Trigger.new){
            
            if(accObj.OwnerId != null){
                
                if(accObj.Cloned__c == true){
                    accObj.clone(false, true, false, false);
                    clonedAccsList.add(accObj);
                }

                for(Account accObj1: (List<Account>)Trigger.old){
                    if(accObj.OwnerId != accObj1.OwnerId){
                        accIdMap.put(accObj.Id, accObj.OwnerId);
                    }
                }
            }
        }
        List<Contact> listToUpdateContactFields  = [SELECT Id, LastName, AccountId, OwnerId 
                                  FROM Contact 
                                  WHERE AccountId IN: accIdMap.keySet() WITH SECURITY_ENFORCED];
        for(Contact conObj: listToUpdateContactFields){
            conObj.OwnerId = accIdMap.get(conObj.AccountId);
            listToUpdateContactFields.add(conObj);
        }
        if(!clonedAccsList.isEmpty()){
            clonedAccsList;
        }
        for(Account accObj: clonedAccsList){

            Id sourceId = accObj.getCloneSourceId();
            if(!clonedAccsMap.containsKey(accObj.getCloneSourceId()) && sourceId != null){
                clonedAccsMap.put(sourceId,new List<String>{accObj.Name});
            }
            else {
                clonedAccsMap.get(sourceId).add(accObj.Name);
            }
        }
        List<Account> sourceAccList = [SELECT Id,Name,(SELECT Id,Name,AccountId,Account.Name FROM Opportunities) 
                                        FROM Account 
                                        WHERE Id=:clonedAccsMap.keySet() WITH SECURITY_ENFORCED];

        for(Opportunity oppObj: sourceAccList[0].Opportunities){

            if(oppObj.AccountId != null && clonedAccsMap.containsKey(oppObj.AccountId)){
                List<List<String>> clonedAccNameList = clonedAccsMap.values();
                for(List<String> clonedAccNames:clonedAccNameList){
                    if(!clonedAccNames.isEmpty()){
                        for(String accNames:clonedAccNames){
                            oppObj.Account.Name = accNames;
                            oppList.add(oppObj);
                        }
                    }
                } 
            }
        }
        update listToUpdateContactFields;
        update oppList;
    }
}