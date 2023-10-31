public class AccountUtility {

    public static void viewAnnualRevenue() {
         
            list<Account> accountsList = [SELECT Name, AnnualRevenue
                                          FROM Account];
            for(Account accObj:accountsList ){
                String acctRev = accObj.Name + ':' +accObj.AnnualRevenue;
                System.debug('acctRev'+acctRev);
            }
    }
}