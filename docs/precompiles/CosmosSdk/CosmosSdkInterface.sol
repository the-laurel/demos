// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface CosmosSdkPrecompile {
    // msgType
    // "/cosmos.bank.v1beta1.MsgSend"
    // "/cosmos.gov.v1beta1.MsgVote"

    function sendMsg(
        string memory msgType,
        bytes memory msg,
        bytes memory signature
    ) external returns(bool success, bytes memory data);
}
