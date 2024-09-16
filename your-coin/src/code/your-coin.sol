// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.16;

interface IERC20 {

    function totalSupply() external  view returns (uint256);
    function balanceOf(address account) external  view  returns (uint256);
    function allowance(address owner, address spender) external  view  returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed soender, uint256);
}

contract YOURCoin is IERC20 {

    string public constant name = "YOUR Coin";
    string public constant symbol = "URC";
    uint8 public  constant decimals = 18;
    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;
    uint256 totalSupply_ = 10 ether;

    constructor () {
        balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public override  view returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address tokenOwner) public override  view returns (uint256) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint256 numToken) public override returns (bool) {
        require(numToken <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - numToken;
        balances[receiver] = balances[receiver] + numToken;
        emit Transfer(msg.sender, receiver, numToken);
        return true;
    }

    function approve(address delegate, uint256 numToken) public  override  returns (bool) {
        allowed[msg.sender] [delegate] = numToken;
        emit Approval(msg.sender, delegate, numToken);
        return true;
    }

    function allowance(address owner, address delegate) public  view override  returns (uint256) {
        return allowed[owner] [delegate];
    }

    function transferFrom(address from, address to, uint256 tokens) public override returns (bool success) {
        require(tokens <= balances[msg.sender]);
        require(tokens <= allowed[from][msg.sender]);

        balances[from] = balances[from] - tokens;
        allowed[from][msg.sender] = allowed[from][msg.sender] - tokens;
        balances[to] = balances[to] + tokens;
        emit Transfer(from, to, tokens);
        return true;
    }
}