public class HierarchyController {
    //This method is for getting role hierarchy
    //you can create similar method for any other hierarchy
    @AuraEnabled
    public static hierarchyWrapper getAllRoleHirarchy(){
        List<UserRole> userRoleList = new List<UserRole>();
        userRoleList = [Select Id, Name, ParentRoleId from UserRole];
        return getAllHirarchy(userRoleList,'ParentRoleId');
    }
    
    //This is a generic method which returns a wrapper which holds map of parent and its child list
    @auraEnabled
    public static hierarchyWrapper getAllHirarchy(List<Sobject> recordList, String parentFieldApiName){
        Map<String,List<SObject>> mapofparentwithlistOfchild = new map<String, List<SObject>>();
        List<SObject> parentList = new List<SObject>();
        for(SObject record: recordList){
            if(record.get(parentFieldApiName) != null){
                if(mapofparentwithlistOfchild.containskey((String)record.get(parentFieldApiName))){
                    mapofparentwithlistOfchild.get((String)record.get(parentFieldApiName)).add(record);
                }else{
                    mapofparentwithlistOfchild.put((String)record.get(parentFieldApiName), new list<SObject>{record});
                }
            }else{
                parentList.add(record);
            }
        }
        hierarchyWrapper wrapper = new hierarchyWrapper();
        wrapper.superParentList = parentList;
        wrapper.parentMap = mapofparentwithlistOfchild;
        
        return wrapper;
    }
    @AuraEnabled
    public static hierarchyWrapper getAllAccountHirarchy(){
        List<Account> accountList = new List<Account>();
        accountList = [Select Id, Name, ParentId from Account];
        return getAllHirarchy(accountList,'ParentId');
    }
    
    public class hierarchyWrapper{
        @AuraEnabled public List<SObject> superParentList{get;set;}
        @AuraEnabled public Map<String,List<SObject>> parentMap{get;set;}
    }
}