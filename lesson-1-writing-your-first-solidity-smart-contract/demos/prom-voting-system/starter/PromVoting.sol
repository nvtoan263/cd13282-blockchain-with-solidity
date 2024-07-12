//SPDX-License-Indentifier: MIT

pragma solidity ^0.8.19;
contract PromVoting {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;

    uint public candidatesCount;

    event VoteCast(uint candidateId);

    function addCandidate(string memory _name) public {
        candidatesCount += 1;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);

    }

    function vote(uint _candidateId) public {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID");

        candidates[_candidateId].voteCount += 1;

        emit VoteCast(_candidateId);
    }


}