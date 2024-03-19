//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract ManualToken{

    mapping (address => uint256) private s_balances;  //somones balance is just some mapping in this token contract, we map an owners address to thier balance. 
            // my_address -> 10 token   meaning my address is mapped or assigned to 10 tokens. ,

    /*function name() public pure returns (string memory){      //we go to   https://eips.ethereum.org/EIPS/eip-20  and do what we were asked to do. 
        return "Manual Token";
    }  */ //instead of above we can do this below.abi

    string public name = "Manual Token";

    function totalSupply() public pure returns (uint256){   //Total supply of token. 
        return 100 ether; //1000000000000000000
    }

    function decimals() public pure returns (uint8) {  //this function here tells users that the total supply hs 18 decimals. 
        return 18;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return s_balances [_owner];
    }

    function transafer(address _to, uint256 _amount) public { //This line defines a function named transfer. This function takes two parameters: _to, which is an address where the tokens will be transferred, and _amount, which is the number of tokens to transfer. The public keyword means that this function can be called from outside the contract
        uint256 previousBalances = balanceOf(msg.sender) + balanceOf(_to);//previousBalances is declared to store the total balances of the sender (msg.sender) and the recipient (_to) before the transfer happens. balanceOf is likely a function that returns the balance of a given address.
        s_balances[msg.sender] -= _amount; //This line subtracts _amount from the balance of the sender (msg.sender). s_balances[msg.sender] likely represents the balance of the sender.
        s_balances[_to] += _amount;//This line adds _amount to the balance of the recipient (_to). s_balances[_to] likely represents the balance of the recipient.
        require(balanceOf(msg.sender) + balanceOf(_to) == previousBalances);//This line ensures that the total balance of the sender and the recipient after the transfer (balanceOf(msg.sender) + balanceOf(_to)) equals the total balance before the transfer (previousBalances). If it's not equal, the transaction will revert, meaning it will not be executed. This is a safety check to ensure that the transfer was executed correctly and that no tokens were lost or created unexpectedly during the transfer.
    }
}
