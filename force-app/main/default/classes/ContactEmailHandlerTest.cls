@isTest
public class ContactEmailHandlerTest {

    @isTest
    public static void setup(){
        
        Test.startTest();
       Messaging.InboundEmail email = new Messaging.InboundEmail() ;
       Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        email.fromAddress = 'someaddress@email.com';
        email.plainTextBody = 'email body';
        
        List<Contact> contactList = new List<Contact>();
        Contact con = new Contact();
        if((con.lastName != null)
           && (con.Email != null)
           && (con.Phone != null)
           && (con.AccountId != null)){
        con.LastName = 'test';
        con.Email ='test' ;
        con.Phone = 'test';
        con.AccountId = 'test';
        contactList.add(con);
           }
        insert contactList;
       
        System.assertEquals(con.lastName, email.plainTextBody.subStringAfter('lastName:') );
        System.assertEquals(con.Email, email.plainTextBody.subStringAfter('Email:') );
        System.assertEquals(con.Phone, email.plainTextBody.subStringAfter('Phone:') );
        System.assertEquals(con.AccountId, email.plainTextBody.subStringAfter('AccountId:') );
    }
}