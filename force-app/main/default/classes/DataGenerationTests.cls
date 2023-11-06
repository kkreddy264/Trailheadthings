@IsTest
private class DataGenerationTests {
  @IsTest
  static void testBruteForceAccountCreation() {
        // GIVEN
        List<Account> accList;
        List<Contact> conList;
        TestFactory.generateAccountWithContacts(5);
        // WHEN
        Test.startTest();
        accList = [SELECT Id FROM Account];
        conList = [SELECT Id FROM Contact];
        Test.stopTest();
        // THEN
        Assert.isTrue(accList.size() > 0, 'Was expecting to find at least one account');
        Assert.areEqual(5,conList.size(),'Was expecting to find 5 contacts');
  }
}