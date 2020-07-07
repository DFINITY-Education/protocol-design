import HashMap "mo:base/HashMap";
import List "mo:base/List";
import Principal "mo:base/Principal";

import Types "./Types";

module {

  type Account = Types.Account;
  type Txn = Types.Txn;

  public func principalEq(lhs: Principal, rhs: Principal) : Bool {
    return lhs == rhs;
  };

  public func txnEq(lhs: Txn, rhs: Txn) : Bool {
    return lhs.counterparty == rhs.counterparty and
            lhs.amount == rhs.amount;
  };

  // TODO: Not the best.
  public func accountEq(lhs: Account, rhs: Account) : Bool {
    return lhs.balance == rhs.balance and
            List.isEq<Txn>(lhs.txns, rhs.txns, txnEq) and
            lhs.lockedFunds == rhs.lockedFunds;
  };

  public func safeSub(x: Nat, y: Nat) : (Nat) {
    if (x > y) { x - y }
    else 0
  };

  public func newAccount(initialAmount : Nat) : Account {
    {
      var balance = initialAmount;
      var txns = List.nil<Txn>();
      var allowances = HashMap.HashMap<Principal, Nat>(1, principalEq, Principal.hash);
      var lockedFunds = 0;
    }
  };

  public func spendableBalance(account: Account) : Nat {
    account.balance - account.lockedFunds
  };

};
