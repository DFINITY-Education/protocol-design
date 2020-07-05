import Debug "mo:base/Debug";
import HashMap "mo:base/HashMap";
import List "mo:base/List";
import Principal "mo:base/Principal";

import Common "./Common";
import Security "./Security";
import Types "./Types";

actor {

  var totalSupply: Nat = 0;
  // TODO: Fix this to use the definitions in `Types`
  var accounts = HashMap.HashMap<Principal, Types.Account>(1, Common.principalEq, Principal.hash);

  // Get the total currency supply minted by the Banker.
  public func getTotalSupply() : async (Nat) {
    totalSupply
  };

  // Increment caller's balance by |amount|
  public shared(msg) func deposit(amount: Nat) : async () {
    let result = accounts.get(msg.caller);
    switch result {
      case (?account) {
        account.balance += amount;
        ignore accounts.set(msg.caller, account);
      };
      case (null) {
        ignore accounts.set(msg.caller, {
          var balance = amount;
          var txns = List.nil<Types.Txn>();
          var allowances = HashMap.HashMap<Principal, Nat>(1, Common.principalEq, Principal.hash);
          var lockedFunds = 0;
        });
      };
    }
  };

  // Decrement caller's balance by |amount|.
  // Balance cannot go below zero.
  // Returns old balance if operation succeeds and 0 if account doesn't exist.
  // TODO: Use Error type here.
  public shared(msg) func withdraw(amount: Nat) : async (Nat) {
    let result = accounts.get(msg.caller);
    switch result {
      case (?account) {
        account.balance := Common.safeSub(account.balance, amount);
        let oldAccount = accounts.set(msg.caller, account);
        account.balance
      };
      case (null) 0
    }
  };

  // Checks that a user's account exists and, if so, retrieves its balance.
  // TODO: Use Error type here.
  public func checkBalance(owner: Principal) : async (Nat) {
    let result = accounts.get(owner);
    switch result {
      case (?account) account.balance;
      case (_) 0;
    }
  };

  // Checks that all accounts exist and that the account owner has sufficient funds.
  // Increments the payee's balance by |amount| and decrements the account owner's
  // by the same amount.
  public shared(msg) func transferAmount(to: Principal, amount: Nat) : async (Bool) {
    let fromAccountResult = accounts.get(msg.caller);
    let toAccountResult = accounts.get(to);

    switch (fromAccountResult, toAccountResult) {
      case (?fromAccount, ?toAccount) {
        if (Common.spendableBalance(fromAccount) < amount) { return false; };

        fromAccount.balance -= amount;
        toAccount.balance += amount;
        ignore accounts.set(msg.caller, fromAccount);
        ignore accounts.set(to, toAccount);
        true
      };
      case (_) false;
    }
  };

  // Grants the specified account an allowance of up to |amount| of the caller's
  // balance.
  // TODO: Lock some of the caller's balance equal to |amount|.
  public shared(msg) func grantAllowance(to: Principal, amount: Nat) : async (Bool) {
    let fromAccountResult = accounts.get(msg.caller);

    switch (fromAccountResult) {
      case (?account) {
        if (account.balance < Common.spendableBalance(account)) { return false; };

        ignore account.allowances.set(to, amount);
        true
      };
      case (_) false;
    }
  };

  // TODO: Follow DRY and consolidate into one helper.
  public shared(msg) func spendAllowance(from: Principal, to: Principal, amount: Nat) : async (Bool) {
    let fromAccountResult = accounts.get(from);
    let toAccountResult = accounts.get(to);

    switch (fromAccountResult, toAccountResult) {
      case (?fromAccount, ?toAccount) {
        let fromAllowanceResult = fromAccount.allowances.get(msg.caller);
        switch (fromAllowanceResult) {
          case (?fromAllowance) {
            fromAccount.balance -= amount;
            toAccount.balance += amount;
            ignore accounts.set(msg.caller, fromAccount);
            ignore accounts.set(to, toAccount);

            let newFromAllowance = fromAllowance - amount;
            if (newFromAllowance == 0) {
              ignore fromAccount.allowances.del(msg.caller);
            } else {
              ignore fromAccount.allowances.set(msg.caller, newFromAllowance);
            };
            true
          };
          case (null) false;
        }
      };
      case (_) false;
    }
  };

  // BANKER METHODS
  // TODO: Implement canister ownership.

  public func mintSupply(amount: Nat) : async () {
    totalSupply += amount;
  };

  public func burnSupply(amount: Nat) : async () {
    totalSupply := Common.safeSub(totalSupply, amount);
  };

};