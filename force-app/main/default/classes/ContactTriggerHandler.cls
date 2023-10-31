/**
* ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* handler Class for Contact__c Trigger
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Kiran Kumar       <kiran.kumar@raagvitech.com>
* @modifiedBy     Kiran Kumar       <kiran.kumar@raagvitech.com>
* @maintainedBy   Kiran Kumar       <kiran.kumar@raagvitech.com>
* @version        52
* @created        2020-09-24
* @modified       
* @systemLayer    Contact Trigger Handler
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public class ContactTriggerHandler {
    
    /**
        * ───────────────────────────────────────────────────────────────────────────────────────────────────┐
        * @description check weather status is changed
        * ───────────────────────────────────────────────────────────────────────────────────────────────────
        * @param    accId
        * @return   void
        * ───────────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    
    public static void chekAndSendNotification(Set<Id> accIds){
        System.debug('The ids are ' + accIds);
        List<Messaging.singleEmailMessage> mails =  new List<Messaging.singleEmailMessage>();
        
        for(Account myAccount : [SELECT Id, Name, Owner.email,(SELECT Id FROM Contacts)
                                 FROM Account 
                                 WHERE Id IN : accIds]){
                                     
                                     if(myAccount.contacts.size() >=  6){ 
                                         
                                     System.debug('Size ' + myAccount.contacts.size());                         
                                     // Step 2: Create a new email
                                     Messaging.singleemailmessage mail = new Messaging.singleemailmessage();
                                     
                                     
                                     // step 3: set list of people who should get mail
                                     List<string> sendTo = new List<string>();
                                     sendTo.add(myAccount.Owner.email);
                                     system.debug('==============' + myAccount.Owner.email);
                                     mail.setToAddresses(sendTo);
                                     
                                     // step 4: set who the email is sent from
                                     mail.setReplyTo('youreamil@gmail.com ');
                                     mail.setSenderDisplayName('Your Name');
                                     
                                     // step 5: set email contents
                                     mail.setSubject('Reached the limit for creating contacts on account');
                                     mail.setHtmlBody('This Account' + ' ' + myaccount.name  + ' ' + 'already exists');
                                     
                                     // Add your email to the master list
                                     mails.add(mail);
                                     
                                     } 
                                 }
        
        // send all emails in the master list
       
        //Messaging.sendEmail(mails);
        
        system.debug('=====Mail is Sent==========');   
    }

    /**
        * ───────────────────────────────────────────────────────────────────────────────────────────────────┐
        * @description check weather status is changed
        * ───────────────────────────────────────────────────────────────────────────────────────────────────
        * @param    accId
        * @return   void
        * ───────────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    
    public static void contactFieldUpdate(List<Contact> newList,Map<Id, Contact> oldMap){

        List<Contact__e> conList = new List<Contact__e>();
        for (Contact con: newList) {
            if (oldMap.get(con.Id).Level__c != con.Level__c) {
                
                Contact__e conObj = new Contact__e();
                conObj.Level__c  = con.Level__c;
                conList.add(conObj);
            }
        }
        Eventbus.publish(conList);
    }
}