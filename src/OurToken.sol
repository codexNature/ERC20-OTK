//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract OurToken is ERC20{   //If our inherited contract i.e ERC20.sol has a constructor we need to use that in our constructor
    constructor(uint256 initialSupply) ERC20("OurToken", "OTK"){  //The ERC20 here is passing the ERC20.sol contract's constructor into our constructor. 
        _mint(msg.sender, initialSupply); //minting the inital supply
    }
}