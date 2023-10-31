public class UpdateOpptyPrimaryContactHandler {
    
    public static void setPrimaryContact(set<id> ocrIDs){
        System.debug('id'+ocrIDs);
        Opportunity[] oppsToUpdate = new Opportunity[]{};
        list<OpportunityContactRole> ocRoles = new list<OpportunityContactRole>([select id,contactId,OpportunityId,IsPrimary 
                                                                                    from OpportunityContactRole
                                                                                    where id in :ocrIDs ORDER BY IsPrimary DESC
                                                                                   ]);
        /*
         * Logic to check if the Opportunity has a primary contact role record or not, and 
         * accordingly set the Primary_Contact__c field to Contact's Id or as NULL.
         */
        
        set<id> oppIDs = new set<id>(); 
        for(OpportunityContactRole ocr: ocRoles){
            System.debug('ocr>>>>>>>>>>.'+ocr);
            if(ocr.IsPrimary){
                System.debug('ocr>>>>>>>>>>.ig');
                oppsToUpdate.add(new opportunity(id = ocr.OpportunityId, Primary_Contact__c=ocr.ContactId));
                oppIDs.add(ocr.OpportunityId);
               
            }
            else if(!oppIDs.contains(ocr.OpportunityId)){
                System.debug('ocr>>>>>>>>>>.asdf');
                oppsToUpdate.add(new opportunity(id = ocr.OpportunityId, Primary_Contact__c=null));
                oppIDs.add(ocr.OpportunityId);
            }
        }
        System.debug('update>>>> '+oppsToUpdate);
            
        if(oppsToUpdate.size()>0)
            update oppsToUpdate;
    }
}