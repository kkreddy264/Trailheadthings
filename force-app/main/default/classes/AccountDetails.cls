public with sharing class AccountDetails {
    @AuraEnabled(cacheable = true)
    public static List<Account> getAccountsData(){

        return[SELECT Id, Name, Phone, AccountNumber 
               FROM Account];
    }
    
    public class FieldSetField
{
    @AuraEnabled
    public Boolean dbRequired;
    @AuraEnabled
    public String apiName;
    @AuraEnabled
    public String label;
    @AuraEnabled
    public Boolean required;
    @AuraEnabled
    public String type;

    public FieldSetField(Schema.FieldSetMember fieldSetMember)
    {
        this.dbRequired = fieldSetMember.dbRequired;
        this.apiName = fieldSetMember.fieldPath;
        this.label = fieldSetMember.label;
        this.required = fieldSetMember.required;
        this.type = String.valueOf(fieldSetMember.getType());
    }
}

@AuraEnabled (cacheable=true)
    public static String getFieldsAndRecords(String strObjectApiName, String strfieldSetName){

        System.debug('apiname>>>'+strObjectApiName);
        System.debug('apiname1>>>'+strfieldSetName);
        Map<String, String> returnMap = new Map<String,String>();
        if(!String.isEmpty(strObjectApiName) && !String.isEmpty(strfieldSetName)){
            //get fields from FieldSet
            SObject sObj = (SObject)(Type.forName('Schema.'+ strObjectApiName).newInstance());
            List<Schema.FieldSetMember> lstFSMember = Schema.getGlobalDescribe().get(strObjectApiName).
                    getDescribe().FieldSets.getMap().get(strfieldSetName).getFields();

	    //prepare SOQL query based on fieldAPIs	
	    String query = 'SELECT ';
	    for(Schema.FieldSetMember f : lstFSMember) {
	        query += f.getFieldPath() + ', ';
            //query += 'Id  FROM ' + strObjectApiName ;
            }
            query += 'Id FROM ' + strObjectApiName ;

            //Just in case criteria field not specified then it will return all records
            // if(!(String.isEmpty(criteriaField) && String.isEmpty(criteriaFieldValue))){
            //     query += ' WHERE ' + criteriaField + '=\'' + criteriaFieldValue + '\'';
            // }
                        
	    //execute query
             List<Account> lstRecords = Database.query(query);
             System.debug('rec>>>'+lstRecords);
            
             //prepare a map which will hold fieldList and recordList and return it
	     returnMap.put('FIELD_LIST', JSON.serialize(lstFSMember));
	     returnMap.put('RECORD_LIST', JSON.serialize(lstRecords));
	     return JSON.serialize(returnMap);
        }
        return null;
    }
}