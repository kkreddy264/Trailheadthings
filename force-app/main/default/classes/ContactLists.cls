global with sharing class ContactLists implements Site.UrlRewriter {
// Variable to represent the friendly URLs for Page
   String contact_information = '/displayContacts/';
// Variable to represent the custom Visualforce page that displays the page information
   String contact_information_vf_page = '/displayContacts?id=';
//The first global method for mapping external URL to an internal one
    global PageReference mapRequestUrl(PageReference myFriendlyUrl){
        String url = myFriendlyUrl.getUrl();

        if(url.startsWith(contact_information)){
                        String name = url.substring(contact_information.length(), url.length());

            //Select id of the page that maps the name from the URL
            Contact con = [SELECT Id FROM Contact WHERE Name =: name LIMIT 1];
          //construct a new page reference in the form of mycontact visualforce page
            return new PageReference(contact_information_vf_page + con.id);
        }
        return null;
    }
    //The second global method maps the internal ids to URLs
    global List<PageReference> generateUrlFor(List<PageReference> mySalesforceUrls)
        {
  //List of pages to return after all links have been evaluated.
       List<PageReference> myFriendlyUrls = new List<PageReference>();
       List<id> accIds = new List<id>();
      for(PageReference mySalesforceUrl : mySalesforceUrls){
     //get the URL of the page
       String url = mySalesforceUrl.getUrl();
    //if this look like a page that need to be mapped, transform it
      if(url.startsWith(contact_information_vf_page)){
//Extract id from the query parameter       
String id= url.substring(contact_information_vf_page.length(),
                        url.length());
                        accIds.add(id);
            }
        }
//Query the name of the contact to put into URL
    List <contact> contacts= [SELECT Name FROM contact WHERE Id IN :accIds];
    Integer counter = 0;
    String a = ((contacts.get(counter).name)+'custom');
     for(PageReference mySalesforceUrl : mySalesforceUrls) {
   // Get the URL of the page.
      String url = mySalesforceUrl.getUrl();
    if(url.startsWith(contact_information_vf_page)){
         myFriendlyUrls.add(new PageReference(contact_information + a ));
         counter++;
       } else {
      myFriendlyUrls.add(mySalesforceUrl);
       }
    }
    return myFriendlyUrls;
  
  }
}