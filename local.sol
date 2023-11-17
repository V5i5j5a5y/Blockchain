// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract local{

    uint amount; 
    uint age;
    string name;

    //local variable
    //view: read the details from the blockchain 
    //pure: not be able to read the details from the blockchain 

    function getvalue() public pure returns(uint){
        uint value;
        return value;
    }

    function hello() public pure returns(string memory){
        return "hello everyone!";
    
    }
}