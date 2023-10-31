trigger AccountAddressTrigger on Account (before insert, before update) {
    
    List<Account> accList = new List<Account>();
    if((Trigger.isBefore)
       && (Trigger.isInsert
           || Trigger.isUpdate)){
               
               for(Account accObj : Trigger.new){
                   
                   if(accObj.Match_Billing_Address__c){
                   	//accList.add(accObj);
                   	accObj.ShippingPostalCode = accObj.BillingPostalCode;
               }
           }
    //AccountAddressTriggerHandler.matchAddress(accList);

}
}