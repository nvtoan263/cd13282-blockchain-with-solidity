//SPDX-License-Indentifier: MIT
pragma solidity ^0.8.19;

contract EventTicketing {

    struct Ticket {
        string name;
        uint ticketId;
        bool isUsed;
    }
    mapping (uint => Ticket) public soldTickets;
    string public eventName;
    uint public totalTicket;
    uint private soldTicketsCounter;

    event TicketPurchase(uint ticketId);

    function setEventDetails(string memory _eventName, uint _totalTicket) private {
        require(bytes(_eventName).length > 0, "Event name cannot be empty");
        require(_totalTicket > 0, "Total tickets must be > 0");
        eventName = _eventName;
        totalTicket = _totalTicket;
    }

    function purchaseTicket(string memory _name) public {
        require(soldTicketsCounter < totalTicket, "Invalid ticket purchasing");
        soldTicketsCounter += 1;
        soldTickets[soldTicketsCounter] = Ticket(_name, soldTicketsCounter, false);
        emit TicketPurchase(soldTicketsCounter);
    }
    function useTicket(uint _ticketId) public {
        require(_ticketId > 0 && _ticketId < totalTicket, "Ticket is invalid");
        Ticket storage ticket = soldTickets[_ticketId];
        require(ticket.isUsed == false, "Ticket is already used");
        ticket.isUsed = true;
    }
}
