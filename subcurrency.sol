pragma solidity >=0.7.0 <0.9.0;

// The contract allows only its creator to create new coins (different issuance schemes are possible)
// Anyone can send coins to each other without a need for registering with a username and password, all u need is an ethereum keypair

contract Coin {
    //The keyword public it's making the variables
    // here accessible from the other contract
    address public minter;
    mapping(address=>uint) public balance;

    // constructor is only called when contract created
    constructor() {
        minter = msg.sender;
    }

    event Sent(address from, address to, uint amount);

    // make new coins and send them to address
    // only the owner can send these coins
    function mint(address receiver, uint amount) public{
        require(msg.sender == minter);
        balance[receiver] += amount;
    }

    error  insufficientBalance(uint requested, uint available);

    function send (address receiver, uint amount) public{
        // requires amount to be greater than amount
        if(balance[msg.sender] < amount)
        revert insufficientBalance({
            requested: amount,
            available: balance[msg.sender]
        });
        balance[msg.sender] -= amount;
        balance[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    } 

    
}