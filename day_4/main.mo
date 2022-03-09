import Custom "custom";
import Animal "animal";
import List "mo:base/List";
import newList "list";
actor {
  public func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };
  //dfx deploy day_4

  //Challenge 1 :
  //dfx canister call day_4 fun '()'
  public type ICPer = Custom.ICPer;

  public func fun(): async ICPer{
    return{
      name = "Kiet";
      nationality = "Vietnam";
      age = 20;
      nftamount = 10;
    };
  };

  //Challenge 2 :
  public type Animal = Animal.Animal;

  //Challenge 4 :
  //dfx canister call day_4 create_animal_then_takes_a_break '("cat", 4)'
  public func create_animal_then_takes_a_break(s: Text, epoint: Nat): async Animal {
    let animal : Animal = {
      specie = s;
      enery = epoint;
    };
    return Animal.animal_sleep(animal);
  };


  //Challenge 5 : 
  public type List<Animal> = ?(Animal, List<Animal>);

  var zoo = List.nil<Animal>();

  //Challenge 6 :
  //dfx canister call day_4 push_animal '(record { enery = 4 : nat; specie = "dog" })'
  public func push_animal(a: Animal): async () {
    zoo := List.push<Animal>(a, zoo);
  };
  //dfx canister call day_4 get_animals '()'
  public func get_animals(): async [Animal] {
    return List.toArray(zoo);
  };

  //Challenge 7 : TEST
  //dfx canister call day_4 test_is_null '()'
  public func test_is_null (): async Bool{
    return newList.is_null(zoo); 
  };

  //challenge 8 : TEST
  //dfx canister call day_4 test_last '()'
  public func test_last (): async ?Animal{
    return newList.last(zoo); 
  };

  //Challenge 9 : TEST
  //dfx canister call day_4 test_size '()'
  public func test_size (): async Nat{
    return newList.size(zoo); 
  };

  //Challenge 10 : TEST
  //dfx canister call day_4 test_get '(2)'
  public func test_get (n : Nat): async ?Animal{
    if(n > newList.size(zoo))
      return null;
    return newList.get(zoo, n); 
  };

  //Challenge 11: TEST
  //dfx canister call day_4 test_reverse '()'
  public func test_reverse (): async [Animal] {
    return List.toArray(newList.reverse(zoo)); 
  };
  
};
