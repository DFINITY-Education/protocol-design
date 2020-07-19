import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Text "mo:base/Text";

import Types "../Types";
import Utils "../Utils";

actor {

  type Domain = Types.Domain;

  let db = HashMap.HashMap<Domain, Principal>(1, Utils.domainEq, Text.hash);

  public shared(msg) func ask(domain : Domain) : async ?Principal {
    db.get(domain)
  };

};
