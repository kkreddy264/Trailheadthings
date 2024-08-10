public with sharing class SubCaseOfCaseCountOnAccountHandler {
    
    public static void subCaseOfCaseCount(List<SubCase__c> subCaseList){
        
        Integer count = 0;
        Set<Id> caseIds = new Set<Id>();
        Map<Id,Decimal> caseCountMap = new Map<Id,Decimal>();
        List<Account>  updateAccList = new List<Account>();

        for(SubCase__c subCaseObj :subCaseList) {
            if(subCaseObj.CaseId__c !=null){
                caseIds.add(subCaseObj.CaseId__c);
            }
        }
        System.debug('caseid'+ caseIds );
        List<Case> caseList =[SELECT Id,AccountId,Account.CaseCount__c 
                               FROM Case 
                               WHERE Id IN:caseIds WITH SECURITY_ENFORCED];

        for (Case caseObj : caseList) {
            
            if (caseObj.AccountId != null){

                caseObj.Account.CaseCount__c = caseObj.Account.CaseCount__c + 1;
                caseCountMap.put(caseObj.AccountId, caseObj.Account.CaseCount__c);
            }
            
        }
        System.debug('mapvalues'+caseCountMap);
        List<Account> accList =[SELECT Id,CaseCount__c 
                               FROM Account 
                               WHERE Id =:CaseCountMap.keySet() WITH SECURITY_ENFORCED];

        for(Account accObj:accList){

            if (caseCountMap.containsKey(accObj.Id)) {
                
                accObj.CaseCount__c = caseCountMap.get(accObj.Id);
                updateAccList.add(accObj);
            }
        }
        System.debug('updateAccList'+updateAccList);
        if (!updateAccList.isEmpty()) {
        update updateAccList;
        }
    }
}