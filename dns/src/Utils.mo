import Hash "mo:base/Hash";
import Text "mo:base/Text";

import Types "./Types";

module {

  public func urlEq(lhs: Types.URL, rhs: Types.URL) : Bool {
    return lhs == rhs;
  };

  public func urlHash(url: Types.URL) : Hash.Hash {
    return Text.hash(url);
  };

};
