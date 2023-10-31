public with sharing class lwcApexController {
      
    //custom lookup lwc
@AuraEnabled(cacheable=true)
public static List<Account> getCustomLookupAccount (String actName){
   List<Account> accLookupList =  new List<Account>();
   if(actName != ''){
       String accountName = '%' + actName + '%';
       accLookupList = [Select Id, Name From Account Where Name like:accountName];
       return accLookupList;
   }
   return accLookupList;
}   
 
}