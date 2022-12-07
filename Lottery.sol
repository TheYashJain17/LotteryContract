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

function random() view private returns(uint){

    return uint(sha256(abi.enocdePacked(block.timestamp , block.difficulty , players.length))); 

}

function pickWinner() external{

    require(msg.sender == manager,"Only Manager can call this function");

    uint totalAmt = address(this).balance;

    require(totalAmt > 20 ether,"Contract Balance is not enough to pick the winner");

    require(players.length > 4 ,"Players are not enough to pick the winner");

    uint winnerAmt = totalAmt - 2 ether;

    uint managerProfit = totalAmt - winnerAmt;

    uint winnnerIndex = random()%players.length;

    players[winnnerIndex].transfer(winnerAmt);

    manager.transfer(managerProfit);

    players = new address payable[](0);


}


function getAllPlayers() view external returns(address payable[] memory){
    return players;
}

function getContractBal() view external returns(uint){
    return address(this).Balance;
}

}