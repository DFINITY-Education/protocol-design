import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Option "mo:base/Option";
import Principal "mo:base/Principal";
import Result "mo:base/Result";

import Bank "canister:Bank";

import Types "../src/bank/Types";
import Utils "../src/bank/Utils";

actor {

  private type Error = Types.Error;
  private type Result<V, E> = Result.Result<V, E>;

  private let accountList: [Principal] = [
    Principal.fromText("mwsbc-m36iz-hqfpr-2r4gx-ayweq-olr4i-hqmow-xnshg-3su4o-4bsmd-mae"),
  ];

  // TODO: Test negative case.
  func runAccountExistsAndGetBalanceTest() : async () {
    let positiveTestResult = await Bank.getBalance(accountList[0]);
    Result.assertOk(positiveTestResult);
    assert(Result.unwrapOk<Nat, Error>(positiveTestResult) == 0);
  };

  // Helpers

  private func setup() : async () {
      for (account in Iter.fromArray(accountList)) { Bank.openAccount(account); };
  };

  private func tearDown() : async () {
    Bank.wipeAccounts();
  };

  // Test Hook

  let tests = [runAccountExistsAndGetBalanceTest];

  public func run() {
    for (test in tests.vals()) {
      await setup();
      await test();
      await tearDown();
    };
  };

};
