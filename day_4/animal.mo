module{
    //Challenge 2:
    public type Animal = {
        specie : Text;
        enery: Nat;
    };
    //Challenge 3:
    public func animal_sleep(a : Animal): Animal{
        let animal : Animal = {
        specie = a.specie;
        enery = 10;
        };
        return animal;
    };
};
