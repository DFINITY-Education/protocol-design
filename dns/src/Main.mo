import List "mo:base/List";
import Types "./Types";

actor DNS {

  let cache = HashMap.HashMap<Text, Types.IpAddress>(1, Common.principalEq, Text.hash);
  let root: Principal = ???;

  public func query(url: Types.URL) : async IP_address {
    if (in cache) return result;
    await ask(root)
  };

  func ask() : async IP_address {
    TLD = parse_url();
    for (i in TLD) {
      let result = ask(TLD:server);
      if (result != null) return result;
    };
  };

  parseUrl(URL) : List (domains) {
    List.List.nil(1)
  };

}
