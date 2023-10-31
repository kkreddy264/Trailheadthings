trigger UpdateOpptyPrimaryContact on OpportunityContactRoleChangeEvent (after insert) {
    set<id> ocrIDs = new set<id>();
    
    for(OpportunityContactRoleChangeEvent e : trigger.new){
        EventBus.ChangeEventHeader changeEventHeader = e.ChangeEventHeader;
        //Checking if the if the record is created or updated
        if(changeEventHeader.changetype == 'CREATE' || changeEventHeader.changetype == 'UPDATE'){
            if(changeEventHeader.getRecordIds().size()==1)
            System.debug('ocr>>>>>>>>>>.>>>>>>>>>>');
                ocrIDs.add(changeEventHeader.getRecordIds()[0]);
        }
        
    }
    
    if(ocrIDs.size()>0) //Call the Handler class method and pass the OpportunityContactRole IDs
    {
        UpdateOpptyPrimaryContactHandler.setPrimaryContact(ocrIDs);
    }
        
}