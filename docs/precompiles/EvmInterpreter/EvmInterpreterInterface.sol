// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/// @title A precompile for an EVM Interpreter
/// @author The Laurel Project
/// @notice It helps at developing and debugging in a consensus env
/// @dev Technical demos are at https://www.youtube.com/c/LoredanaCirstea/videos
/// custom:license This is covered by The Moral Licence - that is more strict than GPL-3.0
interface EvmInterpreterPrecompile {

    /// @notice Analyzes a fragment of bytecode
    /// @dev Demoed at https://www.youtube.com/watch?v=kHDxDiM5xvQ&list=PL323JufuD9JCE_pGDLHJN-wVBpCPc9Q1G&index=8
    /// @param bytecodeFrag Any legal EVM bytecode portion
    /// @param stack The EVM Stack configuration before this bytecode is executing
    /// @param gas The available gas in Wei
    /// @param value The value in Wei sent to the transaction
    /// @return pc The Pointer Counter - position of the execution in the bytecode
    /// @return reads Number of reads from storage executed
    /// @return writes Number of slot writes into storage
    /// @return calls Number of external (other) contract calls
    /// @return memsize How many bytes of memory had been used
    /// @return gasused How much gas is left
    /// @return stackOut The EVM Stack configuration after this bytecode is executing
    function analyzeFrag(
        bytes memory bytecodeFrag,
        bytes32[] memory stack,
        uint256 gas,
        uint256 value
    ) view external returns (
        uint256 pc,
        uint256 reads,
        uint256 writes,
        uint256 calls,
        uint256 memsize,
        uint256 gasused,
        bytes32[] memory stackOut
    );
   
    /// @notice Analyzes a contract call
    /// @param bytecode Any legal EVM bytecode (for a presumtive contract)
    /// @param input The EVM transaction calldata (for that contract)
    /// @param gas The available gas in Wei
    /// @param value The value in Wei sent to the transaction
    /// @return pc The Pointer Counter - position of the execution in the bytecode
    /// @return reads Number of reads from storage executed
    /// @return writes Number of slot writes into storage
    /// @return calls Number of external (other) contract calls
    /// @return memsize How many bytes of memory had been used
    /// @return gasused How much gas is left
    /// @return output The call result
    function analyze(
        bytes memory bytecode,
        bytes memory input,
        uint256 gas,
        uint256 value
    ) view external returns (
        uint256 pc,
        uint256 reads,
        uint256 writes,
        uint256 calls,
        uint256 memsize,
        uint256 gasused,
        bytes memory output
    );
    
    /// @notice Executes (immutably) a contract call
    /// @param bytecode Any legal EVM bytecode (for a presumtive contract)
    /// @param input The EVM transaction calldata (for that contract)
    /// @param gas The available gas in Wei
    /// @param value The value in Wei sent to the transaction
    /// @return result The call result
    function interpret(
        bytes memory bytecode,
        bytes memory input,
        uint256 gas,
        uint256 value
    ) view external returns (
        bytes memory result
    );
    
    /// @notice Describes the side effects of a call
    /// @param readHashInitial Previous reads side effects (for chaining transactions)
    /// @param writeHashInitial Previous writes side effects (for chaining transactions)
    /// @param bytecode Any legal EVM bytecode (for a presumtive contract)
    /// @param input The EVM transaction calldata (for that contract)
    /// @param gas The available gas in Wei
    /// @param value The value in Wei sent to the transaction
    /// @return readHash The read hash after of the execution of this call
    /// @return writeHash The write hash after of the execution of this call
    /// @return result The call result
    function part(
        bytes32 readHashInitial,
        bytes32[] memory writeHashInitial,
        bytes memory bytecode,
        bytes memory input,
        uint256 gas,
        uint256 value
    ) view external returns (
        bytes32 readHash,
        bytes32[] memory writeHash,
        bytes memory result
    );
    
    /// @notice Describes the side effects of executing a fragment of bytecode
    /// @param readHashInitial Previous reads side effects (for chaining transactions)
    /// @param writeHashInitial Previous writes side effects (for chaining transactions)
    /// @param bytecodeFrag Any legal EVM bytecode fragment
    /// @param stack The EVM Stack configuration before this bytecode is executing
    /// @param gas The available gas in Wei
    /// @param value The value in Wei sent to the transaction
    /// @return readHash The read hash after of the execution of this call
    /// @return writeHash The write hash after of the execution of this call
    /// @return stackOut The EVM Stack configuration after this bytecode is executing
    function partFrag(
        bytes32 readHashInitial,
        bytes32[] memory writeHashInitial,
        bytes memory bytecodeFrag,
        bytes32[] memory stack,
        uint256 gas,
        uint256 value
    ) view external returns (
        bytes32 readHash,
        bytes32[] memory writeHash,
        bytes32[] memory stackOut
    );
}