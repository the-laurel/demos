// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./ERC20.sol";

contract ICERC20 is ERC20 {
    address public AbstractAccountsAddress = 0x000000000000000000000000000000000000001a;

    event ICMove(uint256 sourceChainID, uint256 targetChainID, address indexed _fromto, uint256 _value);
    event ICTransfer(uint256 sourceChainID, uint256 targetChainID, address indexed _from, address indexed _to, uint256 _value);

    constructor(uint256 initialSupply, uint256 _chainId, address owner) ERC20("ICToken", "ICT") {
        uint256 chainId = getChainId();
        if (_chainId == chainId) {
            _mint(owner, initialSupply);
        }
        else {
            _totalSupply = initialSupply;
        }
    }

    function ICbalanceOf(uint256 ICchainID, address _owner) public view returns (uint256 balance) {
        // Not implemented; needs routing of queries
    }

    function ICallowance(uint256 ICchainID, address _owner, address _spender) public view returns (uint256 remaining) {
        // Not implemented; needs routing of queries
    }

    function ICmove(uint256 sourceChainID, uint256 targetChainID, address _from, uint256 _value) public returns (bool success) {
        require(msg.sender == getAbstractAccountAddress(_from), "Abstract account not authorized");
        uint256 chainId = getChainId();
        if (sourceChainID == chainId) {
            _subtract(_from, _value);
        }
        else if (targetChainID == chainId) {
            _add(_from, _value);
        }

        emit ICMove(sourceChainID, targetChainID, _from, _value);
    }

    function ICtransfer(uint256 sourceChainID, uint256 targetChainID, address _from, address _to, uint256 _value) public returns (bool success) {
        require(msg.sender == getAbstractAccountAddress(_from), "Abstract account not authorized");
        uint256 chainId = getChainId();
        if (sourceChainID == chainId) {
            _subtract(_from, _value);
        }
        else if (targetChainID == chainId) {
            _add(_to, _value);
        }

        emit ICTransfer(sourceChainID, targetChainID, _from, _to, _value);
    }

    function getChainId() public view returns(uint256 chainId) {
        assembly {
            chainId := chainid()
        }
    }

    function getAbstractAccountAddress(address owner) internal returns (address account) {
        bytes memory payload = abi.encodeWithSignature(
            "getAccountAddress(address)",
            owner
        );

        (bool success, bytes memory data) = AbstractAccountsAddress.call(payload);
        if (!success) revert("AA precompile getAccountAddress failed");
        bytes memory res = abi.decode(data, (bytes));
        account = abi.decode(res, (address));
        return account;
    }

    function _subtract(
        address from,
        uint256 amount
    ) internal {
        require(from != address(0), "ERC20: subtract from the zero address");

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - amount;
        }
    }

    function _add(
        address to,
        uint256 amount
    ) internal {
        require(to != address(0), "ERC20: add to the zero address");
        uint256 toBalance = _balances[to];
        _balances[to] += amount;
        require(toBalance <= _balances[to], "ERC20: add amount underflow");
    }

}
