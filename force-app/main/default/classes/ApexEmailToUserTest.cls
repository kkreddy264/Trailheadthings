/**
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* appex Class for ApexEmailToUserTest
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Kiran Kumar       <kiran.kumar@raagvitech.com>
* @modifiedBy     Kiran Kumar       <kiran.kumar@raagvitech.com>
* @maintainedBy   Kiran Kumar       <kiran.kumar@raagvitech.com>
* @version        1.0
* @created        2021-11-26
* @modified
* @systemLayer    ApexEmailToUserTest Handler
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
@isTest
public class ApexEmailToUserTest {

    testMethod static void testForUserEmail(){
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        Test.startTest();
        ApexEmailToUser.SendEmailWithAttachments();
        Test.stopTest();
        System.assertEquals( true,mail.isTreatTargetObjectAsRecipient());    

    }
}