@isTest
public with sharing class CalculatorTests {
    @isTest
    public static void testDivideByZero() {

        Integer numerator = 5;
        Integer denominator = 0;
        try{
        Test.startTest();
        Calculator.divide(numerator,denominator);
        Test.stopTest();
        Assert.fail('An exception should have been thrown');
        }catch(Calculator.CalculatorException e){
            Assert.isTrue(e.getMessage().equalsIgnoreCase('You still can\'t divide by zero'));
        }
        
    }
    @isTest
    public static void testDivideByZero1() {

        Integer numerator = 5;
        Integer denominator = 6;
        Decimal returnValue;
        try{
            Test.startTest();
            returnValue = Calculator.divide(numerator,denominator);
            Test.stopTest();
            Assert.fail('An exception should have been thrown');
            }catch(Calculator.CalculatorException e){
                Assert.isTrue(e.getMessage().equalsIgnoreCase('Division returned a negative value.' + returnValue));
            }
    }
}