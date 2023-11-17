// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//define the library 
library MathFunc{

    function divide (int a, int b) public pure returns(int){
        require(b!=0, "Denominator can't be 0");
        return a/b;
    }
}

//using the library 
contract LibrarySample{
    using MathFunc for int;

    function div (int a, int b) public pure returns(int){
        return a.divide(b);
    }
}