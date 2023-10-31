public class WorkingOnList {
    
    public static void functions(){
        List<String>  listNames = new List<String>();
        listNames.add(' Ranjith ');
        listNames.add(' Satish ');
        listNames.add(' David ');
        listNames.add(' Swetha ');
        listNames.add(' David ');
        listNames.add(' Ranjith ');
        listNames.add(' Vinesh ');
        //Display the above list in developer console’s log
        System.debug(listNames);
        listNames.sort();
        System.debug(listNames);
        listNames.remove(1); //index always starts with zero
        System.debug('After an element in index 2 is removed : ' + listNames);
        System.debug('After removing the index 2 element the second element is : ' + listNames.get(2));
        
        //Here we are adding the elements from above created list to the new list
        List<String> empNames = new list<String>();//new list 'empNames'
        
        empNames.add('Ranjith');
        empNames.add('Uma');
        empNames.add('Mohan');
        empNames.add('Uma');
        empNames.add('Satish');
        empNames.addAll(listNames);//Here adding elements old list(listNames) to new list(empNames)
        System.debug('The final empNames : ' + empNames);
        List<Contact> conList = new List<Contact>();
        for(string s: empNames){
            Contact con = new Contact();
            con.lastName = s;
            conList.add(con);
                }
        insert conList;
  
        
    }
    public static void objectFunctions(){
        
        List<account> accList = new List<account>();
        
        account a1 = new account();
        a1.name = 'CTS';
        a1.phone = '123';
        a1.industry = 'energy';
        a1.annualRevenue = 500000;
        
        accList.add(a1);  //add element (account record) into a list of similar type
        
        account a2 = new account();
        a2.name = 'TCS';
        a2.phone = '335';
        a2.industry = 'Apparel';
        a2.annualRevenue = 450000;
        
        accList.add(a2);
        
        account a3 = new account();
        a3.name = 'Reynolds';
        a3.phone = '434';
        a3.industry = 'Apparel';
        a3.annualRevenue = 320000;
        
        accList.add(a3);
        insert accList;
        system.debug('list of account records ' + accList);
        
        List<Contact> conList = new List<Contact> ();
        
        Contact c1 = new Contact();
        c1.lastName = 'Krishnan';
        c1.firstName='Ranjith';
        c1.accountID=a1.id; //to add contact for the above account a1
        conList.add(c1);
        insert conList;
        system.debug('list of contact records ' + conList);
        system.debug('list of account records ' + accList);
        
        List<account> myAccount = [SELECT Id,Name
                                   FROM account
                                   WHERE Id  =: accList ];
        
        List<String> accNames = new List<String>();
        for(account everyAccount : myAccount){
            
            accNames.add(everyAccount.Name);
        }
                                               
        System.debug('list of account names: ' + accNames); 
        
       
    }
}