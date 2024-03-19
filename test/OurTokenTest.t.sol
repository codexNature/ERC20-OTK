//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";
import {OurToken} from "../src/OurToken.sol";
import {StdCheats} from "forge-std/StdCheats.sol";

contract OurTokenTest is StdCheats, Test {
    OurToken public ourToken;
    DeployOurToken public deployer;

    address sola = makeAddr("sola");
    address akin = makeAddr("akin");

    uint256 public constant STARTING_BALANCE = 1000 ether;

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        vm.prank(msg.sender);
        ourToken.transfer(sola, STARTING_BALANCE);
    }


    function testSolaBalance() view public {
        assertEq(STARTING_BALANCE, ourToken.balanceOf(sola));
    }

    function testAllowancesWorks() public {  //transferFrom 
        uint256 initialAllowance = 1000;
        //Sola approves Akin to spend token on his befalf. 
        vm.prank(sola);
        ourToken.approve(akin, initialAllowance);

        uint256 transferAmount = 500;

        vm.prank(akin);
        ourToken.transferFrom(sola, akin, transferAmount); //transfer and TransferFrom are different, transferFrom allows you to send funds on behalf of some other person so long you are approved by the person. 

        assertEq(ourToken.balanceOf(akin), transferAmount);
        assertEq(ourToken.balanceOf(sola), STARTING_BALANCE - transferAmount);
    }

    function testTransfer() public {
    uint256 transferAmount = 50 ether;
    vm.prank(sola);
    ourToken.transfer(akin, transferAmount);
    
    assertEq(ourToken.balanceOf(akin), transferAmount);
    assertEq(ourToken.balanceOf(sola), STARTING_BALANCE - transferAmount);
    }
/*
    function testBalanceAfterTransfer() public {
      uint256 amount = 1000;
      address receiver = address(0x1);
      uint256 initialBalance = ourToken.balanceOf(msg.sender);
      vm.prank(msg.sender);
      ourToken.transfer(receiver, amount);
      assertEq(ourToken.balanceOf(msg.sender), initialBalance - amount);
    }

    function testTransferFrom() public {   
      uint256 amount = 1000;
      address receiver = address(0x1);
      vm.prank(msg.sender);
      ourToken.approve(msg.sender, amount);
      ourToken.transferFrom(msg.sender, receiver, amount);
      assertEq(ourToken.balanceOf(receiver), amount);
    } */

    function testDecimals() view public {
        uint8 expectedDecimals = 18;

        assertEq(ourToken.decimals(), expectedDecimals);
    }

    function testSymbol() view public {
        string memory expectedSymbol = "OTK";

        assertEq(ourToken.symbol(), expectedSymbol);
    }

    function testName() view public {
        string memory expectedName = "OurToken";

        assertEq(ourToken.name(), expectedName);
    }

    function testTotalSupply() view public {
        uint256 expectedTotalSupply = STARTING_BALANCE;

        assertEq(ourToken.totalSupply(), expectedTotalSupply);
    }

}