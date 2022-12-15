// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract CosmosSdkProxyContract {
    address public CosmosSdkAddress = 0x000000000000000000000000000000000000001D;

    function sendMsgRaw(bytes memory encodedMsg) public returns(bool success, bytes memory data) {
        bytes memory payload = abi.encodeWithSignature("sendMsgRaw(bytes)", encodedMsg);

        (bool _success, bytes memory _data) = CosmosSdkAddress.call(payload);
        if (!_success) revert("Quasar precompile tx failed");
        return (_success, _data);
    }

    function sendMsgRawNoRevert(bytes memory encodedMsg) public returns(bool success, bytes memory data) {
        bytes memory payload = abi.encodeWithSignature("sendMsgRaw(bytes)", encodedMsg);

        (bool _success, bytes memory _data) = CosmosSdkAddress.call(payload);
        return (_success, _data);
    }

    function sendMsgRawDelegate(bytes memory encodedMsg) public returns(bool success, bytes memory data) {
        bytes memory payload = abi.encodeWithSignature("sendMsgRaw(bytes)", encodedMsg);

        (bool _success, bytes memory _data) = CosmosSdkAddress.delegatecall(payload);
        if (!_success) revert("Quasar precompile tx failed");
        return (_success, _data);
    }

    function sendMsgRawStatic(bytes memory encodedMsg) view public returns(bool success, bytes memory data) {
        bytes memory payload = abi.encodeWithSignature("sendMsgRaw(bytes)", encodedMsg);

        (bool _success, bytes memory _data) = CosmosSdkAddress.staticcall(payload);
        if (!_success) revert("Quasar precompile tx failed");
        return (_success, _data);
    }

    function sendQueryRaw(bytes memory encodedMsg) view public returns(bytes memory data) {
        bytes memory payload = abi.encodeWithSignature("sendQueryRaw(bytes)", encodedMsg);

        (bool _success, bytes memory _data) = CosmosSdkAddress.staticcall(payload);
        if (!_success) revert("Quasar precompile query failed");
        return _data;
    }

    function sendMsgRawRevert(bytes memory encodedMsg) public {
        bytes memory payload = abi.encodeWithSignature("sendMsgRaw(bytes)", encodedMsg);

        (bool _success, bytes memory _data) = CosmosSdkAddress.call(payload);
        if (!_success) revert("Quasar precompile query failed");

        revert("reverted after quasar call concluded: ");
    }
}
