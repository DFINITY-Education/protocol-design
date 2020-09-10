# Module 3: Banking as a Protocol
Build out a banking protocol, as seen in the example below:
```bash
> dfx canister call bank deposit '(500)'
()
```

## Background
The bank canister behaves as you would expect a regular bank should, with some additional functionality. Account holders can deposit, withdraw, and transfer their funds to other account holders. The bank is also able to grant account holders an "allowance" which entitles them to spend from the balance of a different account holder, up to a certain amount. Naturally, the account holder whose balance is being spent needs to approve the allowance before any spending occurs.

### Extra Modules
To carry out its role, the bank canister leverages two additional modules: one for database management, and another for permissioning.

The **Database** module is responsible for the retrieval and storage of account holder information.

The **Permissions** module is responsible for maintaining user groups and granting privileges to account holders based on the user group they belong to.

Note that these modules may each serve as independent protocols for other applications to build on top of, they are not necessarily bank-specific.

## Your Task
In this exercise, you will implement the aforementioned libraries for the bank to use. You’ll need to use your understanding of the bank's operations to ensure that the libraries are leverages successfully.

### Code Understanding
After navigating to the [bank/](./bank), let’s take a look at the code in _src/bank/Main.mo_. You will find the expected methods `getTotalSupply`, `getBalance`, `deposit`, `withdraw`, and `transfer` are all fully implemented. You will also see that the `Database` and `Permissions` classes are initialized:
```Motoko
var db: Database.Database = Database.Database();
var permissions: Permissions.Permissions = Permissions.Permissions();
```
Note how each is used, the arguements their methods take, and whether they are expected to return a value.

In `src/bank/Database.mo`, you'll find `findAccount`, `findMultipleAccounts`, `updateAccount`, and `clear`. Each of these makes calls to the underlying `localDB` HashMap. More specifically, `findAccount` and `updateAccount` are the getter and setter methods, respectively, while `findMultipleAccounts` is simply `findAccount` called on multiple inputs. Notice how none of these methods are permissioned, meaning anyone may be able to call a dangerous method like `clear`. It is up to the implementer—the bank canister in this case—to ensure permissions are set up appropriately.

In `src/bank/Permissions.mo`, you'll find `hasPermission` and `addToGroup`. The former method checks whether the given account holder falls within the specified group, whereas the latter method allows the caller to set an account holder's privileges.

### Specification
**Task**: Complete the implementation of the `Database` and `Permissions` classes.

`Database.mo`: `findAccount`, `findMultipleAccounts`, `updateAccount`, `clear`

`Permissions.mo`: `hasPermission`, `addToGroup`

### Testing
The following test should run to completion:
```bash
> dfx start --background
> dfx canister create --all
> dfx build
Building canisters...

> dfx canister install --all
Installing code for canister Bank, with canister_id ic:ABCDEFGHIJKLMNOPQR
Installing code for canister BankTest, with canister_id: ...
...

> dfx canister call Test run
()
```
