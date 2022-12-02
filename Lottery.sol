//SPDX-License_Identifier:MIT
pragma solidity ^0.8.9;

contract Lottery{

address payable public manager;
address payable[] public Players;

constructor(){
    manager = msg.sender;
}




}