pragma solidity ^0.4.0;


// @title An O-LAP Delivery Request
contract DeliveryRequest {
    
    
    // ------
    
    
    uint256 public id;
    uint public code;
    
    
    // ------
    address public owner;
    int256 public start;
    int256 public destination;
    bool public completed = false;
    uint public amount;
    uint256 public deadline;
    bytes32 public message;
    address public assigned_to;
    mapping(address => uint) public bids;
    address[] public bidders;
    uint public request_security = 0.042 ether;
    uint public bid_security = 0.007 ether;
    
    
    // ------
    
    function DeliveryRequest(uint256 deadln) public {
        require(now < deadln);
        owner = msg.sender;
        deadline = deadln;
    }
    
    
    // ------


    function start(uint amt, int256 str, int256 dst, bytes32 mssg) public payable {
        require(msg.value >= amt+request_security);
        start = str;
        destination = dst;
        amount = amt;
        message = mssg;
    }
    
    
    function bid() public payable {
        require(now < deadline);
        require(this.balance >= amount+request_security);
        require(msg.sender != owner);
        require(assigned_to == 0);
        require(!completed);
        require(msg.value == bid_security);
        require(bids[msg.sender] == 0);
        bids[msg.sender] += msg.value;
        bidders.push(msg.sender);
    }

    function assign(address assignee) public {
        require(msg.sender == owner);
        require(this.balance >= amount+request_security);
        require(now < deadline);
        require(!completed);
        require(bids[assignee] != 0);
        assigned_to = assignee;
    }
    
    function mark_complete() public {
        require(msg.sender == owner);
        require(this.balance >= amount+request_security);
        require(!completed);
        require(assigned_to != 0);
        completed = true;
        bids[assigned_to] += amount;
        msg.sender.transfer(bid_security);
    }

    function claim() public {
        if(now > deadline) {
            msg.sender.transfer(bids[msg.sender]);
        }
        assert(completed);
        assert(bids[msg.sender] != 0);
        msg.sender.transfer(bids[msg.sender]);
    }

    
    
}