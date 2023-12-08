//SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.3;

// library StringUtils {
//   /// @dev Does a byte-by-byte lexicographical comparison of two strings.
//   /// @return a negative number if `_a` is smaller, zero if they are equal
//   /// and a positive numbe if `_b` is smaller.
//   function compare(string memory _a, string memory _b) public pure returns (int) {
//       bytes memory a = bytes(_a);
//       bytes memory b = bytes(_b);
//       uint minLength = a.length;
//       if (b.length < minLength) minLength = b.length;
//       //@todo unroll the loop into increments of 32 and do full 32 byte comparisons
//       for (uint i = 0; i < minLength; i ++)
//         if (a[i] < b[i])
//           return -1;
//         else if (a[i] > b[i])
//           return 1;
//       if (a.length < b.length)
//         return -1;
//       else if (a.length > b.length)
//         return 1;
//       else
//         return 0;
//   }
//   /// @dev Compares two strings and returns true iff they are equal.
//   function equal(string memory _a, string memory _b) public pure returns (bool) {
//       return compare(_a, _b) == 0;
//   }
//   /// @dev Finds the index of the first occurrence of _needle in _haystack
//   function indexOf(string memory _haystack, string memory _needle) public pure returns (int)
//   {
//     bytes memory h = bytes(_haystack);
//     bytes memory n = bytes(_needle);
//     if(h.length < 1 || n.length < 1 || (n.length > h.length)) 
//       return -1;
//     // since we have to be able to return -1 (if the char isn't found or input error), 
//     // this function must return an "int" type with a max length of (2^128 - 1)
//     else if(h.length > (2**128 -1)) 
//       return -1;                                  
//     else
//     {
//       uint subindex = 0;
//       for (uint i = 0; i < h.length; i ++)
//       {
//         if (h[i] == n[0]) // found the first char of b
//         {
//           subindex = 1;
//           // search until the chars don't match or until we reach the end of a or b
//           while(subindex < n.length && (i + subindex) < h.length && h[i + subindex] == n[subindex]) 
//           {
//             subindex++;
//           }   
//           if(subindex == n.length)
//             return int(i);
//         }
//       }
//       return -1;
//     }   
//   }
// }

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

library StringUtils {
    function compare(string memory _a, string memory _b) internal pure returns (int) {
        bytes memory a = bytes(_a);
        bytes memory b = bytes(_b);

        require(a.length == b.length, "Strings must be of equal length for comparison.");

        for (uint i = 0; i < a.length; i++) {
            if (a[i] < b[i]) return -1;
            if (a[i] > b[i]) return 1;
        }
        return 0;
    }

    function equal(string memory _a, string memory _b) internal pure returns (bool) {
        return compare(_a, _b) == 0;
    }

    function indexOf(string memory _haystack, string memory _needle) internal pure returns (int) {
        bytes memory haystack = bytes(_haystack);
        bytes memory needle = bytes(_needle);

        require(needle.length > 0, "Needle length must be greater than 0.");
        require(haystack.length >= needle.length, "Haystack length must be greater than or equal to needle length.");

        uint n = needle.length;
        uint h = haystack.length - n + 1;

        for (uint i = 0; i < h; i++) {
            bool found = true;
            for (uint j = 0; j < n; j++) {
                if (haystack[i + j] != needle[j]) {
                    found = false;
                    break;
                }
            }
            if (found) return int(i);
        }
        return -1;
    }
}
