import Security "../src/Security";

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
  func setup() {
    accounts.put(12345, 12345);
  };

  func tearDown() {
    for (entry in accounts) {
      accounts.delete(entry.key);
    };
  };

  // Test Hook

  let tests = [runAccountExistsAndGetBalanceTest];

  public func run() {
    for (test in tests.vals()) test()
  };

}