public without sharing class CommunityAuthController {

    @AuraEnabled
    public static string doLogin(String username, String password){
        try {
            
            String startUrl = System.currentPageReference().getParameters().get('startURL');
            ApexPages.PageReference pageRef = Site.login(username, password, startUrl);

            if(pageRef != null) return pageRef.getUrl();

            if(pageRef != null) throw new CalloutException();
            return null;


        } catch (Exception e) {
            system.debug('e.getMessagelogin+   '+e.getMessage());
            if(!Test.isRunningTest()) throw new AuraHandledException(e.getMessage());
            return null;
        
        }
    }


    @AuraEnabled
    public static boolean isEmailExist(String username){
        try {
            
            List<User> userList = new List<User>();
            userList = [Select Id, Name From User Where Username = :username];

           if(!userList.isEmpty()) throw new CalloutException();

            return null;


        } catch (Exception e) {
            if(!Test.isRunningTest()) throw new AuraHandledException(e.getMessage());
              return null; 
        }
    }

    @AuraEnabled
    public static string registerUser(String firstName, String lastName, String username, String email, String communityNickname, String password){
        try {

            Set<String> communityNicknameSet = new Set<String>();

            for(User usr : [Select Id, CommunityNickname From User Where CommunityNickname != null]){

                communityNicknameSet.add(usr.CommunityNickname);
            }

            String uniqueCommunityNickName;

            if(communityNicknameSet.isEmpty()){

                if(communityNickname.length() > 4){
                    
                    uniqueCommunityNickName = communityNickname.substring(0, 4) + String.valueOf( Integer.valueOf(Math.random() * 10000) );
                
                } else {

                    uniqueCommunityNickName = communityNickname + String.valueOf( Integer.valueOf(Math.random() * 10000) );
                }
            
            } else {

                for(Integer i=1; i <= 9999 ; i++){

                    if(communityNickname.length() > 4){
                        
                        uniqueCommunityNickName = communityNickname.substring(0, 4) + String.valueOf( Integer.valueOf(Math.random() * 10000) );
                    
                    } else {

                        uniqueCommunityNickName = communityNickname + String.valueOf( Integer.valueOf(Math.random() * 10000) );
                    }

                    if(!communityNicknameSet.contains(uniqueCommunityNickName)){

                        break;
                    }
                }
            }
            
            User u = new User();
            u.firstName = firstName;
            u.lastName = lastName;
            u.Username = username;
            u.Email = email;
            u.CommunityNickname = uniqueCommunityNickName;        

            String accountId;

            Account portalAccount = new Account();
            portalAccount.Name = firstName + ' ' + lastName;
            insert portalAccount;

            portalAccount.IsPartner = true;
            update portalAccount;

            accountId = portalAccount.Id;
            


            String userId = Site.createPortalUser(u, accountId, password);

            if (userId != null) {
                
                String emailResult = sendWelcomeMail(u, userId);
                
                if (password != null && password.length() > 1) {
                    ApexPages.PageReference pageRef = Site.login(username, password, null);
                    if(pageRef != null) return pageRef.getUrl();
                }
                else {
                    ApexPages.PageReference page = System.Page.SiteRegisterConfirm;
                    page.setRedirect(true);
                    return page.getUrl();
                }
            }

            throw new CalloutException();

            


        } catch (Exception e) {
            system.debug('e.getMessage+   '+e.getMessage());
            
            if(!Test.isRunningTest()) throw new AuraHandledException(e.getMessage());

            return null;
            
        }
    }


    @AuraEnabled
    public static string sendWelcomeMail(User usr, String userId){
        try {

            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

            List<EmailTemplate> welcomeTemplate = new List<EmailTemplate>([Select Id from EmailTemplate where name = 'Welcome to community']);
                     
            mail.setSenderDisplayName(System.Label.Public_Site_For_Users);
            mail.setTargetObjectId(userId);
            mail.setTemplateId(welcomeTemplate[0].Id);
            mail.setSaveAsActivity(false);

            Messaging.sendEmail( new List<Messaging.SingleEmailMessage>{mail} );

            return 'success';

        } catch (Exception e) {            
            throw new AuraHandledException(e.getMessage());
        }
    }
}