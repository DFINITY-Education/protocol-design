import HashMap "mo:base/HashMap";
import List "mo:base/List";

module {

  public type Status = { #Success; #AccountError; #BalanceError; };

  public type AccountEntries = HashMap.HashMap<Principal, Account>;
  public type AllowListEntries = HashMap.HashMap<Principal, AllowList>;
  public type AllowList = List.List<Allowance>;

  public type Account = {
    balance: Nat;
    txns: List.List<Principal>;
  };

  public type Allowance = {
    account: Principal;
    amount: Nat;
  };

  type Txn = {
    counterparty: Principal;
    amount: Int;
  };

}