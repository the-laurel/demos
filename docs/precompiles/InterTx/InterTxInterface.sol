// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/// @title A precompile for sending transactions to the Golden Gate Bridge and nBridge
/// @author The Laurel Project
/// @notice It needs at least 2 (or even more for nBridge) chains and an IBC connection between them
/// @dev Technical demos https://www.youtube.com/watch?v=ayFzY4btFX4&list=PL323JufuD9JBvmyqYtYLSe-xSSdJS9NPO
/// @custom:license This is covered by The Moral Licence - that is more strict than GPL-3.0
interface InterTxPrecompile {

    // emitTx will send the `data` to the chain that corresponds to the `connectionId`.
    // The message will carry `value` and will be signed by `signature`.
    /// @notice Sends a transaction
    /// @dev Demoed at https://www.youtube.com/watch?v=I7zYXEtMeD4
    /// @param to Address of the contract that will execute the transaction
    /// @param from Address of the sender
    /// @param value The value in Wei sent to the transaction
    /// @param gasLimit The maximum of gas that can be used
    /// @param data The calldata or transaction input
    /// @param connectionId The ID of the IBC connection
    /// @param chainID The ID of the targeted chain
    /// @param signature is 65 bytes in length and is further composed 1B + 32B + 32B (v, s, r).
    /// @return response The response bytes
    /// @return error The error bytes
    function emitTx(
        address to,
        address from, // removed when signature works
        uint256 value,
        uint256 gasLimit,
        bytes memory data,
        string memory connectionId,
        uint256 chainId,
        bytes memory signature
    ) external returns(
        bytes memory response, 
        bytes memory error
    );

    /// @notice Sends a dependent transaction
    /// @dev Demoed at https://www.youtube.com/watch?v=I7zYXEtMeD4
    /// @param to Address of the contract that will execute the transaction
    /// @param from Address of the sender
    /// @param value The value in Wei sent to the transaction
    /// @param gasLimit The maximum of gas that can be used
    /// @param data The calldata or transaction input
    /// @param connectionId The ID of the IBC connection
    /// @param chainID The ID of the targeted chain
    /// @param signature is 65 bytes in length and is further composed 1B + 32B + 32B (v, s, r).
    /// @return response The response bytes
    /// @return error The error bytes
    function emitDependentTx(
        address to,
        address from, // removed when signature works
        uint256 value,
        uint256 gasLimit,
        bytes memory data,
        string memory connectionId,
        uint256 chainId,
        bytes memory signature
    ) external returns(
        bytes memory response, 
        bytes memory error
    );


    /// @notice Sends a multi-chain transaction (sed only by the nBridge)
    /// @dev Demoed at hhttps://www.youtube.com/watch?v=12FU9iG1D08&list=PL323JufuD9JBvmyqYtYLSe-xSSdJS9NPO&index=3
    /// @param to Address of the contract that will execute the transaction
    /// @param from Address of the sender
    /// @param value The value in Wei sent to the transaction
    /// @param gasLimit The maximum of gas that can be used
    /// @param data The calldata or transaction input
    /// @param chainIdentifiers The IDs as a bit mapping to single out the chains where the transaction should be replayed. The chainIDs being the bit location of the set bits
    /// @param signature is 65 bytes in length and is further composed 1B + 32B + 32B (v, s, r).
    /// @return response The response bytes
    /// @return error The error bytes
    function emitTxMulti(
        address to,
        address from, // removed when signature works
        uint256 value,
        uint256 gasLimit,
        bytes memory data,
        uint256 chainIdentifiers,
        bytes memory signature
    ) external returns(
        bytes memory response, 
        bytes memory error
    );
}
