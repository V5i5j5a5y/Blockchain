//SPDX-License-Identifier: MIT
pragma solidity ^0.6.3;

contract structSamplemodifier{

  address public Alice;

  constructor() public{
    Alice = msg.sender;
    //0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678
  }

  modifier onlyAlice(){
    assert(msg.sender == Alice);
    _;
  }

  //event
  event newLearner (string name, uint8 age);

struct learner{
  string name;
  uint8 age; //State Variables
}

//mapping 
//mapping (key => value) mapping name;
mapping(uint => learner) learners;
//1 => ("Alice", 40)
//2 => ("Tom", 25)
//3 => ("Jerry", 28)

function setLearnerDetails(uint8 _key, string memory _name, uint8 _age) public onlyAlice {
      //learners[1].name="alice"
      //learners[1].age=40
      learners[_key].name=_name;
      learners[_key].age=_age;
      emit newLearner (_name,_age);

}

function getLearnerDetails(uint8 _key) public view returns(string memory, uint8){
  return(learners[_key].name,learners[_key].age);
}
}