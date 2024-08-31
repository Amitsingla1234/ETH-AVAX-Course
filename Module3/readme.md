# myToken Smart Contract

This Solidity smart contract implements an ERC20 token with minting and burning capabilities. It utilizes the OpenZeppelin library for standard ERC20 functionality and access control. The contract allows the owner to mint new tokens and enables any user to burn their own tokens. Users can also transfer tokens to others.

## Contract Overview

### State Variables

- **Inherited from ERC20**:
  - `string public name`: The name of the token (set to "myToken").
  - `string public symbol`: The symbol of the token (set to "MTKN").
  - `uint8 public decimals`: The number of decimal places the token uses (default is 18).

### Functions

#### `constructor()`

- **Logic**:
  - Initializes the ERC20 token with the name "myToken" and symbol "MTKN".
  - Mints an initial supply of 1000 tokens to the contract deployer's address.

#### `mintTokens(address to, uint amount)`

- **Parameters**:
  - `to`: The address to receive the newly minted tokens.
  - `amount`: The number of tokens to mint.

- **Logic**:
  - Can only be called by the contract owner (`onlyOwner` modifier).
  - Mints `amount` tokens to the `to` address.
  - Emits a `TokensMinted` event with the details of the minting action.

#### `burnTokens(uint amount)`

- **Parameters**:
  - `amount`: The number of tokens to burn.

- **Logic**:
  - Allows any user to burn their own tokens.
  - Requires that the user has a sufficient balance to burn.
  - Burns `amount` tokens from the caller’s balance.
  - Emits a `TokensBurned` event with the details of the burning action.

#### `transferTo(address to, uint amount)`

- **Parameters**:
  - `to`: The recipient address.
  - `amount`: The number of tokens to transfer.

- **Logic**:
  - Allows any user to transfer tokens to another address.
  - Uses the standard ERC20 `transfer` function.

### Events

- **`TokensBurned(address indexed user, uint amount)`**:
  - Emitted when tokens are burned by a user.

- **`TokensMinted(address indexed user, uint amount)`**:
  - Emitted when tokens are minted by the contract owner.

### Executing Program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at [https://remix.ethereum.org/](https://remix.ethereum.org/).

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a `.sol` extension (e.g., `myToken.sol`). Copy and paste the following code into the file:

```solidity
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
```
## License
[MIT License](../LICENSE)
