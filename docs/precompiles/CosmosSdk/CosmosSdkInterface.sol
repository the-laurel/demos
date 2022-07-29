// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/// @title A precompile for sending transactions and messages to the Cosmos SDK
/// @author The Laurel Project
/// @notice It crosses execution engine bounds
/// @dev Technical demos are about Quasar eg: https://www.youtube.com/watch?v=PlbAWUK54PU
/// custom:license This is covered by The Moral Licence - that is more strict than GPL-3.0
interface CosmosSdkPrecompile {
    // msgType
    // "/cosmos.bank.v1beta1.MsgSend"
    // "/cosmos.gov.v1beta1.MsgVote"

    /// @notice Sends a message from EVM to Cosmos
    /// @param msgType Type of message
    /// @param msg Content of message
    /// @param signature is 65 bytes in length and is further composed 1B + 32B + 32B (v, s, r).
    /// @return data Content of result
    function sendMsg(
        string memory msgType,
        bytes memory msg,
        bytes memory signature
    ) external returns(
        bool success, 
        bytes memory data
    );
}
