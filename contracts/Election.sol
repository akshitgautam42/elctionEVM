pragma solidity ^0.4.25;

contract Election{
    //Model Candidate
    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }
    //Store accounts that have voted
    mapping (address=> bool) public voters;
    // Store Candidate
    //Fetch Candidate
    mapping (uint => Candidate) public candidates;
    //Store Candidate Count
    uint public candidatesCount;

   event votedEvent(
       uint indexed _candidateId
   );
   constructor () public{
       addCandidate("Candidate 1");
       addCandidate("Candidate 2");
   }
   function addCandidate(string _name) private {
       candidatesCount ++;
       candidates[candidatesCount] = Candidate(candidatesCount, _name,0);
   }

   function vote(uint _candidateId) public {
       //require that they havent voted before
       require(!voters[msg.sender]);
       //require a valid candidate
       require(_candidateId>0 && _candidateId<=candidatesCount);
       //record that voter has voted
       voters[msg.sender]=true;
       //update candidate vote count
       candidates[_candidateId].voteCount ++;
       //trigger voted event
       emit votedEvent(_candidateId);
   }
    
}