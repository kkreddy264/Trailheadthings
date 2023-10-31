public class StringFunctionHandler {
    
    public void str_abbreviate(){
        
       /* String s1 = 'Salesforce is the #1 Cloud CRM and is an extremely flexible software. Salesforce is highly popular due to its simple User interfaces and high degree of customization. One important feature in CRM is “sending and receiving emails”. Salesforce offers the straight forward features to send/receive emails from within Salesforce CRM & track the interactions automatically. In case of bigger teams with complex needs, salesforce also offers methods to customize the email functionality as required. In this article I will show you 2 ways in which Salesforce email functionality can be customized. I will also explain with examples of how to create Salesforce records from email received from a client.';
        String s2 = s1.abbreviate(maxWidth);
        System.assertEquals(s1, s2);
        System.assertEquals(s1.length(), s2.length());
       System.debug(' plaintext : ' + s2);
       return s2;*/
     /*(String s = 'Company: "Salesforce.com"';
      String escapedStr = s.escapeJava();
      System.debug(' plaintext : ' + escapedStr ); 
        return escapedStr;)*/
        String myString1 = 'abcde';
       String myString2 = 'abcd';
   		System.debug('string : ' + myString1.compareTo(myString2));
        System.debug('string : ' + myString1.abbreviate(8));
        System.debug('string : ' + myString1.abbreviate(9,6));
        System.debug('string : ' + myString1.capitalize());
        System.debug('string : ' + myString1.center(9));
        System.debug('string : ' + myString1.center(9, '-'));
        System.debug('string : ' + myString1.charAt(2));
        System.debug('string : ' + myString1.codePointAt(3));
        System.debug('string : ' + myString1.codePointBefore(2));
        System.debug('string : ' + myString1.substring(0,1));
    }   
}