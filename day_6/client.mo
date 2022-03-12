// Challenge 8
actor{
    public func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };

    type Result<Bool , Text> = {#ok: Bool; #announ : Text};
    let other_canister : actor { mint : () -> async Result<Bool, Text>} = actor("rrkah-fqaaa-aaaaa-aaaaq-cai");
    public shared ({caller}) func mint() : async Result<Bool, Text> {
        return(await other_canister.mint())
    };
}

//dfx deploy client
//dfx canister call client mint '()'
