trigger ContactTrigger1 on Contact (before insert, before update, before delete, after insert) 
{
    if(trigger.isDelete)
    {
       ContactTriggerHandler1.triggerMethod(Trigger.old);   
    }
    if(trigger.isInsert || trigger.isUpdate)
    {
        ContactTriggerHandler1.triggerMethod(Trigger.new);
        ContactTriggerHandler1.addErrorForName(trigger.new);
    }
   /* if(trigger.isBefore && trigger.isInsert)
    {
        ContactTriggerHandler1.autoFillMethod(trigger.new);
        ContactTriggerHandler1.addTestToName();
    }
    if(trigger.isAfter && trigger.isInsert)
    {
        Map<Id, Contact> conMap = trigger.newMap;
        ContactTriggerHandler1.newAccCreateMeth(conMap.keySet());
        ContactTriggerHandler1.cIdAppendToCName(conMap.keySet());
    }*/
}