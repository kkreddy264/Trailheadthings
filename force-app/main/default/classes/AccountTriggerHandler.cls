public with sharing class AccountTriggerHandler {

    public static void getAccType(List<Account> accountList){
        System.debug('Test1');
        for(Account acc : accountList) {
            System.debug('Test'+acc.Industry);
            if(String.isNotBlank(acc.Industry) && 
               (acc.Industry == 'Banking' 
               || acc.Industry == 'Healthcare')){
                   System.debug('Test');
                 acc.Rating = 'Cold';
            }
        }    
    }
}