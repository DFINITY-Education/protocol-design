import HashMap "mo:base/HashMap";

import Common "./common";
import Types "./types";

module {

  public func accountExistsAndGetBalance(entries: Types.AccountEntries, account: Principal) : async (Types.Status, ?Types.Account) {
    switch (entries.get(account)) {
      case (?account) (#Success, ?account);
      case _ (#AccountError, null);
    }
  };

  // TODO: Implement me.
  public func hasPermission(caller: Principal, account_owner: Principal, amount: Nat) : async Bool {
    return true;
  };

  // TODO: Implement me.
  public func hasFunds(caller: Principal, amount: Nat, balance: Nat) : async Bool {
    return true;
  };

  // TODO: Implement me.
  func hasAllowance(caller: Principal, account_owner: Principal) : async Bool {
    return true;
  };

}