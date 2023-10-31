trigger CaseReassignQueueBasedOnSubject on Case (after insert) {
    //Get All Accounts
    List<Account> account = [SELECT Id, CNUM__c FROM Account];
    //Variables for later use
    List<Case> casesToUpdate = new List<Case>();
    String CNUM = null;
    String AccountId = null;
    String CaseId = null;

    //For each case set variable -- Not working for bulk inserts
    for (Case c: Trigger.New) {
        //validate that the parsing won't fail
        if (c.Subject.contains('[')) {
            //get CNUM
            Integer start_pos = c.Subject.indexOf('[') + 1;
            Integer end_pos = c.Subject.indexOf(']',start_pos);
            CNUM = c.Subject.substring(start_pos,end_pos);
            CaseId = c.Id;
            System.debug('Parsed_CNUM: ' + CNUM);
            casesToUpdate.add(c);
        }
    }

    //find the accountId and set local variable
    for (Account la: account) {
       if (la.CNUM__c == CNUM) {
          System.debug('Account.Id: ' + la.Id);
          System.debug('Account.CNUM__c: ' + la.CNUM__c);
          AccountId = la.Id;
        }
    }

    //Update Case Values
    System.debug('Case.Id: ' + CaseId);
    List<Case> updateCases = [select AccountId, Id from Case where Id = :CaseId];
    for (Case updC: updateCases) {
          System.debug('AccountId_NEW_SETTING_VALUE: ' + AccountId);
          updC.AccountId = AccountId;
          System.debug('updC.AccountId: ' +updC.AccountId);
    }

    //Update Cases
    System.debug('updateCases: ' + updateCases.size());
    if (updateCases.size() > 0) {
        update updateCases;
    }
}