/**
* ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* handler TestClass for ContactTriggerHandler
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Kiran Kumar       <kiran.kumar@raagvitech.com>
* @modifiedBy     Kiran Kumar       <kiran.kumar@raagvitech.com>
* @maintainedBy   Kiran Kumar       <kiran.kumar@raagvitech.com>
* @version        52
* @created        2021-10-06
* @modified       
* @systemLayer    ContactTriggerHandlerTest Handler
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
@isTest
public class ContactTriggerHandlerTest {
    @isTest
    public static void setup(){
        
        Test.startTest();
        List<Contact> contactList = new List<Contact>();
         Set<Id> accId = new Set<Id>();
        
        Account myAccount= new Account();
        myAccount.Name = 'Test';
        Insert myAccount;
        
        for(Integer i = 0; i <= 6; i++){
            
            Contact con = new Contact();
            con.Id='Test'+ i;
            con.AccountId = myAccount.Id;
            contactList.add(con);
        }
        
        Insert contactList;
        Test.stopTest();
       
        
        
    }
}