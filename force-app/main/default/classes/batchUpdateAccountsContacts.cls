/**
* ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* handler Class for batchUpdateAccountsContacts
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Kiran Kumar       <kiran.kumar@raagvitech.com>
* @modifiedBy     Kiran Kumar       <kiran.kumar@raagvitech.com>
* @maintainedBy   Kiran Kumar       <kiran.kumar@raagvitech.com>
* @version        52
* @created        2021-10-05
* @modified       
* @systemLayer    batchUpdateAccountsContacts Handler
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public class batchUpdateAccountsContacts implements Database.Batchable <sObject> {
/**
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description Getting the records from Account and Contact
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param    info
* @return   Database.QueryLocator
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
*/

    public Database.QueryLocator start(Database.BatchableContext info){ 
        String SOQL='SELECT Id, Name, NumberOfEmployees, Description,(SELECT Id, firstName FROM Contacts) FROM Account';
        return Database.getQueryLocator(SOQL);
    }
    
/**
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description check weather The account Fields and Contact fields are update
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param    info
* @void   execute
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
*/
    public void execute(Database.BatchableContext info, List<Account> scope){
        

        List<Account> accListToUpdate = new List<Account>();
        List<Contact> conList = new List<Contact>();
        List<Contact> conListToUpdate = new List<Contact>();
        for(Account accObj : scope)
        { 
            accObj.description ='the Contacts under account is' + accObj.contacts.size() ;
            accObj.NumberOfEmployees = accObj.contacts.size();
            accListToUpdate.add(accObj); 
           
            conList.addAll(accObj.contacts);
        }
         for (Contact conObj : conList){
             
                conObj.firstName = 'Batch'; 
             conListToUpdate.add(conObj);   
            }
        // Here we are cheking conListToUpdate is not empty and then Update it
        if(!conListToUpdate.isEmpty()){
            
            Database.update(conListToUpdate);
        }
        //Here we are cheking accListToUpdate is not empty and then Update it
        if(!accListToUpdate.isEmpty()){
            
            Database.update(accListToUpdate);
        }
        
    }
    public void finish(Database.BatchableContext info){ 
        
    }
}