/**
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* appex Class for CountOfContentDocumentHandler
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Kiran Kumar       <kiran.kumar@raagvitech.com>
* @modifiedBy     Kiran Kumar       <kiran.kumar@raagvitech.com>
* @maintainedBy   Kiran Kumar       <kiran.kumar@raagvitech.com>
* @version        1.0
* @created        2021-12-01
* @modified
* @systemLayer    CountOfContentDocumentHandler
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public with sharing class CountOfContentDocumentHandler {
    
    public static voId CountOfContentDocuments(set<Id> attIds) {
/** 
* ───────────────────────────────────────────────────────────────────────────────────────────────────┐
* @description updating the fields on Account
* ───────────────────────────────────────────────────────────────────────────────────────────────────
* @param     attIds
* @void      CountOfContentDocuments
* ───────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
        Map<Id,List<ContentDocument>> parent = new Map<Id,List<ContentDocument>>();
        List<ContentDocument> attObj = new List<ContentDocument>();
           Map<Id,Opportunity> testmap = new Map<Id,Opportunity>([SELECT Id,Count_Of_Attachments__c 
                                                                  FROM Opportunity 
                                                                  WHERE Id IN: attIds]);

           attObj = [SELECT Id,parentId 
                     FROM ContentDocument
                     WHERE parentId IN :testmap.keyset()];
           
           for(ContentDocument at : attObj){
               List<ContentDocument> llist = new List<ContentDocument>();
               if(parent.get(at.parentId) == null){
                   llist = new List<ContentDocument>();
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