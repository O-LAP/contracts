pragma solidity ^0.4.0;


// @title An O-LAP Delivery Request
contract DeliveryRequest {
    
    
    // ------
    
    
    uint256 public id;
    uint public code;
    
    
    // ------
    address public owner;
    int256 public source;
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


    function getBidCount() public constant returns(uint count) {
        return bidders.length;
    }
    
    
    // ------


    event Init(uint256 deadline, int256 src, int256 destination, uint256 amount, bytes32 message);
    event Bid(address bidder);
    event AssignedTo(address assignee);
    event MarkedComplete(uint amount);
    event Claimed(address claimant, uint amount);
    
    function DeliveryRequest(uint256 deadln) public {
        require(now < deadln);
        owner = msg.sender;
        deadline = deadln;
        completed = false;
    }
    
    
    // ------


    function init(uint amt, int256 src, int256 dst, bytes32 mssg) public payable {
        require(msg.value >= amt+request_security);
        source = src;
        destination = dst;
        amount = amt;
        message = mssg;
        emit Init(deadline, source, destination, amount, mssg);
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
        emit Bid(msg.sender);
    }

    function assign(address assignee) public {
        require(msg.sender == owner);
        require(this.balance >= amount+request_security);
        require(now < deadline);
        require(!completed);
        require(bids[assignee] != 0);
        assigned_to = assignee;
        emit AssignedTo(assignee);
    }
    
    function mark_complete() public {
        require(msg.sender == owner);
        require(this.balance >= amount+request_security);
        require(!completed);
        require(assigned_to != 0);
        completed = true;
        bids[assigned_to] += amount;
        msg.sender.transfer(bid_security);
        emit MarkedComplete(amount);
    }

    function claim() public {
        if(now > deadline) {
            msg.sender.transfer(bids[msg.sender]);
            emit Claimed(msg.sender, bids[msg.sender]);
            return;
        }
        assert(completed);
        assert(bids[msg.sender] != 0);
        assert(this.balance >= bids[msg.sender]);
        msg.sender.transfer(bids[msg.sender]);
        emit Claimed(msg.sender, bids[msg.sender]);
    }

    
    
}