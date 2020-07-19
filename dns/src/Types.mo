import HashMap "mo:base/HashMap";

module {

  public type Error = {
    #addressNotFound;
    #noPermission;
  };

  public type Cache = HashMap.HashMap<Text, IpAddress>;
  public type URL = Text;
  public type IpAddress = Principal;

};
