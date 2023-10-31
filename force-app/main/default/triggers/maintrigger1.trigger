trigger maintrigger1 on Contact (after insert) {
    Set<id> conIdSet=new Set<id>();
    for(Contact con:trigger.new){
        if(con.email!=Null){
            conIdSet.add(con.id);
        }
    }
    if(conIdSet.size() > 0){
        callWebserviceClass.getConList(conIdSet); // Calling apex class method
    }
}