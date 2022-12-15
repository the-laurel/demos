// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/// @title A precompile for sending transactions and messages to the Cosmos SDK
/// @author The Laurel Project
/// @notice It crosses execution engine bounds
/// @dev Technical demos are about Quasar eg: https://www.youtube.com/watch?v=PlbAWUK54PU
/// custom:license This is covered by The Moral Licence - that is more strict than GPL-3.0
interface QuasarPrecompile {

    /// @notice Sends a message from EVM to Cosmos
    /// @param msg Cosmos message (binary encoding with Protobuf - ProtoCodec)
    /// @return success Execution was a success?
    /// @return data Content of result, encoded
    function sendMsgRaw(
        bytes memory msg
    ) external returns(bool success, bytes memory data);

    /// @notice Sends a query from EVM to Cosmos
    /// @param msg Cosmos query message (binary encoding with Protobuf - ProtoCodec)
    /// @return data Content of result
    function sendQueryRaw(
        bytes memory msg
    ) external view returns(bytes memory data);
}
