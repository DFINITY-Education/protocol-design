import Debug "mo:base/Debug";
import HashMap "mo:base/HashMap";
import List "mo:base/List";
import Principal "mo:base/Principal";

import Database "./Database";
import Security "./Security";
import Types "./Types";
import Utils "./Utils";

actor {

  var totalSupply: Nat = 0;
  var db: Database.Database = Database.Database();

  // Get the total currency supply minted by the Banker.
  public query func getTotalSupply() : async (Nat) {
    totalSupply
  };

  // Checks that a user's account exists and, if so, retrieves its balance.
  // TODO: Use Error type here.
  public query func checkBalance(owner: Principal) : async (Nat) {
    let result = db.findAccount(owner);
    switch result {
      case (?account) account.balance;
      case (_) 0;
    }
  };

  // Increment caller's balance by |amount|
  public shared(msg) func deposit(amount: Nat) : async () {
    let result = db.findAccount(msg.caller);
    switch result {
      case (?account) {
        account.balance += amount;
        db.updateAccount(msg.caller, account);
      };
      case (null) {
        db.updateAccount(msg.caller, Utils.newAccount(amount));
      };
    }
  };

  // Decrement caller's balance by |amount|.
  // Balance cannot go below zero.
  // Returns old balance if operation succeeds and 0 if account doesn't exist.
  // TODO: Use Error type here. No need for oldBalance.
  public shared(msg) func withdraw(amount: Nat) : async (Nat) {
    let result = db.findAccount(msg.caller);
    switch result {
      case (?account) {
        let oldBalance = account.balance;
        account.balance := Utils.safeSub(account.balance, amount);
        db.updateAccount(msg.caller, account);
        oldBalance
      };
      case (null) 0
    }
  };

  // Checks that all accounts exist and that the account owner has sufficient funds.
  // Increments the payee's balance by |amount| and decrements the account owner's
  // by the same amount.
  public shared(msg) func transferAmount(to: Principal, amount: Nat) : async (Bool) {
    let fromAccountResult = db.findAccount(msg.caller);
    let toAccountResult = db.findAccount(to);

    switch (fromAccountResult, toAccountResult) {
      case (?fromAccount, ?toAccount) {
        if (Utils.spendableBalance(fromAccount) < amount) { return false; };

        fromAccount.balance -= amount;
        toAccount.balance += amount;
        db.updateAccount(msg.caller, fromAccount);
        db.updateAccount(to, toAccount);
        true
      };
      case (_) false;
    }
  };

  // Grants the specified account an allowance of up to |amount| of the caller's
  // balance.
  // TODO: Lock some of the caller's balance equal to |amount|.
  public shared(msg) func grantAllowance(to: Principal, amount: Nat) : async (Bool) {
    let fromAccountResult = db.findAccount(msg.caller);

    switch (fromAccountResult) {
      case (?account) {
        if (account.balance < Utils.spendableBalance(account)) { return false; };

        // TODO: 
        db.updateAllowance(account, to, amount);
        true
      };
      case (_) false;
    }
  };

  // TODO: Follow DRY and consolidate into one helper.
  public shared(msg) func spendAllowance(from: Principal, to: Principal, amount: Nat) : async (Bool) {
    let fromAccountResult = db.findAccount(from);
    let toAccountResult = db.findAccount(to);

    switch (fromAccountResult, toAccountResult) {
      case (?fromAccount, ?toAccount) {
        let fromAllowanceResult = fromAccount.allowances.get(msg.caller);
        switch (fromAllowanceResult) {
          case (?fromAllowance) {
            fromAccount.balance -= amount;
            toAccount.balance += amount;
            db.updateAccount(msg.caller, fromAccount);
            db.updateAccount(to, toAccount);

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
    totalSupply := Utils.safeSub(totalSupply, amount);
  };

};