import Array "mo:base/Array";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";

import Types "./Types";
import Utils "./Utils";

module {

  type Account = Types.Account;

  /// A basic database object built on a standard HashMap data structure.
  /// @dev Methods in this class carry out atomic operations on the data structure.
  ///      No assumptions are made, e.g. whether a user carries a sufficient balance.
  ///      Canisters using this class should do their own error checking.
  public class Database() {
    // TODO: Fix this to use the definitions in `Types`
    let localDB = HashMap.HashMap<Principal, Account>(1, Utils.principalEq, Principal.hash);

    /// Retrieves Account opened by |accountHolder|, if it exists.
    /// Args:
    ///   |accountHolder|   The Principal to look up.
    /// Returns:
    ///   An optional Account value. The value is null if the account does not
    ///   exist in |localDB|.
    public func findAccount(accountHolder: Principal) : ?Account {
      localDB.get(accountHolder)
    };

    /// Retrieves Account opened by |accountHolder|, if it exists.
    /// Args:
    ///   |accountHolders|   An Array of Principals to look up.
    /// Returns:
    ///   An Array of optional Account values in the same ordering as their
    ///   respective Principals. Each value may be null if the corresponding
    ///   account does not exist in |localDB|.
    public func findMultipleAccounts(accountHolderList: [Principal]) : [?Account] {
      Array.map<Principal, ?Account>(accountHolderList, findAccount)
    };

    /// Sets entire Account of |accountHolder| to |account|.
    /// This overrides any previously set Account, if one was existed prior.
    /// Args:
    ///   |accountHolder|   The Principal whose Account will be updated.
    ///   |account|         The updated Account.
    public func updateAccount(accountHolder: Principal, account: Account) {
      localDB.put(accountHolder, account);
    };

    /// Deletes all entries in |localDB|.
    public func clear() {
      for ((entryKey, _) in localDB.entries()) {
        localDB.delete(entryKey);
      };
    };

  };

};
