// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
// 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
contract EpicToken is ERC20, Ownable, ERC20Burnable {
    struct PlayerItems {
        uint goldCoin;
        uint silverCoin;
        uint gem;
        uint magicPotion;
    }

    mapping(address => PlayerItems) public playerItems;

    // Numerical identifiers for items
    uint constant GOLD_COIN = 1;
    uint constant SILVER_COIN = 2;
    uint constant GEM = 3;
    uint constant MAGIC_POTION = 4;

    // Events
    event Minted(address indexed to, uint amount);
    event TokensTransferred(address indexed from, address indexed to, uint amount);
    event ItemRedeemed(address indexed player, uint itemId, uint price);
    event TokensBurned(address indexed from, uint amount);

    constructor() ERC20("EpicToken", "EPIC") Ownable() {}

    function mint(address _to, uint amt) external onlyOwner {
        _mint(_to, amt);
        emit Minted(_to, amt);
    }

// 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
    function transferTokens(address _to, uint amt) public {
        require(amt <= balanceOf(msg.sender), "Insufficient balance");
        _transfer(msg.sender, _to, amt);
        emit TokensTransferred(msg.sender, _to, amt);
    }

    function redeemItem(uint _itemId, uint _price) public {
        require(_itemId >= GOLD_COIN && _itemId <= MAGIC_POTION, "Invalid item ID");
        require(balanceOf(msg.sender) >= _price, "Insufficient balance");

        if (_itemId == GOLD_COIN) {
            playerItems[msg.sender].goldCoin += 1;
        } else if (_itemId == SILVER_COIN) {
            playerItems[msg.sender].silverCoin += 1;
        } else if (_itemId == GEM) {
            playerItems[msg.sender].gem += 1;
        } else if (_itemId == MAGIC_POTION) {
            playerItems[msg.sender].magicPotion += 1;
        }

        _burn(msg.sender, _price);
        emit ItemRedeemed(msg.sender, _itemId, _price);
    }

    function checkBalance() public view returns (uint) {
        return balanceOf(msg.sender);
    }
}

