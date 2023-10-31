public with sharing class UpdateOppWithProductHandler {

    public static void updateOpportunityProdList(set<Id> oppIds){
        System.debug('listId '+oppIds);
        List<Opportunity> oppUpdate = new List <Opportunity>();
        for(Opportunity opp: [Select Id, Name, List_of_Products__c,(Select Id, Name from OpportunityLineItems) from Opportunity where Id IN:oppIds]) {
           System.debug('list'+opp);
            Opportunity oppObj = new Opportunity();
            oppObj.Id = opp.Id;
            System.debug('list1'+oppObj.Id);
            String[] productNames = new String[0];
            for(OpportunityLineItem item: opp.OpportunityLineItems) {
                productNames.add(item.Name);
            }
            oppObj.List_of_Products__c = opp.OpportunityLineItems.size();
            oppObj.Name = opp.Name;
            oppUpdate.add(oppObj);
        }
        Update oppUpdate;
    }
}