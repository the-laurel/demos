// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/// @title A precompile for Account Abstractions
/// @author The Laurel Project
/// @notice https://ethereum-magicians.org/t/implementing-account-abstraction-as-part-of-eth1-x/4020
/// @dev Technical demos are at https://www.youtube.com/c/LoredanaCirstea/videos
/// @custom:license This is covered by The Moral Licence - that is more strict than GPL-3.0
interface AbstractAccountsPrecompile {
    // TODO connectionId

    /// @notice Sends a transaction as from an EOA
    /// @param signature is 65 bytes in length and is further composed 1B + 32B + 32B (v, s, r).
    /// @return error can be 0 length when response exists
    function sendTx(
        address to,
        address from, // removed when signature works
        uint256 value,
        uint256 gasLimit,
        bytes memory data,
        bytes memory signature
    ) external returns(bytes memory response, bytes memory error);
    
    /// @notice Creation of new abstract accounts
    function registerAccount() view external returns(address accountAddress);
}
