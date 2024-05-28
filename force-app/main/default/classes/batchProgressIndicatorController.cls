public with sharing class batchProgressIndicatorController {
    @AuraEnabled
    public static List<AsyncApexJob> getJobDetails(String jobId){
        try {
            List<AsyncApexJob> asyncJobList = [SELECT Id, Status, JobItemsProcessed, TotalJobItems,
                                                NumberOfErrors FROM AsyncApexJob where Id =: jobId ];
            return asyncJobList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
   }

   @AuraEnabled
   public static string executeBatch(String className, Integer chunkSize){
        try {
            Type batchInstance = Type.forName(className);
            Id batchJobId = Database.executeBatch((Database.Batchable<sObject>)batchInstance.newInstance(), chunkSize);
            return batchJobId;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
   }
}