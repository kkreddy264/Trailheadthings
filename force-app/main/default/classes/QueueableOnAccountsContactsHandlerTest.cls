/**
* ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* handler TestClass for QueueableOnAccountsContacts
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Kiran Kumar       <kiran.kumar@raagvitech.com>
* @modifiedBy     Kiran Kumar       <kiran.kumar@raagvitech.com>
* @maintainedBy   Kiran Kumar       <kiran.kumar@raagvitech.com>
* @version        52
* @created        2021-10-06
* @modified       
* @systemLayer    QueueableOnAccountsContactsTest Handler
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
@isTest
public class QueueableOnAccountsContactsHandlerTest {
    
    @isTest
    public static void testQueueableOnAccountsContacts(){    
        
        //Create test case for accounts and contacts to update
        List<Account> accList = new List<Account>();
        List<Contact> conList = new List<Contact>();
        for(Integer i = 0; i <= 10; i++){
            
            Account accObj = new Account();
            accObj.Name = 'Test' + i;
            accObj.NumberOfEmployees = i;
            accObj.Description = 'Test' + i;
            accList.add(accObj);
            
            Contact conObj = new Contact();
            conObj.firstName = 'Test' + i;
            conObj.lastName = 'Test' + i;
            conObj.Id = accObj.Id;
            conList.add(conObj);
        }
        Insert accList;
        Insert conList;
        
        Test.startTest();
        QueueableOnAccountsContactsHandler qac = new QueueableOnAccountsContactsHandler();
        System.enqueueJob(qac);
        Test.stopTest();
        // Verify accounts updated
        Account updatedAcc = [SELECT Id, Name, NumberOfEmployees, Description, (SELECT Id, firstName FROM Contacts)
                                         FROM Account 
                                         WHERE Name = 'Test1' ];
        System.assertEquals(updatedAcc.contacts.size(), updatedAcc.NumberOfEmployees);
    }
}