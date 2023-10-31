/**
* ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* handler Class for QueueableOnAccountsContacts
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Kiran Kumar       <kiran.kumar@raagvitech.com>
* @modifiedBy     Kiran Kumar       <kiran.kumar@raagvitech.com>
* @maintainedBy   Kiran Kumar       <kiran.kumar@raagvitech.com>
* @version        52
* @created        2021-10-06
* @modified       
* @systemLayer    QueueableOnAccountsContacts Handler
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public class QueueableOnAccountsContactsHandler implements Queueable {
    /**
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description Update the records of Account and Contact
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param    info
* @void     execute
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
*/
    public void execute(QueueableContext info){
        
        List<Account> accList = [SELECT Id, Name, NumberOfEmployees, Description,(SELECT Id, firstName FROM Contacts)
                                 FROM Account];
        
        List<Account> accListToUpdate = new List<Account>();
        List<Contact> conList = new List<Contact>();
        List<Contact> conListToUpdate = new List<Contact>();
        for(Account accObj : accList){ 
            
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
            
            update conListToUpdate;
        }
        //Here we are cheking accListToUpdate is not empty and then Update it
        if(!accListToUpdate.isEmpty()){
            
            update accListToUpdate;
        }
    }
}