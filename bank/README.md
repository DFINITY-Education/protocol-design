# Module 3: Banking as a Protocol
The bank canister behaves as you would expect a regular bank should, with some additional functionality. Account holders can `deposit`, `withdraw`, and `transfer` their funds to other accounts holders, as you would expect.

### Documentation (WIP)

## YOUR TASK
Read and understand how the base protocol works. The Bank also uses two libraries: one for database management, and another for permissioning. These have not yet been implemented. Demonstrate your understanding by writing code for the two Motoko libraries used in the Bank protocol such that the tests pass.

The following test should run to completion:
```bash
> dfx build
Building canisters...
> dfx canister install --all
Installing code for canister Bank, with canister_id ic:ABCDEFGHIJKLMNOPQR
Installing code for canister BankTest, with canister_id: ...
...
> dfx canister call Test run
()
```

# Module 4: Building on Top of a Protocol

Building off of the previous exercise (literally), we'd like to now provide account holders with additional services. Code stubs for the following canisters are provided:

* The _shop_ allows vendors to stock (predefined) items in their inventory. Customers can buy items by transferring funds from their Bank accounts to the vendor’s.

* The _credit provider_ extends a line of credit to customers while levying higher interest rates per transaction.

You may have noticed that the original banking protocol also allows account holders to delegate a portion of their balance to be spent by another party, e.g. a third-party app. This functionality is relevant to this module.

### Documentation (WIP)

## YOUR TASK
You will be building an app that leverages the banking protocol in some way. Select either `src/creditProvider` or `src/shop`, read its inline documentation, and fill in each stubbed canister method.

Either of the following tests should run to completion depending on which you chose to complete:
```bash
dfx canister call CreditProviderTest run
()
```
```bash
dfx canister call ShopTest run
()
```

### Bonus
Complete all applications under `src/`. The following test should run to completion:
```bash
dfx canister call Test run
()
```