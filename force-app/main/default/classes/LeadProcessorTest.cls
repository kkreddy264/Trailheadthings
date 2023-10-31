@isTest
public class LeadProcessorTest {

    @isTest
    Public static void testMethod1(){
        
     List<Lead> lstLead = new List<Lead>();
        for(Integer i=0 ;i <200;i++)
        {
            Lead led = new Lead();
            led.FirstName ='FirstName';
            led.LastName ='LastName'+i+1;
            led.Company ='demo'+i+1;
            lstLead.add(led);
        }
        
        insert lstLead;
        
        Test.startTest();

            LeadProcessor obj = new LeadProcessor();
            DataBase.executeBatch(obj); 
            
        Test.stopTest();
    
    }
}