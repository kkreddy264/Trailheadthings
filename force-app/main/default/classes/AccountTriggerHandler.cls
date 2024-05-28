public with sharing class AccountTriggerHandler extends TriggerHandler {

    public override void beforeInsert(){
        System.debug(LoggingLevel.INFO, 'In before insert');   
    }
    
}