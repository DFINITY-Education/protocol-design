import BankTest "./Bank";
import CreditProviderTest "./CreditProvider";
import ShopTest "./Shop";

actor {

    public func run() {
        let bankTest = await BankTest.BankTest();
        bankTest.run();
    };

    public func runCreditProviderTest() {
        let creditProviderTest = await CreditProviderTest.CreditProviderTest();
        creditProviderTest.run();
    };

    public func runShopTest() {
        let shopTest = await ShopTest.ShopTest();
        shopTest.run();
    };

};
