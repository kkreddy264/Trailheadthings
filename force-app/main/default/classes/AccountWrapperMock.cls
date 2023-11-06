@isTest
public class AccountWrapperMock implements System.StubProvider {
  public static Boolean isHighPriorityReturn = false;
  public Object handleMethodCall(
    Object stubbedObject,
    String stubbedMethodName,
    Type returnType,
    List<Type> listOfParamTypes,
    List<String> listOfParamNames,
    List<Object> listOfArgs
  ) {
    switch on stubbedMethodName {
      when 'getRoundedAvgPriceOfOpps' {
        return 1000.00;
      }
      when 'isHighPriority' {
        return isHighPriorityReturn;
      }
    }
    return 'catchall';
  }
}