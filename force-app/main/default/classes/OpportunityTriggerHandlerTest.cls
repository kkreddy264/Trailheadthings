@isTest
    public class OpportunityTriggerHandlerTest {
    
        @isTest
        static void oppTestMethod1(){
            List<Account> accList = new List<Account>();
            List<Opportunity> oppList = new List<Opportunity>();
            List<Task> taskList = new List<Task>();
            
            Account accObj= new Account();
            accObj.Name='Test12';
            accList.add(accObj);
            Insert accList;
            
            Opportunity oppObj = new Opportunity();
            oppObj.AccountId = accObj.Id;
            oppObj.Name = 'Tester1';
            oppObj.StageName = 'test1, test2, test3, test4';
            oppObj.CloseDate= Date.today()+1;
            oppObj.Discount_Percentage__c=10;
            oppList.add(oppObj);
            Insert oppList;
            
            Task taskObj = new Task();
            taskObj.whatId = oppObj.Id;
            taskObj.Subject = 'create a task';
            taskList.add(taskObj);
            if(taskList.size() >= 0){
                
                insert taskList;
            }
               
        }
        
        @isTest
        static void oppTestMethod2(){
            set<Id> accIds = new set<Id>();
            List<Account> accList = new List<Account>();
            List<Opportunity> oppList = new List<Opportunity>();
            List<Task> taskList = new List<Task>();
            
            Account accObj= new Account();
            accObj.Name='Test12';
            Insert accObj;
            //accList.add(accObj);
            
            Opportunity oppObj = new Opportunity();
            oppObj.AccountId = accObj.Id;
            oppObj.Name = 'Tester1';
            oppObj.StageName = 'test1 || test2 || test3 || test4';
            oppObj.CloseDate= Date.today()+1;
            oppObj.Discount_Percentage__c=10;
            Insert oppObj;
            //oppList.add(oppObj);
            accIds.add(oppObj.AccountId);
            
            
            
            Test.startTest();
            List<Opportunity> oppList1 =[SELECT Id, AccountId, StageName, Account.Type 
                                                                FROM Opportunity 
                                                                WHERE AccountId =:accIds];
            for(Opportunity oppObj1:oppList)  {
            if(oppObj1.StageName == 'test1' 
                    || oppObj1.StageName == 'test2' 
                    || oppObj1.StageName == 'test3'
                    || oppObj1.StageName == 'test4'){
              
            oppObj1.Account.type ='Customer';
               }
            else{
                oppObj1.Account.type = 'Prospect';
            }
            accList.add(oppObj1.Account);    
        } 
         OpportunityTriggerHandler.updateOnAccountOfOpp(oppList);
            update accList;
            
            
            OpportunityTriggerHandler.updateAcc(accIds);
            List<Account> accList1 = [SELECT Id, TotalOpp__c 
                                 FROM Account 
                                 WHERE Id in :accIds];

        List<Opportunity> oppsList = [SELECT Id 
                                      FROM Opportunity 
                                      WHERE AccountId in :accIds];
                                      
        for(Account accObj1 : accList1){
            accObj1.TotalOpp__c= oppsList.size();
        }
        update accList1;   
            Test.stopTest();
            
        }
    }