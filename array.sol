// SPDX-License-Identifier: MIT
pragma solidity ^0.6.3;

contract arraySample{
    //array --> fixed and dynamic 
    //fixed length array 
    //age[0]=38, age[1]=40........age[29]=25
    uint8[30] age;

    function setData(uint8 _index, uint8 _value) public {
        age[_index]=_value;    
    }

    function readData(uint8 _index) public view returns(uint){
        return age[_index];   
    }
 
  //dynamic array
    uint[] p;

    function setDynamicArray(uint _phoneno) public {
        p.push(_phoneno);
    }

    function readDynamicArray(uint _index) public view returns(uint){
        return p[_index];
    }
}

