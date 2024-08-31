// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract myToken is ERC20, Ownable {

// Only contract owner should be able to mint tokens
// Any user can transfer tokens
// Any user can burn tokens

    event TokensBurned(address indexed user, uint amount);
    event TokensMinted(address indexed user, uint amount);

    constructor() ERC20("myToken", "MTKN") Ownable(msg.sender) {
        _mint(msg.sender,  1000); 
        
    }

    function mintTokens(address to, uint amount) external onlyOwner {
        _mint(to, amount);
        emit TokensMinted(msg.sender, amount);
    }

    function burnTokens(uint amount) external {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        _burn(msg.sender, amount);
        emit TokensBurned(msg.sender, amount);
    }


    function transferTo(address to, uint amount) external {
        transfer(to, amount);  
    }
}
