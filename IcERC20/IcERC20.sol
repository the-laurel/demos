// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface IcERC20 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256);
    function balanceOf(address _owner) external view returns (uint256 balance);
    function allowance(address _owner, address _spender) external view returns (uint256 remaining);

    function transfer(address _to, uint256 _value) external returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
    function approve(address _spender, uint256 _value) external returns (bool success);
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    
    // IC-specific
    
    function ICbalanceOf(
        uint8 ICchainID, 
        address _owner
    ) external view returns (
        uint256 balance
    );
    
    function ICallowance(
        uint8 ICchainID, 
        address _owner, 
        address _spender
    ) external view returns (
        uint256 remaining
    );

    function ICmove(
        uint8 sourceChainID, 
        uint8 targetChainID, 
        address _from, 
        uint256 _value
    ) external returns (
        bool success
    );
    
    function ICtransfer(
        uint8 sourceChainID, 
        uint8 targetChainID, 
        address _from, 
        address _to, 
        uint256 _value
    ) external returns (
        bool success
    );

    event ICMove(
        uint8 sourceChainID, 
        uint8 targetChainID, 
        address indexed _fromto, 
        uint256 _value
    );
    
    event ICTransfer(
        uint8 sourceChainID, 
        uint8 targetChainID, 
        address indexed _from, 
        address indexed _to, 
        uint256 _value
    );
}