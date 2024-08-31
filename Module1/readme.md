# UtilityBilling Smart Contract

This Solidity smart contract demonstrates error handling using `require()`, `revert()`, and `assert()` statements. It manages the payment status of an electricity bill based on the number of units consumed.

## Contract Overview

### State Variables

- `uint public electricityUnits`: Stores the number of electricity units consumed.
- `bool public billPaidStatus`: Indicates whether the electricity bill has been paid.

### Functions

#### `updateElectricityBill(uint _units, bool _isBillPaid)`

This function sets the number of electricity units and updates the payment status.

- **Parameters**:
  - `_units`: The number of electricity units consumed.
  - `_isBillPaid`: A boolean indicating if the bill is paid.

- **Logic**:
  - **`require(_units > 100, "Units must be greater than 100")`**:
    - Ensures that the number of units is greater than 100.
    - If not, it reverts the transaction with the message "Units must be greater than 100".
    
  - **`if (!_isBillPaid) revert("Please pay the electricity bill")`**:
    - Checks if the bill is unpaid.
    - If true, it reverts the transaction with the message "Please pay the electricity bill".
    
  - **`assert(_isBillPaid == true)`**:
    - Asserts that the bill is paid.
    - Used as a sanity check to confirm the expected condition.

  - Updates the `electricityUnits` and `billPaidStatus` state variables if all checks pass.

### Executing Program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at [https://remix.ethereum.org/](https://remix.ethereum.org/).

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a `.sol` extension (e.g., `UtilityBilling.sol`). Copy and paste the following code into the file:

```solidity
// SPDX-License-Identifier: MIT

/*
REQUIREMENTS
Contract successfully uses require()
Contract successfully uses assert()
Contract successfully uses revert() statements
*/
pragma solidity ^0.8.20;

contract UtilityBilling {
    uint public electricityUnits;
    bool public billPaidStatus;

// Function to set the electricity bill with a require statement
    function updateElectricityBill(uint _units, bool _isBillPaid) public {
        require(_units > 100, "Units must be greater than 100");

// Revert function is used 
        if (!_isBillPaid) {
            revert("Please pay the electricity bill");
        }

// Assert function is used
        assert(_isBillPaid == true);

        electricityUnits = _units;
        billPaidStatus = _isBillPaid;
    }
}
```
## License
[MIT License](../LICENSE)
