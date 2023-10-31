public class FunctionsOnMap1 {
    
    
    public static void methods(){
        
        Account a = new Account(
            Name='Acme', 
            BillingCity='New York');
        
        Map<Integer, Account> map1 = new Map<Integer, Account> {};
            map1.put(1, a);
        
        Map<Integer, Account> map2 = map1.clone();
        map1.get(1).BillingCity = 
            'San Francisco';
        
        System.debug('Information of Account : ' + map1);       
        Map<String, String> colorCodes = new Map<String, String>();
        
        colorCodes.put('Red', 'FF0000');
        colorCodes.put('Blue', '0000A0');
        
        Boolean contains = colorCodes.containsKey('Blue');
        System.debug('Information : ' + contains);  
        Set <String> colorSet = new Set<String>();
        colorSet = colorCodes.keySet();
        System.debug('Information : ' + colorSet);
        
        List<Account> accts = new List<Account>();
        accts.add(new Account(Name='Account1'));
        accts.add(new Account(Name='Account2'));
        
        Map<Id, Account> m = new Map<Id, Account>();
        // Add all the records to the map.
        m.putAll(accts);
        System.debug('New Account :' +m);
        //remove the element from map
        String myColor = colorCodes.remove('Blue');
        String code2 = colorCodes.get('Blue');
        System.debug('remove the element :' +myColor);
        System.debug('After remove the element :' +code2);
        //Again i am adding the values for the map colorCodes
        colorCodes.put('Red', 'FF0000');
        colorCodes.put('Blue', '0000A0');
        Integer mSize = colorCodes.size();
        // Here In map duplicate values are not allowed so its showing the size is 2
        System.debug('Size of the map :' +mSize);
        Boolean empty = colorCodes.isEmpty();
        System.debug('Hash code :' +map1.hashcode());
    }
    public static void method1(){
        
        List<Account> accList = new List<Account>(); // Account[] is synonymous with List<Account>
        List<Contact> conList = new List<Contact>();
        Map<Id, List<Account>> userIdByAccListMap = new Map<Id, List<Account>>();
        Map<Id, Account> userIdByAccMap = new Map<Id, Account>();
        for(Account accObj : [SELECT Id, Name 
                              FROM Account]){
                                  
                                  accList.add(accObj);                       
                              }
        for(Account accObj : [SELECT Id, Name, CustomerPriority__c 
                              FROM Account
                              WHERE Name Like '%ki%']){
                                  
                                  userIdByAccMap.put(accObj.Id, accObj);                       
                              }
        for(Contact conObj : [SELECT Id, Name, accountId 
                              FROM Contact]){
                                  
                                  if(userIdByAccMap.containsKey(conObj.accountId)){
                                      
                                      conObj.CustomerPriority__c =  userIdByAccMap.get(conObj.accountId).CustomerPriority__c ;
                                      conList.add(conObj);
                                  }                   
                              }
        update conList;
        for(Account accObj : [SELECT Id, ownerId, Name 
                              FROM Account]){
                                  
                                  if(!userIdByAccListMap.containskey(accObj.ownerId)){
                                      userIdByAccListMap.put(accObj.ownerId, new List<Account>{});
                                  }
                                  userIdByAccListMap.get(accObj.ownerId).add(accObj);                       
                              }
        for(User usrObj : [SELECT Id, Name 
                           FROM User]){
                               
                               if(userIdByAccListMap.containskey(usrObj.Id)){
                                   
                                   userIdByAccListMap.get(usrObj.Id); 
                               }                       
                           }
        
        
        // Populate map from SOQL query
        Map<ID, Account> m = new Map<ID, Account>([SELECT Id, Name FROM Account LIMIT 10]);
        // After populating the map, iterate through the map entries
        for (ID idKey : m.keyset()) {
            Account a = m.get(idKey);
            System.debug(a);
        }
    }
}