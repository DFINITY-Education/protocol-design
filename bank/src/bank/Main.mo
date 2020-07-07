import Debug "mo:base/Debug";
import HashMap "mo:base/HashMap";
import Result "mo:base/Result";

import Database "./Database";
import Permissions "./Permissions";
import Types "./Types";
import Utils "./Utils";

actor {

  type Error = Types.Error;
  type Result<V, E> = Result.Result<V, E>;

  var banker: ?Principal = null;
  var totalSupply: Nat = 0;
  var db: Database.Database = Database.Database();
  var permissions: Permissions.Permissions = Permissions.Permissions();

  /// Retrieves the total currency supply minted by the Banker.
  /// Returns:
  ///   The |totalSupply| state variable.
  public query func getTotalSupply() : async Nat {
    totalSupply
  };

  /// Retrieves the |accountHolder|'s balance if their Account exists.
  /// Args:
  ///   |accountHolder|   The Principal whose Account to look up.
  /// Returns:
  ///   The balance if successful and an Error the caller's account doesn't exist.
  ///   Possible errors: #accountNotFound
  public query func getBalance(accountHolder: Principal) : async Result<Nat, Error> {
    let check = db.findAccount(accountHolder);
    switch check {
      case (?account) #ok(account.balance);
      case (null) #err(#accountNotFound);
    }
  };

  /// Increments caller's balance by |amount|.
  /// Args:
  ///   |amount|   The amount to increment the caller's balance by.
  public shared(msg) func deposit(amount: Nat) : async () {
    let check = db.findAccount(msg.caller);
    switch check {
      case (?account) {
        account.balance += amount;
        db.updateAccount(msg.caller, account);
      };
      case (null) {
        db.updateAccount(msg.caller, Utils.newAccount(amount));
      };
    }
  };

  /// Decrements caller's balance by |amount|. Note that balances cannot go below zero.
  /// Args:
  ///   |amount|   The amount to decrement the caller's balance by.
  /// Returns:
  ///   Nothing if successful and an Error if the caller's account doesn't exist.
  ///   Possible errors: #accountNotFound
  public shared(msg) func withdraw(amount: Nat) : async Result<(), Error> {
    let check = db.findAccount(msg.caller);
    switch check {
      case (?account) {
        account.balance := Utils.safeSub(account.balance, amount);
        db.updateAccount(msg.caller, account);
        #ok()
      };
      case (null) #err(#accountNotFound);
    }
  };

  /// Increments the payee's balance by |amount| and decrements the caller's
  /// by the same amount.
  /// Args:
  ///   |to|       The Principal whose Account will receive the transfer (the payee).
  ///   |amount|   The amount to transfer to the payee.
  /// Returns:
  ///   Nothing if successful and an Error if either the caller's or the payee's
  ///   accounts don't exist or if the caller does not have sufficient funds.
  ///   Possible errors: #accountNotFound, #insufficientBalance
  public shared(msg) func transfer(to: Principal, amount: Nat) : async Result<(), Error> {
    let fromAccountCheck = db.findAccount(msg.caller);
    let toAccountCheck = db.findAccount(to);

    switch (fromAccountCheck, toAccountCheck) {
      case (?fromAccount, ?toAccount) {
        if (Utils.spendableBalance(fromAccount) < amount) { return #err(#insufficientBalance); };

        fromAccount.balance -= amount;
        toAccount.balance += amount;
        db.updateAccount(msg.caller, fromAccount);
        db.updateAccount(to, toAccount);
        #ok()
      };
      case (_) #err(#accountNotFound);
    }
  };

  /// Grants |to| an Allowance of up to |amount| of the caller's balance.
  /// Args:
  ///   |to|       The Principal who will receive the Allowance.
  ///   |amount|   The amount of the caller's balance to grant to the payee.
  /// Returns:
  ///   Nothing if successful and an Error if either the caller's or the payee's
  ///   accounts don't exist or if the caller does not have sufficient funds.
  ///   Possible errors: #accountNotFound, #insufficientBalance
  public shared(msg) func grantAllowance(to: Principal, amount: Nat) : async Result<(), Error> {
    let check = db.findAccount(msg.caller);

    switch check {
      case (?account) {
        if (Utils.spendableBalance(account) < amount) { return #err(#insufficientBalance); };

        ignore account.allowances.set(to, amount);
        ignore account.lockedFunds += amount;
        db.updateAccount(msg.caller, account);
        #ok()
      };
      case (null) #err(#accountNotFound);
    }
  };

  /// Transfers |amount| from the payer's Account to the payee's.
  /// Args:
  ///   |from|     The Principal whose balance is being spent (the payer).
  ///   |to|       The Principal whose Account will receive the transfer (the payee).
  ///   |amount|   The amount of the payer's balance to transfer to the payee's.
  /// Returns:
  ///   Nothing if successful and an Error if either the the payer's or the payee's
  ///   accounts don't exist or if |amount| is greater than the Allowance amount.
  ///   Possible errors: #accountNotFound, #allowanceDiscrepancy
  public shared(msg) func spendAllowance(from: Principal, to: Principal, amount: Nat) : async Result<(), Error> {
    let fromAccountCheck = db.findAccount(from);
    let toAccountCheck = db.findAccount(to);

    switch (fromAccountCheck, toAccountCheck) {
      case (?fromAccount, ?toAccount) {
        let fromAllowanceCheck = fromAccount.allowances.get(msg.caller);
        switch (fromAllowanceCheck) {
          case (?fromAllowance) {
            if (fromAllowance < amount) { return #err(#allowanceDiscrepancy); };

            fromAccount.balance -= amount;
            fromAccount.lockedFunds -= amount;
            toAccount.balance += amount;

            if (fromAllowance == amount) {
              ignore fromAccount.allowances.del(msg.caller);
            } else {
              ignore fromAccount.allowances.set(msg.caller, fromAllowance - amount);
            };

            db.updateAccount(msg.caller, fromAccount);
            db.updateAccount(to, toAccount);

            #ok()
          };
          case (null) #err(#allowanceDiscrepancy);
        }
      };
      case (_) #err(#accountNotFound);
    }
  };

  // BANKER METHODS

  /// The first caller to this method becomes the Banker.
  public shared(msg) func becomeBanker() : async Result<(), Error> {
    switch banker {
      case (null) {
        banker := ?msg.caller;
        // TODO: Calling ignore instead of await here also works?
        await permissions.addToGroup(msg.caller, #super);

        #ok()
      };
      case (_) #err(#noPermission);
    }
  };

  /// Increments |totalSupply| by |amount|.
  /// Args:
  ///   |amount|   The amount to increment |totalSupply| by.
  public func mintSupply(amount: Nat) : async () {
    totalSupply += amount;
  };

  /// Decrements |totalSupply| by |amount|. Note that |totalSupply| cannot go below zero.
  /// Args:
  ///   |amount|   The amount to decrement |totalSupply| by.
  public func burnSupply(amount: Nat) : async () {
    totalSupply := Utils.safeSub(totalSupply, amount);
  };

};