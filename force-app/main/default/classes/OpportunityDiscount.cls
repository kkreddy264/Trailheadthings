public class OpportunityDiscount {
  AccountWrapper acct;

  public OpportunityDiscount(AccountWrapper acct) {
    this.acct = acct;
  }

  public Decimal getTotalDiscount() {
    if (this.acct.isHighPriority()) {
      return .25;
    } else {
      return .1;
    }
  }
}