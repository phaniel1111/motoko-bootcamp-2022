import Nat "mo:base/Nat";
import Array "mo:base/Array";

actor {

  public func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };

  //Challenge 1 : Write a function add that takes two natural numbers n and m and returns the sum.
  //dfx canister call day_1 sum '(2, 3)'
    public func add (n : Nat, m : Nat) : async Nat { 
      let Sum = n + m;
      return Sum;
    };

  //Challenge 2 : Write a function square that takes a natural number n and returns the area of a square of length n.
  //dfx canister call day_1 square '(2)'
    public func square (n : Nat) : async Nat { 
      let Square = n * n;
      return Square;
    };

  //Challenge 3 : Write a function days_to_second that takes a number of days n and returns the number of seconds.
  //dfx canister call day_1 days_to_second '(2)'
    public func days_to_second (n : Nat) : async Nat { 
      let Seconds = n * 24 * 60 * 60;
      return Seconds;
    };

  //Challenge 4 : Write two functions increment_counter & clear_counter .
  //dfx canister call day_1 increment_counter '(2)'
  //dfx canister call day_1 clear_counter '()'
    var Counter : Nat = 0;
    public func increment_counter(n : Nat) : async Nat {
      Counter += n;
      return Counter; 
    };
    public func clear_counter() : async Nat {
      Counter := 0;
      return Counter;
    };

  //Challenge 5 : Write a function divide that takes two natural numbers n and m and returns a boolean indicating if n divides m.
  //dfx canister call day_1 divide '(6,3)'
    public func divide(n : Nat, m : Nat) : async Bool {
      if (m != 0){
        if (n % m == 0) 
          return true;
      };
      return false;
    };


  //Challenge 6 : Write a function is_even that takes a natural number n and returns a boolean indicating if n is even.
  //dfx canister call day_1 is_even '(2)'
    public func is_even(n : Nat) : async Bool {
      if (n % 2 == 0) {
        return true;
      };
      return false;
    };

  //Challenge 7 : Write a function sum_of_array that takes an array of natural numbers and returns the sum. This function will returns 0 if the array is empty.
  //dfx canister call day_1 sum_of_array '(vec { 1 ; 3 ; 5 })'
    public func sum_of_array(arr : [Nat]) : async Nat {
      if (arr.size() != 0) {
        var sum = 0;
        for (num in arr.vals()){
          sum += num;
        };
        return sum;
      };
      return 0;
    };

  //Challenge 8 : Write a function maximum that takes an array of natural numbers and returns the maximum value in the array. This function will returns 0 if the array is empty.
  //dfx canister call day_1 maximum '(vec { 1 ; 3 ; 5 })'
    public func maximum(arr : [Nat]) : async Nat {
      if (arr.size() != 0) {
        var max = arr[0];
        for (num in arr.vals()){
          if (num > max) 
            max := num;
        };
        return max;
      };
      return 0;
    };

  //Challenge 9 : Write a function remove_from_array that takes 2 parameters : an array of natural numbers and a natural number n and returns a new array where all occurences of n have been removed (order should remain unchanged).
  //dfx canister call day_1 remove_from_array '(vec { 1 ; 3 ; 5 }, 5)'
    public func remove_from_array(arr : [Nat], n : Nat) : async [Nat] {
      var newArr : [Nat] = [];
      for (num in arr.vals()) {
        if (n != num)
          newArr := Array.append<Nat>(newArr, [num]);
      };
      return newArr;
    };
  
  //Challenge 10 : Implement a function selection_sort that takes an array of natural numbers and returns the sorted array .
  //dfx canister call day_1 selection_sort '(vec { 1 ; 3 ; 5 ; 2 ; 4 })'
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

  public func selection_sort (arr : [Nat]) : async [Nat] {
    // Turn the array into mutable
    let tmpArr : [var Nat] = Array.thaw(arr);
    let size = tmpArr.size();
    var min_idx = 0;
    var temp = 0;
    
    for(i in range(0, size - 2)){
      min_idx := i;
      for(j in range(i + 1, size - 1)){
        if (tmpArr[j] > tmpArr[min_idx])
          min_idx := j;

        //Swap
        if(min_idx != j){
        temp := tmpArr[min_idx];
        tmpArr[min_idx] := tmpArr[j];
        tmpArr[j] := temp;
        };
      };
    };
    // Turn back to inmutable
    return Array.freeze(tmpArr);
  };

};
