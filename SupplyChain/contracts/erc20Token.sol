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

    uint256 private _totalSupply; // Total number of tokens
}
