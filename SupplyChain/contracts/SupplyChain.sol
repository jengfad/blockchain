pragma solidity >=0.4.22 <0.8.0;

contract supplyChain {
    uint32 public p_id = 0; // Product ID
    uint32 public u_id = 0; // Participant ID
    uint32 public r_id = 0; // Registration ID

    struct product {
        string modelNumber;
        string partNumber;
        string serialNumber;
        address productOwner;
        uint32 cost;
        uint32 mfgTimeStamp;
    }
    mapping(uint32 => product) public products;

    struct participant {
        string userName;
        string password;
        string participantType;
        address participantAddress;
    }
    mapping(uint32 => participant) public participants;

    struct registration {
        uint32 productId;
        uint32 ownerId;
        uint32 trxTimeStamp;
        address productOwner;
    }
    mapping(uint32 => registration) public registrations; // Registrations by Registration ID (r_id)
    mapping(uint32 => uint32[]) public productTrack; // Registrations by Product ID (p_id) / Movement track for a product
}
