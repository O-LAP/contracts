# Contracts
Contracts for O-LAP

# O-LAP Delivery Request
- File: `DeliveryRequest.sol`
- Path: `delivery_request`
A contract which stores the deliver requests with following data.
```
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


    function start(uint amt, int256 str, int256 dst, bytes32 mssg) public payable {
    	...
    }
    
    
    function bid() public payable {
    	...
    }

    function assign(address assignee) public {
    	...
    }
    
    function mark_complete() public {
    	...
    }

    function claim() public {
    	...
    }

```

# O-LAP OrderRequest
- File: `DeliveryRequest.sol`
- Path: `delivery_request`
A contract which stores the following.
__INCOMPLETE CONTRACT__
