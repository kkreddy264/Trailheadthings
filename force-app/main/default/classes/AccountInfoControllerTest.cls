/**
* ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* TestHandler Class for AccountInfoController
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Kiran Kumar       <kiran.kumar@raagvitech.com>
* @modifiedBy     Kiran Kumar       <kiran.kumar@raagvitech.com>
* @maintainedBy   Kiran Kumar       <kiran.kumar@raagvitech.com>
* @version        52
* @created        2021-10-19
* @modified       
* @systemLayer    AccountInfoControllerTest Handler
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
@isTest
public class AccountInfoControllerTest {
    
     @isTest
    public static void testForEditedAccount(){
        
        Account accObj = new Account();
        accObj.Name = 'Test';
        Insert accObj;
        Test.startTest();
          Account ac= AccountInfo.getAccountRecord(accObj.Id);
          Account ac1= AccountInfo.saveEditForm(accObj.Id, 'kiran', 10, 'test');
         Test.stopTest();
       System.assertEquals(10,ac1.NumberOfEmployees);
        
    }

}