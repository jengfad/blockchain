// ----------------------------------------------------------------------------
///Implements EIP20 token standard: https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md
// ----------------------------------------------------------------------------

pragma solidity >=0.4.22 <0.8.0;

import "./erc20Interface.sol";

abstract contract ERC20Token is ERC20Interface {
    uint256 private constant MAX_UINT256 = 2**256 - 1;
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowed;
    string public name; // Descriptive name (i.e. For Dummies Token)
    uint8 public decimals; // How many decimals to use to display amounts
    string public symbol; // Short identifier for token (i.e. FDT)

    uint256 private tokenTotalSupply; // Total number of tokens

    constructor(
        uint256 _initialAmount,
        string memory _tokenName,
        uint8 _decimalUnits,
        string memory _tokenSymbol
    ) {
        balances[msg.sender] = _initialAmount; // The creator owns all tokens
        tokenTotalSupply = _initialAmount; // Update total token supply
        name = _tokenName; // Token name
        decimals = _decimalUnits; // Number of decimals
        symbol = _tokenSymbol; // Token symbol
    }

    function transfer(address _to, uint256 _value) public override returns (bool success) {
        require(_value >= 0,"Cannot transfer negative amount.");
        require(balances[msg.sender] >= _value,"Insufficient funds.");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool success) {
        uint256 allowance = allowed[_from][msg.sender];
        require(balances[_from] >= _value && allowance >= _value,"Insufficient funds.");
        balances[_from] -= _value;
        balances[_to] += _value;
        if (allowance < MAX_UINT256) {
            allowed[_from][msg.sender] -= _value;
        }
        emit Transfer(_from, _to, _value);
        return true;
    }

    function balanceOf(address _owner) public override view returns (uint256 balance) {
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value) public override returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public override view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }

    function totalSupply() public override view returns (uint256 totSupp) {
        return tokenTotalSupply;
    }
}
