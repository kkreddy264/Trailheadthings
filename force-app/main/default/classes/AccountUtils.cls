public with sharing class AccountUtils {
    
    public Account createAccount(String name){
        if(String.isNotBlank(name)){
            Account a = new Account(Name = name);
            insert a;
            return a;
        }else{
            System.debug(LoggingLevel.INFO, 'No value found to create account');
            return new Account();
        }
    }

    public List<Account> getAccounts(String name){
        return [SELECT Id, Name FROM Account WHERE Name =: name];
    }
}