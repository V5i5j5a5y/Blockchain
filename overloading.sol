// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract overloadingSample{

     string name;
     uint8 age;

     //function overloading

     function setDetails(string memory _name, uint8 _age) public {
         name=_name;
         age=_age;
     }

     function setDetails(string memory _name) public {
         name=_name;
     }

      function setDetails(uint8 _age) public {
         age=_age;
     }

}