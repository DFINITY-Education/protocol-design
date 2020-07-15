import List "mo:base/List";
import Types "./Types";

actor DNS {

  let cache = HashMap.HashMap<Text, Types.IpAddress>(1, Common.principalEq, Text.hash);
  let root: Principal = ???;

  /// Retrieves the |url|'s IP address. First checks for existence in cache
  /// Args:
  ///   |url|   The URl whose IP is looked up
  /// Returns:
  ///   The IP address of the requested |url|
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
  /// Splits a |url| into its component domain labels (separated by ".")
  /// Args:
  ///   |url|   The URl to parse
  /// Returns:
  ///   A list of the corresponding domain labels for the given |url|
  parseUrl(URL) : List (domains) {
    List.List.nil(1)
  };

}
