trigger AccountTrigger on Account (before insert, before update, before delete) {
    new AccountTriggerHandler().run();
}