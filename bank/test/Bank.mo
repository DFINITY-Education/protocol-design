import HashMap "mo:base/HashMap";
import Option "mo:base/Option";
import Principal "mo:base/Principal";

import Bank "../src/bank/Main";
import Types "../src/bank/Types";
import Utils "../src/bank/Utils";

actor {

  private let accountList: [Principal] = [
    Principal.fromText("ic:EE8110735D21E9D3EF"),
    Principal.fromText("ic:PUIY24FTF64GHV2B21")
  ];

  // TODO: Test negative case.
  func runAccountExistsAndGetBalanceTest() : async () {
    setup();

    let positiveTestResult = db.findAccount(msg.caller);
    Option.assertSome(positiveTestResult);
    assert(Utils.accountEq(Option.unwrap<Types.Account>(positiveTestResult), Utils.newAccount(0)));

    tearDown();
  };

  // Helpers

  func setup() {
    switch (Bank.becomeBanker()) {
      case (#ok) { for (account in accountList) { Bank.openAccount(account); }; };
      case (#err) { Log.print("BankTest.setup - Setup failed."); };
    };
  };

  func tearDown() {
    Bank.wipeAccounts();
  };

  // Test Hook

  let tests = [runAccountExistsAndGetBalanceTest];

  public func run() {
    for (test in tests.vals()) {
      setup();
      await test();
      tearDown();
    };
  };

};
