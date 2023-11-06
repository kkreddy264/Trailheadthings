@IsTest
private class OpportunityDiscountTests {
  @IsTest
  static void testPositiveStubbingLowPriority() {
    // GIVEN
    AccountWrapper mockAccountWrapper = (AccountWrapper) Test.createStub(AccountWrapper.class, new AccountWrapperMock());
    OpportunityDiscount od = new OpportunityDiscount(mockAccountWrapper);
    // WHEN
    Test.startTest();
    Decimal result = od.getTotalDiscount();
    Test.stopTest();
    // THEN
    Assert.areEqual(.1, result, 'Expected to get .1');
  }
  @IsTest
  static void testPositiveStubbingHighPriority() {
    // GIVEN
    AccountWrapperMock.isHighPriorityReturn = true;
    AccountWrapper mockAccountWrapper = (AccountWrapper) Test.createStub(
      AccountWrapper.class, 
      new AccountWrapperMock()
    );
    OpportunityDiscount od = new OpportunityDiscount(mockAccountWrapper);
    // WHEN
    Test.startTest();
    Decimal result = od.getTotalDiscount();
    Test.stopTest();
    // THEN
    Assert.areEqual(.25, result, 'Expected to get .25');
  }
}