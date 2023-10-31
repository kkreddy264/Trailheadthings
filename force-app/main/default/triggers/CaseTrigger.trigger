trigger CaseTrigger on Case (before insert) 
{
  CaseTriggerHandler.autoFillSAndP(trigger.new);
}