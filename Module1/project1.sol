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
