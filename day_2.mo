import Char "mo:base/Char";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Prim "mo:prim";
import Text "mo:base/Text";
import Array "mo:base/Array";

actor {

  public func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };
  //dfx deploy day_1
  
  //Challenge 1 : Write a function nat_to_nat8 that converts a Nat n to a Nat8. Make sure that your function never trap.
  //dfx canister call day_1 nat_to_nat8 '(256)' 
    public func nat_to_nat8 (num : Nat) : async Nat8 
    {     
      if(num > 255)
        Debug.trap("oops!");  

      let nat8 = Nat8.fromNat(num);
      return nat8;
    };

  //Challenge 2 : Write a function max_number_with_n_bits that takes a Nat n and returns the maximum number than can be represented with only n-bits.
  //dfx canister call day_1 max_number_with_n_bits '(8)' 
    public func max_number_with_n_bits(num : Nat) : async Nat
    {
      var max_num = 0;
      var p = 0;

      while (p < num)
      {
        max_num += 2**p;
        p += 1;
      };
      return max_num;
    };

  //Challenge 3 : Write a function decimal_to_bits that takes a Nat n and returns a Text corresponding to the binary representation of this number.
  //dfx canister call day_1 decimal_to_bits '(100)' 
    public func decimal_to_bits(num : Nat) : async Text
    {
      var natBit = 0;
      var p = 0;
      var temp = num;
      while (temp > 0)
      {
        natBit += (temp % 2) * (10 ** p);
        p += 1;
        temp := temp / 2;
      };
      let bits = Nat.toText(natBit);
      return bits;
    };

    //Challenge 4 : Write a function capitalize_character that takes a Char c and returns the capitalized version of it.
    //dfx canister call day_1 capitalize_character '(97)' 
      public func capitalize_character(c : Nat32) : async Text
      {
        if (c < 97 or c > 122)
          Debug.trap("oops!");
        let char : Char = Char.fromNat32(c - 32);
        return Char.toText(char);
      };

    //Challenge 5 : Write a function capitalize_text that takes a Text t and returns the capitalized version of it.
    //dfx canister call day_1 capitalize_text '("abcdef")' 
      public func capitalize_text(t : Text) : async Text
      {
        return Text.map(t , Prim.charToUpper);
      };

    //Challenge 6 : Write a function is_inside that takes two arguments : a Text t and a Char c and returns a Bool indicating if c is inside t .
    //dfx canister call day_1 is_inside '("abcdef", 97)' 
      public func is_inside(t : Text, c : Nat32) : async Bool
      {
        for(char in t.chars())
        {
          if (Char.toNat32(char) == c)
            return true;
        };
        return false;
      };
    
    //Challenge 7: Write a function trim_whitespace that takes a text t and returns the trimmed version of t
    //dfx canister call day_1 trim_whitespace '(" abc  def ")' 
      public func trim_whitespace(t : Text): async Text
      {
        return Text.trim(t, #text " ");
      };

    //Challenge 8 : Write a function duplicated_character that takes a Text t and returns the first duplicated character in t converted to Text. 
    //dfx canister call day_1 duplicated_character '("abc a def")' 
      public func duplicated_character (t: Text) : async Text
      {
        var size = t.size();
        
        // This is a selection sort which is use i, j for positions
        var i = 0;
        var j = 0;
        for(c1 in t.chars())
        {
          for(c2 in t.chars())
          {
            if(j > i)
            {
              if (c1 == c2)
                return Char.toText(c1);
            };
            j += 1;
          };
          i += 1;
          j := 0;
        };
        return t;
      };

  //Challenge 9 : Write a function size_in_bytes that takes Text t and returns the number of bytes this text takes when encoded as UTF-8.
  //dfx canister call day_1 size_in_bytes '("abcdef")' 
    public func size_in_bytes (t: Text) : async Nat
    {
      let b : Blob = Text.encodeUtf8(t);
      return b.size();
    };

  //Challenge 10: Implement a function bubble_sort that takes an array of natural numbers and returns the sorted array .
  //dfx canister call day_1 selection_sort '(vec { 1 ; 3 ; 5 ; 2 ; 4 ; 2 })'
    public func selection_sort (arr : [Nat]) : async [Nat] {
      // Turn the array into mutable
      let tmpArr : [var Nat] = Array.thaw(arr);
      let size = tmpArr.size();
      var temp = 0;
      
      var i = 0;
      var j = 0;
      var b : Bool = false;
      label loop1 for(i in range(0, size - 2))
      {
        b := false;
        for(j in range(0, size - i - 2))
        {
          if (tmpArr[j] > tmpArr[j+1])
          {
            temp := tmpArr[j];
            tmpArr[j] := tmpArr[j+1];
            tmpArr[j+1] := temp;
            b := true;
          };
        };
        if (b == false)
          break loop1;
      };
      // Turn back to inmutable
      return Array.freeze(tmpArr);
    }; 
    
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
