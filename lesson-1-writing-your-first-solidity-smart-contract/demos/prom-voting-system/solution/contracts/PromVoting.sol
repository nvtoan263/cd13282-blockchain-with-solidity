// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract PromVoting {
    // Define a struct to hold candidate details
    struct Candidate {
        uint id; // Unique identifier for the candidate
        string name;
        uint voteCount;
    }

    struct Vote {
        uint candidateId;
        uint timeStamp;
    }

    // Mapping from candidate ID to Candidate struct for storing candidates
    mapping(uint => Candidate) public candidates;

    mapping (address =>Vote) votes;

    // Counter for the total number of candidates
    uint public candidatesCount;

    uint public totalVotes;

    uint public startTime;
    uint public endTime;

    // Event to be emitted when a vote is cast
    event VoteCast(uint candidateId, uint timeStamp);

    constructor(uint _votingDuration) {
        startTime = block.timestamp;
        endTime = startTime + _votingDuration;
    }

    // Function to add a new candidate to the election
    function addCandidate(string memory _name) public {
        candidatesCount += 1;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    // Function to vote for a candidate
    function vote(uint _candidateId) public {
        require(block.timestamp >= startTime && block.timestamp <= endTime, "Voting is not open");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID");
        // Increment the candidate's vote count
        candidates[_candidateId].voteCount += 1;

        totalVotes += 1;

        // Emit a vote event
        emit VoteCast(_candidateId, block.timestamp);
    }

    // Function to get the vote count for a specific candidate
    function getCandidateVoteCount(uint _candidateId) public view returns (uint) {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID");
        return candidates[_candidateId].voteCount;
    }

    function getTotalVotes() public view returns (uint) {
        return totalVotes;
    }
}
