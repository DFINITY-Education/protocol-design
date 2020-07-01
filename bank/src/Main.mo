import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import List "mo:base/List";
import Prelude "mo:base/Prelude";
import Principal "mo:base/Principal";

import Common "./common";
import Security "./security";
import Types "./types";

actor {

  var totalSupply: Nat = 0;
  // TODO: Fix these to use the definitions in `Types`
  var accounts = HashMap.HashMap<Principal, Types.Account>(1, Common.principalEq, Principal.hash);
  var allowList = HashMap.HashMap<Principal, Types.AllowListEntries>(1, Common.principalEq, Principal.hash);

  public func getTotalSupply() : async Nat {
    totalSupply
  };

  // TODO: Fix bug.
  public func checkBalance(owner: Principal) : async Nat {
    let check = await Security.accountExistsAndGetBalance(accounts, owner);
    switch check {
      case (#Success, ?account) account.get().balance;
      case _ 0;
    }
  };

  // TODO: Fix bug.
  public shared(msg) func transferAmount(to: Principal, amount: Nat) : async Nat {
    let currentBalance = accounts.get(msg.caller);
    if (await Security.hasFunds(msg.caller, amount, currentBalance)) {
        let newBalance = currentBalance - amount;
        accounts.replace(owner, newBalance);
        return newBalance;
    };
    return currentBalance;
    0
  };

  // TODO: Implement me.
  public func grantAllowance(to: Principal, amount: Nat) : async Bool {
    Prelude.nyi();
    return true;
  };

  // OWNER METHODS
  // TODO: Figure out canister ownership.

  public func mintSupply(amount: Nat) : async () {
    totalSupply += amount;
  };

  public func burnSupply(amount: Nat) : async () {
    if (amount > totalSupply) {
      totalSupply := 0;
    } else {
      totalSupply -= amount;
    }
  };

};