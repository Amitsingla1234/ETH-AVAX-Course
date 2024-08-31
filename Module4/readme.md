# EpicToken Smart Contract

This Solidity smart contract implements an ERC20 token with additional features for redeeming items and burning tokens. It leverages the OpenZeppelin library for standard ERC20 functionality and includes functionalities for minting tokens, transferring tokens, redeeming items, and burning tokens.

## Contract Overview

### State Variables

- **Inherited from ERC20**:
  - `string public name`: The name of the token (set to "EpicToken").
  - `string public symbol`: The symbol of the token (set to "EPIC").
  - `uint8 public decimals`: The number of decimal places the token uses (default is 18).

- **PlayerItems Struct**:
  - `uint goldCoin`: The number of gold coins a player has.
  - `uint silverCoin`: The number of silver coins a player has.
  - `uint gem`: The number of gems a player has.
  - `uint magicPotion`: The number of magic potions a player has.

- **Mapping**:
  - `mapping(address => PlayerItems) public playerItems`: Maps player addresses to their item holdings.

### Numerical Identifiers for Items

- `uint constant GOLD_COIN = 1`: Identifier for gold coin.
- `uint constant SILVER_COIN = 2`: Identifier for silver coin.
- `uint constant GEM = 3`: Identifier for gem.
- `uint constant MAGIC_POTION = 4`: Identifier for magic potion.

### Functions

#### `constructor()`

- **Logic**:
  - Initializes the ERC20 token with the name "EpicToken" and symbol "EPIC".
  - Sets the contract deployer as the owner.

#### `mint(address _to, uint amt)`

- **Parameters**:
  - `_to`: The address to receive the newly minted tokens.
  - `amt`: The number of tokens to mint.

- **Logic**:
  - Can only be called by the contract owner (`onlyOwner` modifier).
  - Mints `amt` tokens to the `_to` address.
  - Emits a `Minted` event with the details of the minting action.

#### `transferTokens(address _to, uint amt)`

- **Parameters**:
  - `_to`: The recipient address.
  - `amt`: The number of tokens to transfer.

- **Logic**:
  - Allows any user to transfer tokens to another address.
  - Requires that the sender has a sufficient balance.
  - Uses the standard ERC20 `transfer` function.
  - Emits a `TokensTransferred` event with the details of the transfer.

#### `redeemItem(uint _itemId, uint _price)`

- **Parameters**:
  - `_itemId`: The identifier of the item to redeem.
  - `_price`: The number of tokens required to redeem the item.

- **Logic**:
  - Allows users to redeem items using their tokens.
  - Validates the item ID and ensures the sender has enough tokens.
  - Updates the player's item holdings and burns the tokens used.
  - Emits an `ItemRedeemed` event with the details of the redemption.

#### `checkBalance()`

- **Returns**:
  - The token balance of the caller.

- **Logic**:
  - Provides the balance of tokens held by the caller.

### Events

- **`Minted(address indexed to, uint amount)`**:
  - Emitted when tokens are minted.

- **`TokensTransferred(address indexed from, address indexed to, uint amount)`**:
  - Emitted when tokens are transferred between addresses.

- **`ItemRedeemed(address indexed player, uint itemId, uint price)`**:
  - Emitted when a player redeems an item.

- **`TokensBurned(address indexed from, uint amount)`**:
  - Emitted when tokens are burned.

### Executing Program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at [https://remix.ethereum.org/](https://remix.ethereum.org/).

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a `.sol` extension (e.g., `EpicToken.sol`). Copy and paste the following code into the file:

```solidity
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
```
## License
[MIT License](../../LICENSE)
