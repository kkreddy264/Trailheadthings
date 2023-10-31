public with sharing class ContactsOnAccount {
    @AuraEnabled(cacheable=true)
    public static List<Contact> retrieveContactRecords(string accId){
      List<Contact> conObj = new  List<Contact>();
      List<Contact> conList = [Select Id, FirstName, LastName, Email, Phone, AccountId From Contact Where AccountId=:accId];
      for(Contact con:conList){
        conObj.add(con);
      }
      return conObj;
    }
}