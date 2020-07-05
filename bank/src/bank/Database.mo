import Array "mo:base/Array";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Option "mo:base/Option";

import Types "./Types";
import Utils "./Utils";

module {

  type Account = Types.Account;

  public class Database() {
    // TODO: Fix this to use the definitions in `Types`
    let localDB = HashMap.HashMap<Principal, Account>(1, Utils.principalEq, Principal.hash);

    public func findAccount(accountHolder: Principal): ?Account {
      localDB.get(accountHolder)
    };

    public func findMultipleAccounts(accountHolderList: [Principal]): [?Account] {
      Array.map<Principal, ?Account>(findAccount, accountHolderList);
    };

    public func updateAccount(accountHolder: Principal, account: Account) {
      ignore localDB.set(accountHolder, account);
    };

    public func updateAllowance(account: Account, counterparty: Principal, allowance: Nat) {
      ignore account.allowances.set(counterparty, allowance);
    };

    public func clear() {
      for ((entryKey, _) in localDB.iter()) {
        ignore localDB.del(entryKey);
      };
    }

    // public func findBy(term: Text): [Account] {
    //   var retval: [Profile] = [];
    //   for ((accountHolder, account) in localDB.iter()) {
    //     let fullName = profile.firstName # " " # profile.lastName;
    //     if (includesText(fullName, term)) {
    //       profiles := Array.append<Profile>(profiles, [profile]);
    //     };
    //   };
    //   profiles
    // };

  };

};
