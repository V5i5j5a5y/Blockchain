//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract parent{

    string internal name;
    uint8 age;

    function getAge() public view returns(uint8){
        return age;
    }
}

contract child is parent {
 
    function getName() public view returns(string memory){
        return name;
    }

}

contract functionVisbility{

    string name;

    function getName() internal view returns(string memory){
        return name;
    }
}

