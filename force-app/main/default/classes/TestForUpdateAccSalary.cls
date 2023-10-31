@isTest
public class TestForUpdateAccSalary {
@isTest
    public static void testUpdateAccField(){
        List<ID> accID = new List<ID>();
        Map<ID,Account> accountMap = new Map<ID,Account>();
        Account accObj=new Account();
        accObj.Name='test1';
        accObj.Total_Salary__c=0;
        insert accObj;
        accID.add(accObj.ID);
        
        Contact conObj = new Contact();
        conObj.LastName = 'test';
        conObj.AccountID = accObj.ID;
        conObj.Salary__c = 50000;
        insert conObj;
        accID.add(conObj.AccountID);
        accountMap.put(conObj.AccountID,accObj);
       
        Test.startTest();
        UpdationOnAccount.accSalaryUpdate(accID);
        for(Contact ConObj1 : [SELECT ID, AccountID, Salary__c 
                              FROM Contact 
                              WHERE AccountID IN :accID]){
            accountMap.get(ConObj1.AccountID).Total_Salary__c = ConObj1.Salary__c;
        }
        Test.stopTest();
        System.assertEquals(accountMap.get(ConObj.AccountID).Total_Salary__c, ConObj.Salary__c);
    }
    @isTest
    public static void testForIsDelete(){
        List<ID> accID = new List<ID>();
        Map<ID,Account> accountMap = new Map<ID,Account>();
        Account accObj=new Account();
        accObj.Name='test1';
        accObj.Total_Salary__c=0;
        insert accObj;
        accID.add(accObj.ID);
        
        Contact conObj = new Contact();
        conObj.LastName = 'test';
        conObj.AccountID = accObj.ID;
        conObj.Salary__c = 50000;
        insert conObj;
        accID.add(conObj.AccountID);
        accountMap.put(conObj.AccountID,accObj);
        
        Test.startTest();
        UpdationOnAccount.accSalaryUpdate(accID);
        for(Contact ConObj1 : [SELECT ID, AccountID, Salary__c 
                              FROM Contact 
                              WHERE AccountID IN :accID]){
            accountMap.get(ConObj1.AccountID).Total_Salary__c = ConObj1.Salary__c;
        }
        delete conObj;
        Test.stopTest();
        System.assertEquals(accountMap.get(ConObj.AccountID).Total_Salary__c, ConObj.Salary__c);
    }
    
}