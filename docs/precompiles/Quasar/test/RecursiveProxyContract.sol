// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract CallSelf {

    struct CallInfo {
        address recipient;
        address contractAddress;
        bytes data;
    }

    event GasAvailable(uint256 indexed gas);
    event Context(bool indexed postcall, uint256 indexed contractBalance, uint256 indexed accountBalance);
    event InnerCallResult(uint256 indexed index, bool indexed success);

    receive() external payable {}
    constructor() payable {}

    function callself(uint256 n) public {
        if (n > 0) {
            callself(n - 1);
        }
    }

    function callselfWithInnerCall(CallInfo[] memory callInfos) public {
        if (callInfos.length == 0) {return;}

        // We modify the balance in the EVM, prior to the precompile call
        payable(callInfos[0].recipient).transfer(7777);

        emit Context(false, address(this).balance, callInfos[0].recipient.balance);

        uint256 gasAvailable;
        assembly {
            gasAvailable := gas()
        }

        emit GasAvailable(gasAvailable - 750); // 375 log + 375 topic

        // execute the call
        (bool success, ) = callInfos[0].contractAddress.call(callInfos[0].data);

        assembly {
            gasAvailable := gas()
        }

        emit GasAvailable(gasAvailable);
        emit Context(true, address(this).balance, callInfos[0].recipient.balance);
        emit InnerCallResult(1, success);

        // execute a second call
        (bool success2, ) = callInfos[1].contractAddress.call(callInfos[1].data);
        require(success2, "second inner call failed");

        emit Context(true, address(this).balance, callInfos[1].recipient.balance);
        emit InnerCallResult(2, success2);


        uint256 newlen = callInfos.length - 2;
        CallInfo[] memory _callInfos = new CallInfo[](newlen);
        for (uint i = 2; i < callInfos.length; i++) {
            _callInfos[i - 2] = callInfos[i];
        }

        (bool success3, ) = address(this).call(
            abi.encodeWithSignature("callselfWithInnerCall((address,address,bytes)[])", _callInfos)
        );
        emit InnerCallResult(3, success3);
    }
}
