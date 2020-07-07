import HashMap "mo:base/HashMap";
import Option "mo:base/Option";

// import Bank "../src/bank/Main";
import Database "../src/bank/Database";
import Permissions "../src/bank/Permissions";
import Types "../src/bank/Types";
import Utils "../src/bank/Utils";

actor {

  var db: Database.Database = Database.Database();
  // TODO: How to use Principals?
  private let accountList: [Principal] = [
    // "ic:EE8110735D21E9D3EF"
  ];

  // TODO: public?
  // TODO: Test negative case.
  public shared(msg) func runAccountExistsAndGetBalanceTest() : async () {
    setup();

    let positiveTestResult = db.findAccount(msg.caller);
    Option.assertSome(positiveTestResult);
    assert(Utils.accountEq(Option.unwrap<Types.Account>(positiveTestResult), Utils.newAccount(0)));

    tearDown();
  };

  // Helpers

  // TODO: public?
  public shared(msg) func setup() {
    db.updateAccount(msg.caller, Utils.newAccount(0));
  };

  func tearDown() {
    db.clear();
  };

  // Test Hook

  let tests = [runAccountExistsAndGetBalanceTest];

  public func run() {
    for (test in tests.vals()) await test()
  };

}
