/**
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* appex Class for ApexEmailToUser
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Kiran Kumar       <kiran.kumar@raagvitech.com>
* @modifiedBy     Kiran Kumar       <kiran.kumar@raagvitech.com>
* @maintainedBy   Kiran Kumar       <kiran.kumar@raagvitech.com>
* @version        1.0
* @created        2021-11-26
* @modified
* @systemLayer    ApexEmailToUser Handler
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
**/

public class ApexEmailToUser {
public static void SendEmailWithAttachments(){
    /** 
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description sending the Email to the salesforceuser
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param    None
* @void     SendEmailWithAttachments
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
**/    
       // If we know how many addresses the email will be sent to from this transaction
       // We can set the reserve capacity
       Messaging.reserveSingleEmailCapacity(2);

       //We instantiate our single email message object
       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

       // Strings to hold the email addresses to which you are sending the email.
        mail.setToAddresses( new String[] {UserInfo.getUserEmail()} );

       //List of ccAddress
       String[] ccAddresses = new String[] {UserInfo.getUserEmail()};
       // Assign the CC addresses
       mail.setCcAddresses(ccAddresses);

       // Here we can set the address that will be used when a recipient replies to the email
       mail.setReplyTo('kumarlovely0027@gmail.com');

       // Specify the name used as the display name.
       mail.setSenderDisplayName('From Server');

       // Set the subject line for your email address.
       mail.setSubject('Email To Send Attachments');

       // You can set this to true if you want to BCC yourself on the email
       mail.setBccSender(false);

       // You can specify your plain text here
       mail.setPlainTextBody('Sample Attachments goes here');
    
      String attName = 'Attachments\n';
      String body = 'Dear Friend';
      body += 'I confess this will come as a surprise to you.';
      body += 'I am John Alliston CEO of the Bank of Nigeria.';
      body += 'I write to request your cooperation in this ';
      body += 'urgent matter as I need a foreign partner ';
      body += 'in the assistance of transferring $47,110,000 ';
      body += 'to a US bank account. Please respond with ';
      body += 'your bank account # so I may deposit these funds.';
    Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
         efa.setFileName(attName);
         efa.setBody(Blob.valueOf(body));
    // Here I am accessing current user email id to whom we are sending email
 
 // Attach file using setFileAttachments function
 mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});

       //Specify any html - for example this will display a link in the email
       mail.setHtmlBody('Your Link <a href=https://www.salesforce.com/>click here.</a>');

       // Sends the email
     Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
    System.debug('Successfully sent to : '+mail);
   }
}