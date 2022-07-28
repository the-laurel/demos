// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface AbstractAccountsPrecompile {
    // TODO connectionId
    function sendTx(
        address to,
        address from, // removed when signature works
        uint256 value,
        uint256 gasLimit,
        bytes memory data,
        bytes memory signature
    ) external returns(bytes memory response, bytes memory error);
    
    function registerAccount() view external returns(address accountAddress);
}
