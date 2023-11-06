@IsTest
private class ExternalSearchTests {
  @IsTest
  static void testPositiveMocking() {

    HTTPMockFactory mock = new HTTPMockFactory(200,'OK','I found it!',new Map<String, String>());
    Test.setMock(HttpCalloutMock.class, mock);
    Test.startTest();
    String result = ExternalSearch.googleIt('epic search');
    Test.stopTest();
    Assert.areEqual('I found it!', result, 'Expected to receive mock response');
  }
  @isTest
  static void testNegativeMocking (){

    HTTPMockFactory mock = new HTTPMockFactory(500,'Server Error','I found Exception',new Map<String,String>());
    Test.setMock(HttpCalloutMock.class,mock);
    try{
        Test.startTest();
        String res = ExternalSearch.googleIt('epic search');
        Test.stopTest();
        Assert.fail('if response fail it should lead to exception');
    } catch(ExternalSearch.ExternalSearchException e){

        //Assert.isTrue(e.getMessage().equalsIgnoreCase('I found Exception'));
    }
  }
 }