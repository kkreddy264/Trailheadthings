/**
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* appex Trigger for CountOfAttachment
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Kiran Kumar       <kiran.kumar@raagvitech.com>
* @modifiedBy     Kiran Kumar       <kiran.kumar@raagvitech.com>
* @maintainedBy   Kiran Kumar       <kiran.kumar@raagvitech.com>
* @version        1.0
* @created        2021-12-01
* @modified
* @systemLayer    CountOfAttachment
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
trigger CountAttachment on Attachment (after insert, after update, after delete, after undelete) {

  set<Id> attIds = new set<Id>();
     
   if(Trigger.new<>null){
       for(Attachment c : Trigger.new){
           if(c.ParentId != null)
               attids.add(c.parentId);
       }
           
   }else if(Trigger.old != null){
       for(Attachment c:Trigger.old){
           if(c.ParentId<>null)      
               attids.add(Trigger.oldMap.get(c.Id).parentId);
       }
   }
   if(attIds.size()>0){
    CountOfAttachmentHandler.CountOfAttachments(attIds);
   }

}