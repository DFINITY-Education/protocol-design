import BankTest "canister:BankTest";
import CreditProviderTest "canister:CreditProviderTest";
import ShopTest "canister:ShopTest";

actor {

  public func run() {
    BankTest.run();
    CreditProviderTest.run();
    ShopTest.run();
  };

};
