import Char "mo:base/Char";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Array "mo:base/Array";
import Text "mo:base/Text";

actor {

  public func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };
  //dfx deploy day_1
  
  //Challenge 1 : Write a private function swap
  private func swap(array : [var Nat], i: Nat, j: Nat) : [Nat] { 
    if(i > array.size() or i > array.size())
      Debug.trap("Wrong index"); 
    var temp = 0;
    temp := array[i];
    array[i] := array[j];
    array[j] := temp;
    return Array.freeze(array);
  };
      //TEST FOR PRIVATE FUNCTION: swap
      //dfx canister call day_1 test_swap '(vec { 1 ; 3 ; 0 }, 0 , 1)'
      public func test_swap(array: [Nat], i: Nat, j: Nat) : async [Nat]
      {
        let tmpArr : [var Nat] = Array.thaw(array);
        return swap(tmpArr, i, j);
      };
      ////////

  //Challenge 2 : Write a function init_count that takes a Nat n and returns an array [Nat] where value is equal to it's corresponding index.
  //dfx canister call day_1 init_count '(5)'
  public func init_count(n : Nat) : async [Nat]{
    let array = Array.init<Nat>(n, 0);
    for(i in range(0, n - 1))
      array[i] := i;

    return  Array.freeze(array);
  };

  //Challenge 3 : Write a function seven that takes an array [Nat] and returns "Seven is found" if one digit of ANY number is 7. Otherwise this function will return "Seven not found".
  //dfx canister call day_1 seven '(vec { 1 ; 3 ; 5 ; 2 ; 7 ; 2 })'
  //dfx canister call day_1 seven '(vec { 1 ; 3 ; 5 ; 2 ; 8 ; 2 })'
  public func seven(array : [Nat]) : async Text{ 
    for(i in array.vals())
      if(i == 7)
        return "Seven is found";
    return "Seven is not found";
  };

  //Challenge 4 : Write a function nat_opt_to_nat that takes two parameters : n of type ?Nat and m of type Nat. This function will return the value of n if n is not null and if n is null it will default to the value of m.
  //dfx canister call day_1 nat_opt_to_nat '(opt 4, 3)'
  //dfx canister call day_1 nat_opt_to_nat '(null, 3)'
  public func nat_opt_to_nat(n: ?Nat, m: Nat): async Nat{
     switch(n){
       case(null){
         return m;
       };
       case(?n){
         return n;
       };
     };
  };

  //Challenge 5 : Write a function day_of_the_week that takes a Nat n and returns a Text value corresponding to the day. If n doesn't correspond to any day it will return null .
  //dfx canister call day_1 day_of_the_week '(9)'
  //dfx canister call day_1 day_of_the_week '(5)'
  public func day_of_the_week(n: Nat): async ?Text{
    switch (n){
      case 1
        return ?"monday";
      case 2
        return ?"tuesday";
      case 3
        return ?"Wednesday";
      case 4
        return ?"Thursday";
      case 5
        return ?"Friday";
      case 6
        return ?"Saturday";
      case 7
        return ?"Sunday";
      case _
        return null;
    };
  };

  //Challenge 6 : Write a function populate_array that takes an array [?Nat] and returns an array [Nat] where all null values have been replaced by 0.
  //dfx canister call day_1 populate_array '(vec { opt 1 ; opt 3 ; null ; opt 2 ; opt 7 ; opt 2 })'
  let null_to_zero = func(n: ?Nat): Nat {
    switch(n){
      case(null)
        return 0;
      case(?n)
        return n;
    };
  };
  public func populate_array(array: [?Nat]): async [Nat] {
    return Array.map(array, null_to_zero);
  };

  //Challenge 7 : Write a function sum_of_array that takes an array [Nat] and returns the sum of a values in the array.
  //dfx canister call day_1 sum_of_array '(vec { 1 ; 3 ; 5 ; 2 ; 7 ; 2 })'
  var sum = 0;
  let _sum = func(n: Nat): Nat{
    sum+= n;
    return sum;
  };
  public func sum_of_array(array : [Nat]): async Nat{
    // the (n+1) index = (n+1) index + n index. Ex: (n1; n2; n3) -> (n1;n2 + n1;n3 + n1+n2)
    // and then output the last index, which is size - 1
    sum := 0; //Start at sum=0
    return Array.map(array, _sum)[array.size() -1];
  };

  //Challenge 8 : Write a function squared_array that takes an array [Nat] and returns a new array where each value has been squared.
  //dfx canister call day_1 squared_array '(vec { 1 ; 3 ; 5 ; 2 ; 7 ; 2 })'
  let _squared = func(n: Nat): Nat{
    return n**2;
  };
  public func squared_array(array : [Nat]): async [Nat]{
    return Array.map(array, _squared);
  };

  //Changlenge 9 : Challenge 9 : Write a function increase_by_index that takes an array [Nat] and returns a new array where each number has been increased by it's corresponding index.
  //dfx canister call day_1 increase_by_index '(vec { 1 ; 1 ; 1 ; 1 ; 1 ; 1 })'
  var i = 0;
  let _increase = func(n: Nat): Nat{
    i+=1;
    return i - 1 + n;
  };
  public func increase_by_index(array : [Nat]): async [Nat]{
    i:=0;//Start at i=0
    return Array.map(array, _increase);
  };

  //Challenge 10 : Write a higher order function contains<A> that takes 3 parameters : an array [A] , a of type A and a function f that takes a tuple of type (A,A) and returns a boolean.
  
  func contains<A>(array: [A], a: A, f: (A,A) -> Bool): Bool {
    for(i in range(0, array.size() -1))
    {
      if(f(array[i], a))
        return true;
    };
    return false;
  };

      //TEST FOR A HIGHER ORDER FUNCTION: contains<A> 
      //dfx canister call day_1 test_contains '(vec { 1 ; 3 ; 5 ; 2 ; 7 ; 2 }, )'
      let _equal = func(x : Nat, y : Nat): Bool{
        if (x == y)
          return true;
        return false;
      };
      public func test_contains(array : [Nat], a : Nat) : async Bool {
            return (contains<Nat>(array, a, _equal));
      };
      ////////// 

  class range(x : Nat, y : Int) {
    var i = x;
    public func next() : ?Nat {
      if (i > y) {
        null
      } else {
        let j = i;
        i += 1;
        ?j
      }
    };
  };
  
};
