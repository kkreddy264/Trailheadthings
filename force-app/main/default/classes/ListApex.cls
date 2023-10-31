public with sharing class ListApex {
    public void ListApex() {
        //add elements to list
        List<Integer> myList = new List<Integer>();
        myList.add(47);
        Integer myNumber = myList.get(0);
        //add elements to list with index
        List<Integer> myList1 = new Integer[6];
        myList1.add(0, 47);
        myList1.add(1, 52);
        //To check contains the value in a list
        List<String> myStrings = new List<String>{'a', 'b'};
        Boolean result = myStrings.contains('z');
        List<String> colors = new String[3];
        colors[0] = 'Red';
        colors[1] = 'Blue';
        colors[2] = 'Green';
        SObject sObj = Database.query('SELECT Id FROM Account LIMIT 1');
        System.debug('number'+myNumber);
        System.debug('type'+sObj.getSObjectType());
        System.debug('number'+myList1.hashCode());
        System.debug('number'+myStrings.indexOf('a'));
        System.debug('number'+myStrings.isEmpty());
        System.debug('number'+colors.remove(2));
        System.debug('number'+colors.size());
        System.debug('number'+colors.toString());

        Set<String> set1 = new Set<String>{'New York', 'Paris'};
        System.debug('number'+set1.toString());
        System.debug('number'+set1.contains('New York'));

        Map<Integer, String> m1 = new Map<Integer, String>();
        m1.put(1, 'First item');
        m1.put(2, 'Second item');
        System.debug('type'+m1.values());
        System.debug('number'+m1.hashCode());
        System.debug('number'+m1.get(1));
        System.debug('number'+m1.isEmpty());
        System.debug('number'+m1.remove(2));
        System.debug('number'+m1.size());
        System.debug('number'+m1.toString());
    }
}