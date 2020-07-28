import HashMap "mo:base/HashMap";
import List "mo:base/List";
import Principal "mo:base/Principal";
import Result "mo:base/Result";
import Text "mo:base/Text";

import Root "canister:Root";

import Parsing "./Parsing";
import Types "../Types";
import NameServer "../nameServer/Main";

actor {

  type Domain = Types.Domain;

  let cache = HashMap.HashMap<Domain, Principal>(1, Text.equal, Text.hash);


  /// Acts the part of a DNS resolver by resolving the |domain| into a Principal address
  /// Args:
  ///   |domain|   The domain to be looked up
  /// Returns:
  ///   The Principle of the given domain
  ///   Possible errors: #
  public func resolve(domain: Domain) : async Result<Principal, Error> {
    switch (cache.get(domain)) {
      case (?addr) { return #ok(addr) };
      case (null) {
        var parsedDomain = parseDomain(domain);
        var server = Principal.fromActor(Root);
        var counter = List.size<Text>(parsedDomain);
        while (counter > 0) {
          server := switch (List.last<Text>(parsedDomain)) {
            case (null) { return #err(#addressNotFound) };
            case (?subdomain) { await ask(subdomain, server) };
          };
          counter -= 1;
          parsedDomain := List.drop<Text>(parsedDomain, counter);
        };
        cache.put(domain, server);

        #ok(server)
      };
    }
  };

  func ask(domain: Domain, who: Principal) : async Result<Principal, Error> {
    try {
      let server = actor (Principal.toText(who)) : actor {
        ask : Types.Domain -> async ?Principal;
      };
      #ok(server.ask(domain))
    } catch _ {
      Log.error("Canister unreachable!")
      #err(addressNotFound)
    };
  };

  func parseDomain(domain: Domain) : List.List<Text> {
    Parsing.split(domain, ".")
  };

};
