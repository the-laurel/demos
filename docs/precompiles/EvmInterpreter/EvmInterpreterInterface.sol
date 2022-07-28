// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface EvmInterpreterPrecompile {
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
    
    function interpret(
        bytes memory bytecode,
        bytes memory input,
        uint256 gas,
        uint256 value
    ) view external returns (
        bytes memory result
    );
    
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