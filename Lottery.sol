//SPDX-License-Identifier:MIT
pragma solidity ^0.8.9;

contract Lottery{

address payable public manager;     //Declaring Manager Variable And Making It Payable To Transfer Manager's Profit
address payable[] public players;   //Declaring Players Array And Making It Payable To transfer Winning Amount. 

mapping(address => bool) public alreadyEntered; //Mapping For Checking Player's Entry.

constructor(){
    manager = payable(msg.sender);   //Initialising Value Of Manager.
}

function enterIntoLottery() payable external{   //With This Function Anyone Can Enter Into Lottery Except Manager.

    require(msg.sender != manager,"Manager cannot participate into Lottery");

    require(alreadyEntered[msg.sender] == false,"You can enter only one time");

    require(msg.value == 1 ether,"Amount should be equal to price the Price , Which is 1 ether");  

    players.push(payable(msg.sender));

    alreadyEntered[msg.sender] = true;

}

function random() view private returns(uint){   //This Will Give Us Random Hash Value In Uint Form Which Will Help Us To Pick Winner Randomly.

    return uint(sha256(abi.encodePacked(block.timestamp , block.difficulty , players.length))); 

}

function pickWinner() external{ //With This Function Winner Will Be Picked And Only Owner Can Access This Function.

    require(msg.sender == manager,"Only Manager can call this function");

    uint totalAmt = address(this).balance;

    require(totalAmt > 10 ether,"Contract Balance is not enough to pick the winner");  

    require(players.length > 5 ,"Players are not enough to pick the winner"); 

    uint winnerAmt = totalAmt - 2 ether;

    uint managerProfit = totalAmt - winnerAmt;

    uint winnnerIndex = random()%players.length;    //This Will Give Us WinnerIndex Value.

    players[winnnerIndex].transfer(winnerAmt);  //Transfering Winning Amount To Winner. 

    manager.transfer(managerProfit);    //Transfering Manager Profit To Manager.

    players = new address payable[](0); //Reseting The Array After Picking The Winner, So That New Lottery Can Be Started.


}


function getAllPlayers() view external returns(address payable[] memory){   //This Will Give Us Addresses Of All Players Who Are Participating In The Lottery.
    return players;
}

function getContractBal() view external returns(uint){  //This Will Give Us The Balance Of The Address.
    return address(this).balance;
}

}