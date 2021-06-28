import HashMap "mo:base/HashMap";
import List "mo:base/List";
import Log "mo:base/Debug";
import Principal "mo:base/Principal";
import Result "mo:base/Result";
import Text "mo:base/Text";

import Root "canister:Root";


import Parsing "./Parsing";
import Types "../Types";

actor {

  type Domain = Types.Domain;
  type Error = Types.Error;
  type Result<S, T> = Result.Result<S, T>;

  private let cache = HashMap.HashMap<Domain, Principal>(1, Text.equal, Text.hash);

  /// Acts the part of a DNS resolver by resolving the |domain| into a Principal address.
  /// Args:
  ///   |domain|   The domain to be looked up
  /// Returns:
  ///   The Principle of the given domain
  ///   Possible errors: #addressNotFound
  public func resolve(domain: Domain) : async Result<Principal, Error> {
    switch (cache.get(domain)) {
      case (?addr) { return #ok(addr) };
      case (null) {
        var parsedDomain = parseDomain(domain);
        var server = Principal.fromActor(Root);
        var counter = List.size<Text>(parsedDomain);
        while (counter > 0) {
          var name = List.last<Text>(parsedDomain);
          server := switch (name) {
            case (null) { 
              return #err(#addressNotFound); 
              };
            case (?subdomain) { 
              return await ask(subdomain, server); 
              };
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
      var result = await server.ask(domain);
      switch (result) {
        case (?address) { 
          #ok(address) 
          };
        case (null) { 
          #err(#addressNotFound) 
          };
      }
    } catch _ {
      Log.print("Canister unreachable!");
      #err(#addressNotFound)
    }
  };

  func parseDomain(domain: Domain) : List.List<Text> {
    Parsing.split(domain, ".")
  };

};
