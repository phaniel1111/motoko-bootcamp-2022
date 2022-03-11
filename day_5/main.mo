import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Cycles "mo:base/ExperimentalCycles";
import Nat "mo:base/Nat";

actor {
    public func greet(name : Text) : async Text {
        return "Hello, " # name # "!";
    };

    //dfx canister call day_5 whoami '()'
    public shared({caller}) func whoami() : async Principal {
        return(caller);
    };
    
    
    //Challenge 1 :
    //dfx canister call day_5 is_anonymous '()'
    public shared({caller}) func is_anonymous() : async Bool {
        return Principal.isAnonymous(caller);
    };

    //Challenge 2 :
    let favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

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
    //dfx canister call day_5 delete_favorite_number '()'
    public shared({caller}) func delete_favorite_number () : async Text {
        if(favoriteNumber.get(caller) == null)
            return "You do not have any number";
        favoriteNumber.delete(caller);
        return "You have successfully deleted your number";
    };

    // Challenge 6 :
    //dfx canister call day_5 deposit_cycles '()'
    public func deposit_cycles(): async Nat {
        return 100_000;
    };

    // Challenge 7 :
    //dfx canister call day_5 withdraw_cycles '(200_000)'
    public func withdraw_cycles(amount : Nat): async () {
        if(Cycles.available() > amount)
            Cycles.add(amount);
    };

    // Challenge 8 : 
    //dfx canister call day_5 counter '(1)'
    stable var Counter : Nat = 0;
    public func counter(n : Nat) : async Nat {
      Counter += n;
      return Counter; 
    };

    //dfx canister call day_5 version '()'
    stable var version_number : Nat = 0;
    system func postupgrade() {
        version_number := version_number + 1;
    };
    public func version() : async Nat {
      return version_number; 
    };

};
