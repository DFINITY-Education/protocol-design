import HashMap "mo:base/HashMap";
import List "mo:base/List";
import Principal "mo:base/Principal";
import Result "mo:base/Result";
import Text "mo:base/Text";

import Root "canister:Root";

import Parsing "./Parsing";
import Types "../Types";

actor {

  let cache = HashMap.HashMap<Text, Types.IpAddress>(1, Text.equal, Text.hash);
  // let root: Principal = "???";

  public func resolve(url: Types.URL) : async Result<Types.IpAddress, Error> {
    switch (cache.get(url)) {
      case (?addr) { return #ok(addr) };
      case (null) {
        var parsedUrl = parseUrl(url);
        var server = Principal.fromActor(Root);
        var counter = List.size<Text>(parsedUrl);
        while (counter > 0) {
          server := switch (List.last<Text>(parsedUrl)) {
            case (null) { return #err(#addressNotFound) };
            case (?subdomain) { await ask(subdomain, server) };
          };
          counter -= 1;
          parsedUrl := List.drop<Text>(parsedUrl, counter);
        };
        let addr = askForIp(parsedUrl[0], server);
        cache.put(url, addr);

        #ok(addr)
      };
    }
  };

  func ask(url: Types.URL, who: Principal) : async Result<Principal, Error> {
    try {
      #ok(actor(Principal.toText(who)).ask(url))
    } catch _ {
      Log.error("Canister unreachable!")
      #err(addressNotFound)
    };
  };

  func askForIp(url: Types.URL, who: Principal) : async Result<Types.IpAddress, Error> {
    try {
      #ok(actor(Principal.toText(who)).ask(url))
    } catch _ {
      Log.error("Canister unreachable!")
      #err(addressNotFound)
    };
  };

  func parseUrl(url: Types.URL) : List.List<Text> {
    Parsing.split(url, ".")
  };

};
