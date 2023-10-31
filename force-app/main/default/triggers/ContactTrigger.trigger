trigger ContactTrigger on Contact (after INSERT,after UPDATE,before DELETE) {

    Set<Id> accId = new Set<Id>();
    List<Messaging.singleEmailMessage> mails =  new List<Messaging.singleEmailMessage>();
    
    if((Trigger.isAfter 
        && (Trigger.isInsert 
        || Trigger.isUpdate)
       )
     // ||(Trigger.isbefore 
        // && Trigger.isDelete)
      ){
        for(Contact con : Trigger.new){
            accId.add(con.AccountId);
        }
    }
   /* if(!accId.isEmpty()){
       ContactTriggerHandler.chekAndSendNotification(accId);
    }*/

    if((Trigger.isAfter 
        && Trigger.isUpdate)){

        ContactTriggerHandler.contactFieldUpdate(trigger.new,trigger.oldMap);
    }
}