import Types "./Types";

module {

    public func principalEq(lhs: Principal, rhs: Principal) : (Bool) {
        return lhs == rhs;
    };

    public func safeSub(x: Nat, y: Nat) : (Nat) {
        if (x > y) { x - y }
        else 0
    };

    public func spendableBalance(account: Types.Account) : Nat {
        account.balance - account.lockedFunds
    };

}