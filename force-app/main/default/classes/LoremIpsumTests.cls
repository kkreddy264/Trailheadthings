@IsTest
private class LoremIpsumTests {
  @IsTest
  static void thisIsAHorribleUnitTest() {
    String[] x = LoremIpsum.generate().split(' ');
    system.assert(x.size() > 1);
  }

  @IsTest
  static void thisIsAHorribleUnitTest1() {
    String[] x = LoremIpsum.generate1().split(' ');
    system.assert(x.size() > 1);
  }
  @IsTest
  static void thisIsAHorribleUnitTest2() {
    String[] x = LoremIpsum.generate2().split(' ');
    system.assert(x.size() > 1);
  }
  @IsTest
  static void thisIsAHorribleUnitTest3() {
    String[] x = LoremIpsum.generate3().split(' ');
    system.assert(x.size() > 1);
  }
  @IsTest
  static void thisIsAHorribleUnitTest4() {
    String[] x = LoremIpsum.generate4().split(' ');
    system.assert(x.size() > 1);
  }
}