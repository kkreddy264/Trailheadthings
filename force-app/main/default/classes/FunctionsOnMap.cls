public with sharing class FunctionsOnMap {
public void FunctionsOnMap() {

Account a = new Account(
Name='Acme', 
BillingCity='New York');
insert a;

Map<Integer, Account> map1 = new Map<Integer, Account> {};
map1.put(1, a);

Map<Integer, Account> map2 = map1.clone();
map1.get(1).BillingCity = 
'San Francisco';

System.assertEquals(
'San Francisco',
map1.get(1).BillingCity);

System.assertEquals(
'San Francisco',
map2.get(1).BillingCity);

/*Map<Integer, Account> map2 = map1.deepClone();

// Update the first entry of map1
map1.get(1).BillingCity = 'San Francisco';
// Verify that the BillingCity is updated in map1 but not in map2
System.assertEquals('San Francisco', map1.get(1).BillingCity);
System.assertEquals('New York', map2.get(1).BillingCity);*/

Map<String, String> colorCodes = new Map<String, String>();

colorCodes.put('Red', 'FF0000');
colorCodes.put('Blue', '0000A0');

Boolean contains = colorCodes.containsKey('Blue');
System.assertEquals(true, contains);


}
}