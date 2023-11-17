// SPDX-License-Identifier: MIT
pragma solidity ^0.6.3;

contract enumSample{

    //enumeration 
    enum Status {orderReceived, packaged, shipped, trackorder}
    Status status;

    function set() public {
        status=Status.packaged;
    }
}
