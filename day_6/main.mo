
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Result "mo:base/Result";
import Nat "mo:base/Nat";
import Error "mo:base/Error";
import Nat32 "mo:base/Nat32";
import Hash "mo:base/Hash";
import List "mo:base/List";
import HTTP "http";
import Text "mo:base/Text";
import Option "mo:base/Option";
import Iter "mo:base/Iter";
import Array "mo:base/Array";

actor {
  public func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };

  // Challenge 1 : 
  type TokenIndex = Nat;

  // Challenge 2 :
  var registry = HashMap.HashMap<TokenIndex, Principal>(0, Nat.equal, Hash.hash);
  
  //Challenge 7:
  stable var entries : [(TokenIndex, Principal)] = [];

  system func preupgrade() {
      entries := Iter.toArray(registry.entries());
  };
  system func postupgrade() {
    registry := HashMap.fromIter<TokenIndex, Principal>(entries.vals(), 0, Nat.equal, Hash.hash);
    entries := [];
  };

  // Challenge 3 : 
  // dfx canister call day_6 mint '()'
  stable var nextTokenIndex : Nat = 0;

  type Result<Bool , Text> = {#ok: Bool; #announ : Text};
  public shared ({caller}) func mint() : async Result<Bool, Text> {
    if(Principal.isAnonymous(caller)){
      return #announ("Show yourself");
    } else {
      
      registry.put(nextTokenIndex, caller); 
      nextTokenIndex += 1;
      return #ok(true);
      }
    };

  // Challenge 4 : 
  // dfx canister call day_6 transfer '("", 2)'
  public func transfer(to : Principal, tokenIndex : Nat) : async Result<Bool, Text>{
    if (tokenIndex < registry.size())
      return #announ("NFT does not exist.");
    if (Principal.isAnonymous(to))
      return #announ("Invalid Principal ID");
    switch(?registry.replace(tokenIndex, to)){
    case (null)
      return #ok(true);
    case (?id)
      return #announ("Sent to " # Principal.toText(to));
    };
  };



  // Challenge 5 :
  public type List<TokenIndex> = ?(TokenIndex, List<TokenIndex>);

  var nftlist = List.nil<TokenIndex>();
  // dfx canister call day_6 balance '()'
  public shared ({caller}) func balance() : async List<TokenIndex> {
    for( (K,V) in registry.entries()){
      if ( caller == V)
        {
          nftlist := List.push<TokenIndex>(K, nftlist);
        };
    };
    return nftlist;
  };

  // Challenge 6 : 
  //dfx canister call day_6 http_request '(record {"body"= blob "abc"; "headers"=vec{record{"field1";"field2"};record{"field3";"field4"}};"method"="method text";"url"="urlpath.com"})'
  public query func http_request(request : HTTP.Request) : async HTTP.Response {
    //
    let lastToken = registry.size(); // Nat
    let lastPrID = registry.get(lastToken - 1); // Principal
    let lastPrID1 = Option.get(lastPrID, Principal.fromText("2vxsx-fae"));

    let response = {
      body = Text.encodeUtf8("Token: " # Nat.toText(lastToken - 1) # ", Principal: " # Principal.toText(lastPrID1)) ;
      headers = [("Content-Type", "text/html; charset=UTF-8")];
      status_code = 200 : Nat16;
      streaming_strategy = null
      };
      return(response);
    };
};
