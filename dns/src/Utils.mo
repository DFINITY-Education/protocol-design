import Hash "mo:base/Hash";
import Text "mo:base/Text";

import Types "./Types";

module {

  type Domain = Types.Domain;

  public func domainEq(lhs: Domain, rhs: Domain) : Bool {
    return lhs == rhs;
  };

  public func domainHash(domain: Domain) : Hash.Hash {
    return Text.hash(domain);
  };

};
