import Char "mo:base/Char";
import List "mo:base/List";
import Text "mo:base/Text";

import Types "../Types";

module {

  public func split(input: Text, delimiter: Text) : List.List<Text> {
    var list = List.nil<Text>();
    var string = "";
    for (c in Text.toIter(input)) {
      var cc = Char.toText(c);
      if (cc == delimiter) {
        list := List.push<Text>(string, list);
        string := "";
        // continue
      } else {
        string #= cc;
      }
    };
    return List.push<Text>(string, list);
  };

};
