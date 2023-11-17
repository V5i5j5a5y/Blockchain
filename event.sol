//SPDX-License-Identifier: MIT
/*pragma solidity ^0.8.0;

contract Bidding{

uint8 price=100;

event chair (bool ReturnValue);

function BidAmount(uint _amount) public returns (bool)
{
    if(_amount>price)
    {
        emit chair(true);
    }
    return true;
}

}


*/
//  v code


pragma solidity ^0.6.0;

contract value { 
 uint price=100;

 event chair (bool ,uint);

 function PlaceBid(uint _amount) public returns (uint,bool) {
   if(_amount>price)
   {
     emit chair(true,_amount);
   }
   return (_amount, true);
 }



}
