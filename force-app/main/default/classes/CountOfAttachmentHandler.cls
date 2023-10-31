/**
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* appex Class for CountOfAttachmentHandler
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Kiran Kumar       <kiran.kumar@raagvitech.com>
* @modifiedBy     Kiran Kumar       <kiran.kumar@raagvitech.com>
* @maintainedBy   Kiran Kumar       <kiran.kumar@raagvitech.com>
* @version        1.0
* @created        2021-12-01
* @modified
* @systemLayer    CountOfAttachmentHandler
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public with sharing class CountOfAttachmentHandler {
    /** 
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description updating the fields on Account
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param     attIds
* @void      CountOfAttachments
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
    public static voId CountOfAttachments(set<Id> attIds) {

        Map<Id,List<Attachment>> parent = new Map<Id,List<Attachment>>();
        List<Attachment> attObj = new List<Attachment>();
           Map<Id,Opportunity> testmap = new Map<Id,Opportunity>([SELECT Id,Count_Of_Attachments__c 
                                                                  FROM Opportunity 
                                                                  WHERE Id IN: attIds]);

           attObj = [SELECT Id,parentId 
                     FROM Attachment
                     WHERE parentId IN :testmap.keyset()];
           
           for(Attachment at : attObj){
               List<Attachment> llist = new List<Attachment>();
               if(parent.get(at.parentId) == null){
                   llist = new List<Attachment>();
                   llist.add(at);
                   parent.put(at.parentId, llist);
               }else if(parent.get(at.parentId) != null){
                   llist = parent.get(at.parentId);
                   llist.add(at);
                   parent.put(at.parentId,llist);
               }
           }
           
           for(Id i : parent.keyset()){
                testmap.get(i).Count_Of_Attachments__c = parent.get(i).size();               
           }
           update testmap.values();
           System.Debug(testmap.values());
    }
}