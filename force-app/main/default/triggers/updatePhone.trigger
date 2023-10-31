trigger updatePhone on contact(after insert,after update)
{
   /* List<Account> acc = new List<Account>();
    
    for(Contact conObj : Trigger.New)
    {
        if(conObj.phone != null && conObj.AccountId != null){
      		List<Account> accObj = [SELECT Id, Phone 
                   FROM Account WHERE Id =:conObj.AccountId];
            if(!accObj.isEmpty()){
                   accObj[0].phone = conObj.phone;
                  acc.add(accObj[0]);
            }
        }
    }
    update acc;*/
}