@IsTest
private class AccountWrapperTests {
  @TestSetup
  static void loadTestData() {
    // GIVEN
    Account acct = new Account(Name = 'ACME');
    insert acct;
    Account accObj = new Account(Name = 'ACMEU');
    insert accObj;
    List<Opportunity> opps = TestFactory.generateOppsForAccount(acct.id, 1000000.00, 5);
    insert opps;
    List<Opportunity> oppObj = TestFactory.generateOppsForAccount(accObj.id, 1000.00, 5);
    insert oppObj;
  }
  @IsTest
  static void testPositiveRoundedAveragePrice() {
    // WHEN
    Account acct = [SELECT Id FROM Account LIMIT 1];
    AccountWrapper acctWrapper = new AccountWrapper(acct);
    // THEN
    Test.startTest();
    Assert.areEqual(
      acctWrapper.getRoundedAvgPriceOfOpps(),
      1000000.00,
      'Expected to get 1000000.00');
    Test.stopTest();
  }
  @IsTest
  static void isHighPriority(){

    Account acct = [SELECT Id FROM Account LIMIT 1];
    AccountWrapper wrapper = new AccountWrapper(acct);
    Decimal getRoundedAvgPriceOfOpps = wrapper.getRoundedAvgPriceOfOpps();
    Boolean value = wrapper.isHighPriority();
    Test.startTest();
    System.assertEquals(value,true,false);
    Test.stopTest();
  }
  @IsTest
  static void isHighPriority1(){

    Account acct = [SELECT Id FROM Account WHERE Name='ACMEU'];
    AccountWrapper wrapper = new AccountWrapper(acct);
    Decimal getRoundedAvgPriceOfOpps = wrapper.getRoundedAvgPriceOfOpps();
    Boolean value = wrapper.isHighPriority();
    Test.startTest();
    System.assertEquals(value,false,true);
    Test.stopTest();
  }
  @IsTest
  static void testNegativeAccountWrapperAvgPriceOfOpps() {
    
    Account acct = [SELECT Id FROM Account LIMIT 1];
    List<Opportunity> opps = [
      SELECT Amount
      FROM Opportunity
      WHERE accountId = :acct.Id
    ];
    for (Opportunity o : opps) {
      o.Amount = 0;
    }
    update opps;
    AccountWrapper acctWrapper = new AccountWrapper(acct);
    
    try {
      Test.startTest();
      acctWrapper.getRoundedAvgPriceOfOpps();
      Test.stopTest();
      Assert.fail('An exception should have been thrown');
    } catch (AccountWrapper.AWException e) {
      Assert.isTrue(
        e.getMessage().equalsIgnoreCase('no won opportunities'),
        'Exception message does not match: ' + e.getMessage()
      );
    }
  }
}