//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract parrot
{
 
    string Result;
 
    function set(string memory Input) public

    {
        Result = Input;
    }
 
    function get() public view returns(string memory)
    {
        return Result;
    }
     
}