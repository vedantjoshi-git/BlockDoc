// //SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.3;

// import "./EmailRegex.sol";
// import "./StringUtils.sol";

// /** @title Accounts. */
// contract Accounts {
    
//   address private owner;
//   mapping (address => account) private accounts;
//   address[] private verifiers;
  
//   enum AccountType {Verifier, Requester}
//   struct account 
//   {
//     string name;
//     string email;
//     string logo;
//     string description;
//     AccountType aType;
//     uint verificationPrice;
//   }

//   event Registered (address user);
  
//   /** @dev check for the valid email address.
//       * @param _email email address.
//       * @return bool require.
//       */
//   modifier isEmailValid(string _email) 
//   {
//     require(EmailRegex.matches(_email));
//     _;
//   }

//   /** @dev adds verifiers address if not exists .
//       * @param _aType AccountType.
//       */
//   modifier addVerifier(AccountType _aType)
//   {
//       _;
//       if(_aType == AccountType.Verifier){
//         bool found = false;
//         for (uint i=0; i<verifiers.length; i++) {
//           if (msg.sender == verifiers[i]) {
//               found = true;
//               break; 
//           }
//         }
//         if(!found){
//             verifiers.push(msg.sender);   
//         }
//     }
//   }

//   constructor() 
//   public 
//   {
//     owner = msg.sender;
//   }

//   /** @dev update user account details.
//       * @param _name user name.
//       * @param _email user email.
//       * @param _logo user logo.
//       * @param _description user description.
//       * @param _aType user aType.
//       * @param price document verification price.
//       */
//   function register(string _name, string _email, string _logo, string _description, AccountType _aType, uint price) 
//   public 
//   payable
//   isEmailValid(_email)
//   addVerifier(_aType)
//   {
//     emit Registered(msg.sender);
//     accounts[msg.sender] = account({
//       name: _name, 
//       email: _email, 
//       logo: _logo, 
//       description: _description,
//       aType: _aType,
//       verificationPrice: price
//     });
//   }

//   /** @dev get user account details.
//       * @return _name user name.
//       * @return _email user email.
//       * @return _logo user logo.
//       * @return _description user description.
//       * @return _aType user aType.
//       * @return price document verification price.
//       */
//   function getAccount() 
//   public 
//   view 
//   returns (string name, string email, string logo, string description, AccountType aType, uint price) 
//   {
//     name = accounts[msg.sender].name;
//     email = accounts[msg.sender].email;
//     logo = accounts[msg.sender].logo;
//     description = accounts[msg.sender].description;
//     aType = accounts[msg.sender].aType;
//     price = accounts[msg.sender].verificationPrice;
//     return (name, email, logo, description, aType, price);
//   }

//   /** @dev get verifiers count.
//       * @return total verifiers count.
//       */
//   function verifiersCount() 
//   public 
//   view 
//   returns (uint total) {
//       return verifiers.length;
//   }

//   /** @dev get verifier details.
//       * @param pIndex index number.
//       * @return verifierAddr verifier address.
//       * @return _name user name.
//       * @return _email user email.
//       * @return _logo user logo.
//       * @return _description user description.
//       * @return _aType user aType.
//       * @return price document verification price.
//       */
//   function getVerifier(uint pIndex)
//   public 
//   view
//   returns (address verifier, string name, string email, string logo, string description, AccountType aType, uint price) 
//   {
//     address verifierAddr = verifiers[pIndex];
//     name = accounts[verifierAddr].name;
//     email = accounts[verifierAddr].email;
//     logo = accounts[verifierAddr].logo;
//     description = accounts[verifierAddr].description;
//     aType = accounts[verifierAddr].aType;
//     price = accounts[verifierAddr].verificationPrice;
//     return (verifierAddr, name, email, logo, description, aType, price);
//   }
  
//   /** @dev get verification price of verifier.
//       * @param _account verifier address.
//       * @return price document verification price.
//       */
//   function getPrice(address _account)
//   public 
//   view
//   returns(uint price){
//     return (accounts[_account].verificationPrice);
//   }

//   /** @dev kill smart contract if something bad happens.
//       */
//   function kill() 
//   public 
//   {
//     if (msg.sender == owner) selfdestruct(owner);
//   }
  
// }


pragma solidity ^0.8.3;

import "./EmailRegex.sol";
import "./StringUtils.sol";

contract Accounts {
    address private owner;
    mapping(address => Account) private accounts;
    address[] private verifiers;

    enum AccountType { Verifier, Requester }

    struct Account {
        string name;
        string email;
        string logo;
        string description;
        AccountType aType;
        uint verificationPrice;
    }

    event Registered(address user);

    modifier isEmailValid(string memory _email) {
        require(EmailRegex.matches(_email), "Invalid email format");
        _;
    }

    modifier addVerifier(AccountType _aType) {
        _;
        if (_aType == AccountType.Verifier) {
            bool found = false;
            for (uint i = 0; i < verifiers.length; i++) {
                if (msg.sender == verifiers[i]) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                verifiers.push(msg.sender);
            }
        }
    }

    constructor() {
        owner = msg.sender;
    }

    function register(
        string memory _name,
        string memory _email,
        string memory _logo,
        string memory _description,
        AccountType _aType,
        uint _price
    )
        public
        payable
        isEmailValid(_email)
        addVerifier(_aType)
    {
        emit Registered(msg.sender);
        accounts[msg.sender] = Account({
            name: _name,
            email: _email,
            logo: _logo,
            description: _description,
            aType: _aType,
            verificationPrice: _price
        });
    }

    function getAccount()
        public
        view
        returns (
            string memory name,
            string memory email,
            string memory logo,
            string memory description,
            AccountType aType,
            uint price
        )
    {
        Account storage userAccount = accounts[msg.sender];
        return (
            userAccount.name,
            userAccount.email,
            userAccount.logo,
            userAccount.description,
            userAccount.aType,
            userAccount.verificationPrice
        );
    }

    /** @dev get verifiers count.
//       * @return total verifiers count.
//       */
  function verifiersCount() 
  public 
  view 
  returns (uint total) {
      return verifiers.length;
  }

    /** 
   * @dev Get verifier details.
   * @param pIndex Index number.
   * @return verifier Verifier address.
   * @return name User name.
   * @return email User email.
   * @return logo User logo.
   * @return description User description.
   * @return aType User account type.
   * @return price Document verification price.
   */
  function getVerifier(uint pIndex)
    public
    view
    returns (
        address verifier,
        string memory name,
        string memory email,
        string memory logo,
        string memory description,
        AccountType aType,
        uint price
    )
{
    require(pIndex < verifiers.length, "Index out of bounds");

    address verifierAddr = verifiers[pIndex];
    Account storage verifierAccount = accounts[verifierAddr];

    return (
        verifierAddr,
        verifierAccount.name,
        verifierAccount.email,
        verifierAccount.logo,
        verifierAccount.description,
        verifierAccount.aType,
        verifierAccount.verificationPrice
    );
}
  
  /** @dev get verification price of verifier.
      * @param _account verifier address.
      * @return price document verification price.
      */
  function getPrice(address _account)
  public 
  view
  returns(uint price){
    return (accounts[_account].verificationPrice);
  }

//   /** @dev kill smart contract if something bad happens.
//       */
    function kill() public {
        if (msg.sender == owner) selfdestruct(payable(owner));
    }
}
