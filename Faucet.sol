pragma solidity ^0.5.4;
// Our first contract is a faucet!
contract Faucet {
	 address payable owner;

   modifier onlyOwner {
     require(msg.sender == owner, "Only the contract owner can call this function");
     _;
   }

  	// Initialize Faucet contract: set owner
  	constructor() public {
  		owner = msg.sender;
  	}

    // Give out ether to anyone who asks
    function withdraw(uint withdraw_amount) public {

        // Limit withdrawal amount
        require(withdraw_amount <= 0.1 ether);
        require(address(this).balance >= withdraw_amount,
        	"Insufficient balance in faucet for withdrawal request");
        // Send the amount to the address that requested it
        msg.sender.transfer(withdraw_amount);
    }

    // Accept any incoming amount
    function () external payable {}

    // Contract destructor
    function destroy() public onlyOwner {
	    selfdestruct(owner);
    }

}
