import HashMap "mo:base/HashMap";

module {

  public type Cache = HashMap.HashMap<Domain, Principal>;
  public type Domain = Text;

  public type Error = {
    #addressNotFound;
  };

};
