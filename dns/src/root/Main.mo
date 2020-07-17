import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Text "mo:base/Text";

import Types "../Types";
import Utils "../Utils";

actor {

  let db = HashMap.HashMap<Types.URL, Principal>(1, Utils.urlEq, Text.hash);

  public shared(msg) func ask(tld : Types.URL) : async ?Principal {
    db.get(tld)
  };

};
