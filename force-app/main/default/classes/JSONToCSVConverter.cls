public class JSONToCSVConverter {
    
    public static String convertJSONToCSV(String jsonString) {
        
        // Deserialize the JSON string into a list of maps
       //Map<String,Object> dataMap = (Map<String,Object>) JSON.deserializeUntyped(jsonString);
        // Extract headers (keys) from the first object
       
       List<Object> dataList = (List<Object>) JSON.deserializeUntyped(jsonString);
       System.debug('dataMap'+dataList);
       Map<String,Object> dataMap1 = new Map<String,Object>();
        Set<String> headers = new Set<String>();
        for(Object obj: dataList){
            
            dataMap1 = (Map<String,Object>)obj;

            for(String header :dataMap1.keySet()) {  
                headers.add(header);
           }
        }
        System.debug('dataMap1'+dataMap1);
        
        
        System.debug('String'+headers);
        String csvString = '';
        csvString += String.join(new List<String>(headers), ',') + '\n';
        
            Map<String,List<String>> valMap = new Map<String,List<String>>();
            List<String> values = new List<String>();
            for (String header : headers) {
                if(!valMap.containsKey(header)){
                    values.add(String.valueOf(dataMap1.get(header)));
                    valMap.put(header,values);
                }
                
                valMap.get(header).add(String.valueOf(dataMap1.get(header)));
            }
            csvString += String.join(valMap.values(), ',') + '\n';
        	System.debug('values'+valMap);
        return csvString;
    }
    
    public static ContentVersion saveCSVToFile(String csvString, String fileName) {
        
        ContentVersion cv = new ContentVersion();
        cv.Title = fileName;
        cv.PathOnClient = fileName + '.csv';
        cv.VersionData = Blob.valueOf(csvString);
        cv.IsMajorVersion = true;
        insert cv;
        return cv;
    }
     public static void createContentDocumentLink(Id contentDocumentId) {
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = contentDocumentId;
        cdl.LinkedEntityId = '0015f00002L70LhAAJ';
        cdl.ShareType = 'V'; // Viewer permissions
        cdl.Visibility = 'AllUsers'; // Make it visible to all users
        insert cdl;
    }
    
    public static void convertAndSaveJSONToCSV(String jsonString, String fileName) {
        String csvString = convertJSONToCSV(jsonString);
        ContentVersion cv = saveCSVToFile(csvString, fileName);
        
        ContentVersion insertedCv = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id LIMIT 1];
        createContentDocumentLink(insertedCv.ContentDocumentId);
    }
    
}