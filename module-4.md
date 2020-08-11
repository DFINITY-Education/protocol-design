# Module 4: Building on Top of a Protocol
Building off of the previous exercise (literally!), provide account holders with additional services utilizing the banking protocol.

## Background
As you saw in [Modules 1](./module-1.md) and [2](./module-2.md), a common pattern found in protocol architecture is layering protocols one on top of another. This helps in simplifying the protocol's design by dividing each of its constituants into their own modular layers. How independent each layer is may vary, but this design lends itself well to reusing certain layers for multiple protocols (think about how multiple canisters may leverage the same `Database` class from [Module 3](./module-3.md)).

### Applications to Build
The **credit provider** extends a line of credit to customers while levying higher interest rates per transaction.
The **shop** allows vendors to stock (predefined) items in their inventory. Customers can buy items by transferring funds from their Bank accounts to the vendor’s.

You may have noticed that the original banking protocol also allows account holders to delegate a portion of their balance to be spent by another party, e.g. a third-party app. This functionality is relevant to this module.

## Your Task
In this exercise, you will be building an app that leverages the banking protocol in some way. Select either , and fill in each stubbed canister method.

### Code Understanding
After navigating to the [bank/](./bank), let’s take a look at the code in _src/creditProvider/_ and _src/shop_.

### Specification
**Task**: Complete the implementation of either `creditProvider` or `shop`. Feel free to add any helper modules you may need.

### Testing
Either of the following tests should run to completion depending on which you chose:
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