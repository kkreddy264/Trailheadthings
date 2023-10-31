global class LeadProcessor implements Database.Batchable<Sobject> 
{
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        
        return Database.getQueryLocator([SELECT LeadSource FROM Lead]);
    }
   
    global void execute(Database.BatchableContext bc, List<Lead> scope){
        
        for(Lead leads:scope){
            
           leads.LeadSource = 'DreamForce';
        }
        
        update scope;
        System.debug('scpe>>>'+ scope);
    }
    
     global void finish(Database.BatchableContext bc){ 
     }    
}