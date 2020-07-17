import HashMap "mo:base/HashMap";
import List "mo:base/List";
import Principal "mo:base/Principal";
import Text "mo:base/Text";

import Root "canister:Root";

import Parsing "./Parsing";
import Types "../Types";

actor {

  let cache = HashMap.HashMap<Text, Types.IpAddress>(1, Text.equal, Text.hash);
  // let root: Principal = "???";

  public func resolve(url: Types.URL) : async Types.IpAddress {
    switch (cache.get(url)) {
      case (?addr) { return addr };
      case (null) {

        var parsedUrl = parseUrl(url);
        var server = switch (List.last<Text>(parsedUrl)) {
          case (null) { return Principal.fromText("0") };
          case (?tld) { await ask(tld, Principal.fromActor(Root)) };
        };
        var counter = List.size<Text>(parsedUrl) - 1;
        while (counter > 1) {
          parsedUrl := List.drop<Text>(parsedUrl, counter);
          server := switch (List.last<Text>(parsedUrl)) {
            case (null) { return Principal.fromText("0") };
            case (?tld) { await ask(tld, server) };
          };
          counter -= 1;
        };
        let addr = askForIp(parsedUrl[0], server);
        cache.put(url, addr);
        addr
      };
    }
  };

  func ask(url: Types.URL, who: Principal) : async Principal {
    try {
      let server = actor(Principal.toText(who));
      server.ask(url)
    } catch _ {
      Log.error("Canister unreachable!");
    };
  };

  func askForIp(url: Types.URL, who: Principal) : async Types.IpAddress {
    try {
      actor(Principal.toText(who)).ask(url);
    } catch _ {
      Log.error("Canister unreachable!");
    };
  };

  func parseUrl(url: Types.URL) : List.List<Text> {
    Parsing.split(url, ".")
  };

};
