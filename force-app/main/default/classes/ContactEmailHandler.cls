/**
* ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* handler Class for Contact Email 
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Kiran Kumar       <kiran.kumar@raagvitech.com>
* @modifiedBy     Kiran Kumar       <kiran.kumar@raagvitech.com>
* @maintainedBy   Kiran Kumar       <kiran.kumar@raagvitech.com>
* @version        52
* @created        2020-09-26
* @modified       
* @systemLayer    Contact Email Handler
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public class ContactEmailHandler implements Messaging.InboundEmailHandler {
    
    
    /**
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description check weather Email is Sent
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param    email
* @return   handleInboundEmail
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
*/
    
    public Messaging.InboundEmailResult  handleInboundEmail(Messaging.inboundEmail email, 
                                                            Messaging.InboundEnvelope env){
                                                                
                                                                
                                                                // Create an InboundEmailResult object for returning the result of the 
                                                                // Apex Email Service
                                                                Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
                                                                
                                                                List<Contact> contactList = new List<Contact>();
                                                                String myPlainText= '';
                                                                // Email plaintextbody and html body is not empty 
                                                                if((email.plainTextBody != null) && (email.htmlBody != null)) {
                                                                    
                                                                // Store the email plain text into the local variable 
                                                                myPlainText = email.plainTextBody; 
                                                                System.debug('plaintext:' + myPlainText);
                                                                
                                                                // here we are dividing the email.plaintextbody and storing the each details into a separate localvariable using stringfunctions
                                                                String n = myplaintext.substringAfter('lastName:');
                                                                System.debug('Name : ' + n);
                                                                Integer index = n.indexOf('\n');
                                                                String name = n.substring(0,index);
                                                                
                                                                String e = myplaintext.substringAfter('Email:');
                                                                System.debug('Email : ' + e);
                                                                Integer index1 = e.indexOf('\n');
                                                                String email1 = e.substring(0,index1);
                                                                
                                                                String ph = myplaintext.substringAfter('Phone:');
                                                                System.debug('Phone : ' + e);
                                                                Integer index2 = ph.indexOf('\n');
                                                                String phone = ph.substring(0,index2);
                                                                
                                                                String accId = myplaintext.substringAfter('AccountId:');
                                                                System.debug('AccountId : ' + accId);
                                                                Integer index3 = accId.indexOf('\n');
                                                                String accountId = accId.substring(0,index3);
                                                                    
                                                                  //created new contact and checking the contact fields should not be null
                                                                    Contact con = new Contact();
                                                                    if((con.lastName != null)
                                                                       && (con.Email != null)
                                                                       && (con.Phone != null)
                                                                       && (con.AccountId != null)){
                                                                        
                                                                        con.LastName = name;
                                                                        con.Email = email1;
                                                                        con.Phone = phone;
                                                                        con.AccountId = accountId;
                                                                        contactList.add(con);
                                                                    }
                                                                }
                                                                insert contactList;
                                                                return result;  
                                                                
                                                            }
    
    
}