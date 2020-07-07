import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import List "mo:base/List";
import Prelude "mo:base/Prelude";

import Types "./Types";
import Utils "./Utils";

module {

  // TODO: Is there a way to refer to actor-scopes vars from module scope?

  type UT = Types.UserType;
  // type List<T> = List.List<T>;

  public class Permissions() {

    let permissions = HashMap.HashMap<UT, List.List<Principal>>(1, utEq, utHash);

    public func hasPermission(user: Principal, userType: UT) : async Bool {
      // TODO: List.take doesn't work.
      // switch (permissions.get(userType)) {
      //   case (?userList) List.take<Principal>(userList, func (p: Principal) : Bool { p == user} );
      //   case (null) false;
      // }
      return true;
    };

    public func addToGroup<G>(user: Principal, userType: UT) : async () {
      // TODO: List.make doesn't work.
      // switch (permissions.get(userType)) {
      //   case (?userList) permissions.set(userType, userList.push<Principal>(user));
      //   case (null) permissions.set(userType, List.make<Principal>(user));
      // };
    };

  };

  func utEq(lhs: UT, rhs: UT) : Bool {
    switch (lhs, rhs) {
      case (#super, #super) true;
      case (#user, #user) true;
      case (_) false;
    }
  };

  func utHash(ut: UT) : Hash.Hash {
    switch (ut) {
      case (#super) Hash.hashOfText("s");
      case (#user) Hash.hashOfText("h");
    }
  }

};
