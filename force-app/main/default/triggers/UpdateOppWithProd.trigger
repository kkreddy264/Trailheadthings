trigger UpdateOppWithProd on OpportunityLineItem (after insert, after update, after delete) {


    set<Id> oppIds = new set<Id>();
    for(OpportunityLineItem pro:Trigger.new==null? Trigger.old: Trigger.new) {

        oppIds.add(pro.OpportunityId);
    }
    UpdateOppWithProductHandler.updateOpportunityProdList(oppIds);
}