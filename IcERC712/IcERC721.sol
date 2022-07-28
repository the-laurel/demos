// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface IcERC721 {
    function balanceOf(address _owner) external view returns (uint256);
    function ownerOf(uint256 _tokenId) external view returns (address);
    function getApproved(uint256 _tokenId) external view returns (address);
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);
    
    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) external payable;
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;
    function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
    function approve(address _approved, uint256 _tokenId) external payable;
    function setApprovalForAll(address _operator, bool _approved) external;
    
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
    
    // IC-specific
    
    function ICbalanceOf(
        uint8 ICchainID, 
        address _owner
    ) public view returns (
        uint256 balance
    )
    
    //function ICallowance(uint8 ICchainID, address _owner, address _spender) public view returns (uint256 remaining)

    function ICmove(
        uint8 sourceChainID, 
        uint8 targetChainID, 
        address _from, 
        uint256 _tokenId
    ) public returns (
        bool success
    )
    
    function ICtransfer(
        uint8 sourceChainID, 
        uint8 targetChainID, 
        address _from, 
        address _to, 
        uint256 _tokenId
    ) public returns (
        bool success
    )

    event ICMove(
        uint8 sourceChainID, 
        uint8 targetChainID, 
        address indexed _fromto, 
        uint256 indexed _tokenId
    )
    
    event ICTransfer(
        uint8 sourceChainID, 
        uint8 targetChainID, 
        address indexed _from, 
        address indexed _to, 
        uint256 indexed _tokenId
    )
}