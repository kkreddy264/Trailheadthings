@isTest
public with sharing class MyDataGenerationTests {
    @TestSetup
    public static void MyDataGenerationTests(){
        
        List<sObject> testDataList = Test.loadData(Account.sObjectType,'otherAccountData');
        
    }
    public static void testLoadOtherAccountsFromStaticResource (){

        List<Account> accList;
        Test.startTest();
        accList  = [SELECT Id FROM Account];
        Test.stopTest();
        System.assert(accList.size()==15,'15 new accounts recognized');
    }
}