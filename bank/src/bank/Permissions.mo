import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import List "mo:base/List";
import Prelude "mo:base/Prelude";
import Text "mo:base/Text";

import Types "./Types";
import Utils "./Utils";

module {

  type UT = Types.UserType;

  public class Permissions() {

    let permissions = HashMap.HashMap<UT, List.List<Principal>>(1, utEq, utHash);

    public func hasPermission(user: Principal, userType: UT) : async Bool {
      switch (permissions.get(userType)) {
        case (?userList) { List.some<Principal>(userList, func (p: Principal) : Bool { p == user} ) };
        case (null) { false };
      }
    };

    public func addToGroup<G>(user: Principal, userType: UT) : async () {
      switch (permissions.get(userType)) {
        case (?userList) { permissions.put(userType, List.push<Principal>(user, userList)); };
        case (null) { permissions.put(userType, List.make<Principal>(user)); };
      };
    };

  };

  func utEq(lhs: UT, rhs: UT) : Bool {
    switch (lhs, rhs) {
      case (#super, #super) { true };
      case (#user, #user) { true };
      case (_) { false };
    }
  };

  func utHash(ut: UT) : Hash.Hash {
    switch (ut) {
      case (#super) { Text.hash("s") };
      case (#user) { Text.hash("u") };
    }
  };

};
