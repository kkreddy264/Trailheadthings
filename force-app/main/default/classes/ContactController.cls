public with sharing class ContactController {
    
    @AuraEnabled(cacheable = true)
    public static List<Contact> getContacts(){
        
        //return [SELECT FirstName, LastName, Email FROM Contact];
        throw new AuraHandledException('Forced error');
    }
    @AuraEnabled
    public static List<Contact> getContacts1(){
        
        return [SELECT Id,FirstName,LastName,Email,Level__c FROM Contact];
    }

    @AuraEnabled
    public static List<Contact> updateContacts(String level, Id recordId){
        System.debug('level-->'+level);
        System.debug('recordId'+recordId);
        List<Contact> conList =[SELECT Id,FirstName,LastName,Email,Level__c FROM Contact WHERE Id=:recordId];
        List<Contact> updateConList = new List<Contact>();
        for(Contact conObj: conList){
            if(recordId == conObj.Id){
                conObj.Level__c = level;
                updateConList.add(conObj);
            }
        }
        Database.update(updateConList);
        return updateConList;
    }
}