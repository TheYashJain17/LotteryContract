//SPDX-License_Identifier:MIT
pragma solidity ^0.8.9;

contract Lottery{

address payable public manager;
address payable[] public Players;

mapping(address => bool) public alreadyEntered;

constructor(){
    manager = msg.sender;
}

function enterIntoLottery() payable external{

    require(msg.sender != manager,"Manager cannot participate into Lottery");

    require(alreadyEntered[msg.sender] == false,"You can enter only one time");

    require(msg.value == 1 ether,"Amount should be equal to price the Price , Which is 1 ether");

    Players.push(payable(msg.sender));

    alreadyEntered[msg.sender] = true;

}




}