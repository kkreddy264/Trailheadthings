trigger SubCaseOfCaseCountOnAccount on SubCase__c (after insert) {

    SubCaseOfCaseCountOnAccountHandler.subCaseOfCaseCount(Trigger.new);

}