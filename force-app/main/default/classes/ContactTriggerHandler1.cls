public class ContactTriggerHandler1 {

     public static void triggerMethod(List<Contact> conList)
    {
        Map<Id,Decimal> accountIdToAmountMap = new Map<Id,Decimal>();
        for(Contact eachContact : conList){
            if(eachContact.AccountId !=null
               && eachContact.Amount__c != null){
                   Decimal amount = eachContact.Amount__c;
                   if(accountIdToAmountMap.containsKey(eachContact.AccountId)){
                      amount += accountIdToAmountMap.get(eachContact.AccountId);
                   }
                   accountIdToAmountMap.put(eachContact.AccountId,amount);
               }
        }
        Set<Id> accountIds = accountIdToAmountMap.keySet();
        List<Account> resultToUpdate = new List<Account>();
        List<Account> accList = [SELECT Id, Total_Amount__c
                                 FROM Account
                                 WHERE Id IN :accountIds];
        if(accList != null)
        {
            for(Account acc : accList)
            {
                if(accountIdToAmountMap.containsKey(acc.Id))
                {
                    acc.Total_Amount__c = accountIdToAmountMap.get(acc.Id);
                    resultToUpdate.add(acc);
                }
            }
        }
        update resultToUpdate;
    }
    // If the name of the contact is similler to the Account Name then throw the Error msg.
    public static void addErrorForName(List<Contact> conList)
    {
        List<Account> accList = [Select Name From Account];
        for(Contact c : conList)
        {
            for(Account a : accList)
            {
                if(c.LastName == a.Name)
                {
                  c.LastName.addError('The name is already in use for Account');
                }
            }
        }
    }
    // AutoFill the phone and Email fields when empty while inserction.
    public static void autoFillMethod(List<Contact> conList)
    {
        for(Contact c : conList)
        {
            if(c.Phone == null && c.Email == null)
            {
               c.Phone = '9500980060';
                c.Email = 'gmail@gmail.com';
            }
            else if(c.Email == null)
            {
                c.Email = 'gmail@gmail.com';
            }
            else if(c.Phone == null)
            {
                c.Phone = '9500980060';
            }
            else
            {
            }
        }
    }
    // Creating an Account while inserting the Contact and assign Account Id to contact accountId.
    public static void newAccCreateMeth(Set<Id> ids)
    {
        List<Account> accList = new List<Account>();
        List<Contact> conList = new List<Contact>();
        /*for(Contact c : [Select LastName, FirstName From Contact Where Id In :ids])
        {
            Account a = new Account();
            a.Name = c.FirstName+' '+c.LastName;
            accList.add(a);
        }
        Insert accList;
        for(Contact c : [Select LastName, FirstName, AccountId From Contact Where Id In :ids])
        {
            Account a = [Select Id From Account Where Name =: c.FirstName+' '+c.LastName];
            c.AccountId = a.Id;
            conList.add(c);
        }
        Update conList;*/
    }
    // Append the contact name to test while inserction.
    public static void addTestToName()
    {
        for(Contact c : (List<Contact>) Trigger.new)
        {
            c.LastName = 'Test '+c.LastName;
        }
    }
    // Trigger to Append Contact Id to Contact Name
    public static void cIdAppendToCName(Set<Id> conIds)
    {
        List<Contact> conList = new List<Contact>();
        for(Contact c : [Select Id, LastName From Contact Where Id IN :conIds])
        {
            c.LastName = c.LastName+'-'+c.Id;
            conList.add(c);
        }
        update conList;
    }
}