import BankTest "canister:BankTest";
import PaymentProcessorTest "canister:PaymentProcessorTest";
import VendorTest "canister:VendorTest";

actor {

  public func run() {
    BankTest.run();
    PaymentProcessorTest.run();
    VendorTest.run();
  };

}
