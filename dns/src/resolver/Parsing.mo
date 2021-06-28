import Char "mo:base/Char";
import List "mo:base/List";
import Text "mo:base/Text";
import Log "mo:base/Debug";


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
      } else {
        string #= cc;
      }
    };

    list := List.push<Text>(string, list);
    var list2 = List.reverse<Text>(list);   
    list2
  };

};
