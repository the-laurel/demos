// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface InterTxPrecompile {
    function emitTx(
        address to,
        address from, // removed when signature works
        uint256 value,
        uint256 gasLimit,
        bytes memory data,
        string memory connectionId,
        uint256 chainId,
        bytes memory signature
    ) external returns(bytes memory response, bytes memory error);

    function emitDependentTx(
        address to,
        address from, // removed when signature works
        uint256 value,
        uint256 gasLimit,
        bytes memory data,
        string memory connectionId,
        uint256 chainId,
        bytes memory signature
    ) external returns(bytes memory response, bytes memory error);

    function emitTxMulti(
        address to,
        address from, // removed when signature works
        uint256 value,
        uint256 gasLimit,
        bytes memory data,
        uint256 chainIdentifiers,
        bytes memory signature
    ) external returns(bytes memory response, bytes memory error);
}
