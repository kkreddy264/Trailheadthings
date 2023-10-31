public class LeadTriggerHandler 
{
    // Lead is created with LeadSource as Web then give rating as cold otherwise hot.
  public static void autoFillRating()
    {
        /*for(Lead ld : (List<Lead>) trigger.new)
        {
            if(ld.LeadSource != null)
            {
                if(ld.LeadSource == 'Web')
                {
                    ld.Rating = 'Cold';
                }
                else
                {
                    ld.Rating = 'Hot';
                }
            }
        }*/
    }
    // lead is created or updated then check if the email of lead is already there in existing contacts. 
    // If email already exist then throw error.
    public static void addEmailError(List<Lead> ldList)
    {
        for(Lead ld : ldList)
        {
           /* for(Contact con : [Select Email From Contact])
            {
                if(ld.Email != null && con.Email != null)
                {
                    if(ld.Email == con.Email)
                    {
                        ld.Email.addError('This Email is already in Use.');
                    }
                }
            }
        }*/
    }
  }
    // Lead is created then Account and Contact has to be created.
    public static void ldNewAccAndCon(List<Lead> ldList)
    {
        List<Contact> conList = new List<Contact>();
        /*for(Lead ld : ldList)
        {
            for(Contact c : [Select Email, Phone From Contact])
            {
                if(ld.Email != null && ld.Phone != null)
              {
                  if(c.Email != null && c.Email != null)
                    {
                        if(ld.Email == c.Email && ld.Phone == c.Phone)
                      {
                          c.LastName = ld.LastName;
                            c.FirstName = ld.FirstName;
                            conList.add(c);
                      }
                    }
              }
            }
        }*/
        update conList;
    }
}