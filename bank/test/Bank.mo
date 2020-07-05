import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";

// import Bank "../src/bank/Main";
import Common "../src/bank/Common";
// import Security "../src/bank/Security";
import Types "../src/bank/Types";

actor {

  var accounts = HashMap.HashMap<Principal, Types.Account>(1, Common.principalEq, Principal.hash);

  // TODO: Try to check for real account and succeed. Try to check for non-existent account and fail.
  func runAccountExistsAndGetBalanceTest() {
    setup();

    assert (true);

    tearDown();
  };

  // Helpers

  // TODO: Add Principal/Account KV pairs.
  func setup() {};

  func tearDown() {
    for ((entryKey, _) in accounts.iter()) {
      ignore accounts.del(entryKey);
    };
  };

  // Test Hook

  let tests = [runAccountExistsAndGetBalanceTest];

  public func run() {
    for (test in tests.vals()) test()
  };

}
