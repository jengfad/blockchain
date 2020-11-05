// ----------------------------------------------------------------------------
// ERC Token Standard #20 Interface
// https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md
// ----------------------------------------------------------------------------

pragma solidity >=0.4.22 <0.8.0;

abstract contract ERC20Interface {
    // uint256 public totalSupply;

    function totalSupply() public virtual view returns (uint256);

    function balanceOf(address tokenOwner)
        public
        virtual
        view
        returns (uint256 balance);

    function allowance(address tokenOwner, address spender)
        public
        virtual
        view
        returns (uint256 remaining);

    function transfer(address to, uint256 tokens)
        public
        virtual
        returns (bool success);

    function approve(address spender, uint256 tokens)
        public
        virtual
        returns (bool success);

    function transferFrom(
        address from,
        address to,
        uint256 tokens
    ) public virtual returns (bool success);

    event Transfer(address indexed from, address indexed to, uint256 tokens);
    event Approval(
        address indexed tokenOwner,
        address indexed spender,
        uint256 tokens
    );
}
