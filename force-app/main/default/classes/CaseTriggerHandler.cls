public class CaseTriggerHandler {

    //public static final Set<String> ORIGIN_SET = new Set<String>{'Email','Phone','Web'}
    //case is created with origin as email then set status as new and Priority as Medium.
  public static void autoFillSAndP(List<Case> caseList)
    {
        for(Case cs : caseList)
        {
            if(cs.Origin != null && cs.Origin == 'Email')
            {
                cs.Status = 'New';
                cs.Priority = 'Medium';
            }
        }
        /*for(Case cs : caseList)
        {
            if(cs.Origin != null)
            {
                if(ORIGIN_SET.contains(cs.Origin))
                cs.Status = 'New';
                cs.Priority = 'Medium';
            }
        }*/
    }
}