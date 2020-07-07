import BankTest "canister:BankTest";
import PaymentProcessorTest "canister:PaymentProcessorTest";
import ShopTest "canister:ShopTest";

actor {

  public func run() {
    BankTest.run();
    PaymentProcessorTest.run();
    ShopTest.run();
  };

}
