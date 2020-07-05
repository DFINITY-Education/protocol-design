import Debug "mo:base/Debug";
import HashMap "mo:base/HashMap";
import Prelude "mo:base/Prelude";

import Common "./Common";
import Types "./Types";

module {

  // TODO: Is there a way to refer to actor-scopes vars from module scope?

  // TODO: Implement me.
  public func hasPermission(entries: Types.AccountEntries, payee: Principal, account_owner: Principal) : async (Bool) {
    Prelude.nyi();
    return true;
  };

  // TODO: Implement me.
  func getAllowance(from: Principal, to: Principal) : async (Bool) {
    Prelude.nyi();
    return true;
  };

}