pragma solidity ^0.7.1;

contract Campaign {
    struct Request {
        uint index;
        string description;
        uint value;
        address payable recipient;
        bool complete;
        uint approvalCount;
    }
    
    address public manager;
    uint256 public minimumContribution;
    mapping(address => bool) approvers;
    uint public approversCount;
    Request[] public requests;
    mapping(uint => mapping(address => bool)) requestApprovals;

    modifier restricted() {
        require(msg.sender == manager);
        _;
    }

    constructor(uint256 minimum) {
        manager = msg.sender;
        minimumContribution = minimum;
    }

    function contribute() public payable {
        require(msg.value > minimumContribution);

        approvers[msg.sender] = true;
        approversCount++;
    }

    function createRequest(string memory description, uint value, address payable recipient) 
        public restricted 
    {
        Request memory newRequest = Request({
            index: requests.length,
            description: description,
            value: value,
            recipient: recipient,
            complete: false,
            approvalCount: 0
        });

        requests.push(newRequest);
    }

    function approveRequest(uint index) public {
        Request storage request = requests[index];

        require(approvers[msg.sender]);
        require(!requestApprovals[request.index][msg.sender]);

        requestApprovals[request.index][msg.sender] = true;
        request.approvalCount++;
    }

    function finalizeRequest(uint index) public restricted {
        Request storage request = requests[index];

        require(request.approvalCount > (approversCount / 2));
        require(!request.complete);
        
        request.recipient.transfer(request.value);
        request.complete = true;
    }
}
