import HashMap "mo:base/HashMap";
import List "mo:base/List";

module {

  public type Error = {
    #accountNotFound;
    #allowanceDiscrepancy;
    #insufficientBalance;
    #noPermission;
  };

  public type UserType = {
    #super;
    #user;
  };

  public type AccountEntries = HashMap.HashMap<Principal, Account>;

  public type Account = {
    var balance: Nat;
    var txns: List.List<Txn>;
    var allowances: HashMap.HashMap<Principal, Nat>;
    var lockedFunds: Nat;
  };

  public type Txn = {
    counterparty: Principal;
    amount: Int;
  };

};
