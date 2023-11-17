// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Money{
    address alice = 0xdD870fA1b7C4700F2BD7f44238821C26f7392148;
    //balance --> give you the balance of the address 
    //transfer --> used to send/transfer to the address 
     // (in interview if they ask, Fallback is used to connect to an  external wallet to do transactions) fallback() external payable{}
    function getMoney() public payable {}

    function TransferMoney() public {
        payable(alice).transfer(address(this).balance);
    }
}