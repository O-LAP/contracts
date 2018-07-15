pragma solidity ^0.4.0;


// @title An O-LAP Delivery Request
contract DeliveryRequest {
    
    
    // ------
    
    
    uint256 id;
    uint code;
    
    
    // ------
	address public owner;
	int256 public start;
	int256 public destination;
	bool public completed = false;
	int public amount;
	uint256 public deadline;
	bytes32 public message;
	address public assigned_to;
	mapping(address => int) public bids;
	address[] public bidders;
	int public request_security = 0.042 ether;
	int public bid_security = 0.007 ether;
    
    
    // ------
    
    constructor(int amt, int256 str, int256 dst, byte32 msg, uint256 deadln) public {
    	require(message.amount > amt+request_security);
		require(now > deadln);
		owner = message.sender;
		start = str;
		destination = dst;
		completed = false;
		amount = msg.amount;
		deadline = deadln;
		message = msg.data;
    }
    
    
    // ------
    
    
	function bid() public {
		require(now < deadline);
		// require(msg.value > bid_security);
		bids[msg.sender] += msg.value;
		bidders.add(msg.sender);
	}

	function assign(address assignee) public {
		require(msg.sender != owner);
		require(now < deadline);
		require(bids[assignee] != 0);
		assigned_to = assignee;
	}
    
    
    // fix this
	function mark_complete() public {
		require(msg.sender == owner);
		if(now > deadline && assigned_to != 0) { 
		    msg.sender.transfer(bid_security);
		}
		else {
    		completed = true;
		    msg.sender.transfer(bid_security);
		}
	}

	function claim() public {
		if(now > deadline) {
			return bids[message.sender];
		};
		if(message.sender == owner) throw;
		if(!completed) throw;
		if(bids[message.sender] == 0) throw;
		if(message.sender != assigned_to) throw;
		return bids[message.sender];
	}

    
    
}