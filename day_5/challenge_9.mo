import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Cycles "mo:base/ExperimentalCycles";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";

actor {
    // Challenge 9 : 
    var favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);
    stable var entries : [(Principal, Nat)] = [];

    system func preupgrade() {
        entries := Iter.toArray(favoriteNumber.entries());
    };

    system func postupgrade() {
        favoriteNumber:= Hashmap.fromIter<Principal, Nat>{entries.vals(), 0, Principal.equal, Principal.hash};
        entries := [];
    };

    //
    //Challenge 2 :
    

    // Challenge 3 : 
    // a) 
    /*public shared({caller}) func add_favorite_number(n :Nat): async ()) {
        favoriteNumber.put(caller, n);
    };*/
    // b) 
    //dfx canister call day_5 show_favorite_number '()'
    public shared({caller}) func show_favorite_number () : async ?Nat {
        return favoriteNumber.get(caller);
    };

    // Challenge 4 : 
    //dfx canister call day_5 add_favorite_number '(10)'
    public shared({caller}) func add_favorite_number(n :Nat): async Text {
        if(favoriteNumber.get(caller) != null)
            return "You have already registered your number";
        favoriteNumber.put(caller, n);
        return "You have successfully registered your number";
    };  

    // Challenge 5 :
    //dfx canister call day_5 update_favorite_number '(5)'
    public shared({caller}) func update_favorite_number(n :Nat) : async Text {
        favoriteNumber.put(caller, n);
        return "You have successfully updated your number";
    };
    
};
