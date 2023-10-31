trigger LeadTrigger on Lead (before insert, before update) 
{
  LeadTriggerHandler.autoFillRating();
  if(Trigger.isInsert || Trigger.isUpdate)
    {
        //LeadTriggerHandler.addEmailError(trigger.new);
        //LeadTriggerHandler.ldNewAccAndCon(trigger.new);
    }
}