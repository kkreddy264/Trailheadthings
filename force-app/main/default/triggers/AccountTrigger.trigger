trigger AccountTrigger on Account (before update) {

    AccountTriggerHandler.getAccType((List<Account>)Trigger.new);
}