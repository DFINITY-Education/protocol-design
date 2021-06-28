import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Log "mo:base/Debug";

import Types "../Types";
import Utils "../Utils";

actor {

  type Domain = Types.Domain;

  //Note for instructor: db needs to be populated (Domain->Principal) 
  //for program to produce real results.
  private let db = HashMap.HashMap<Domain, Principal>(1, Utils.domainEq, Text.hash);

  public shared(msg) func ask(domain : Domain) : async ?Principal {
    db.get(domain)
  };

};
