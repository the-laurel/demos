// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/// @title A precompiles bundle
/// @author The Laurel Project
/// @notice 4 precompiles
/// @dev Technical demos are at https://www.youtube.com/c/LoredanaCirstea/videos
/// custom:license This is covered by The Moral Licence - that is more strict than GPL-3.0
contract PrecompileWrap {
    address public AbstractAccountAddress = 0x000000000000000000000000000000000000001a;
    address public InterTxAddress = 0x0000000000000000000000000000000000000019;
    address public CosmosSdkAddress = 0x000000000000000000000000000000000000001D;
    address public EvmInterpreterAddress = 0x0000000000000000000000000000000000000014;

    function callPrecompile(address precompileAddress, bytes memory payload, string memory err) internal returns(bytes memory) {
        (bool success, bytes memory data) = precompileAddress.call(payload);
        if (!success) revert(err);
        return abi.decode(data, (bytes));
    }

    function staticcallPrecompile(address precompileAddress, bytes memory payload, string memory err) internal view returns(bytes memory) {
        (bool success, bytes memory data) = precompileAddress.staticcall(payload);
        if (!success) revert(err);
        return abi.decode(data, (bytes));
    }
    
    // AbstractAccount

    /// @notice Sends a transaction as from an EOA
    /// @param signature is 65 bytes in length and is further composed 1B + 32B + 32B (v, s, r).
    function aa_sendTx(
        address to,
        address from, // removed when signature works
        uint256 value,
        uint256 gasLimit,
        bytes memory data,
        bytes memory signature
    ) external {
        bytes memory payload = abi.encodeWithSignature(
            "sendTx(address,address,uint256,uint256,bytes,bytes)",
           to, from, value, gasLimit, data, signature
        );
        callPrecompile(AbstractAccountAddress, payload, "aa_sendTx failed");
    }

    /// @notice Retrieval of abstract account address by owner
    function aa_getAccountAddress(address owner) view external returns (address) {
        bytes memory payload = abi.encodeWithSignature(
            "getAccountAddress(address)",
           owner
        );
        bytes memory res = staticcallPrecompile(AbstractAccountAddress, payload, "aa_getAccountAddress failed");
        return abi.decode(res, (address));
    }

    /// @notice Retrieval of abstract account by owner and IBC channel connectionId
    function aa_getAccount(address owner, string memory connectionId) view external returns (address accountAddress, uint256 nonce) {
        bytes memory payload = abi.encodeWithSignature(
            "getAccount(address,string)",
           owner, connectionId
        );
        bytes memory res = staticcallPrecompile(AbstractAccountAddress, payload, "aa_getAccount failed");
        return abi.decode(res, (address, uint256));
    }

    /// @notice Creation of new abstract accounts
    function aa_registerAccount() external returns(address accountAddress){
        bytes memory payload = abi.encodeWithSignature(
            "registerAccount()"
        );
        bytes memory res = callPrecompile(AbstractAccountAddress, payload, "aa_registerAccount failed");
        return abi.decode(res, (address));
    }

    // CosmosSdkPrecompile

    /// @notice Sends a message from EVM to Cosmos
    /// @param msgType Type of message
    /// @param cosmosMsg Content of message
    /// @param signature is 65 bytes in length and is further composed 1B + 32B + 32B (v, s, r).
    function cosmos_sendMsg(
        string memory msgType,
        bytes memory cosmosMsg,
        bytes memory signature
    ) external { // TODO return
        bytes memory payload = abi.encodeWithSignature(
            "sendMsg(string,bytes,bytes)",
            msgType, cosmosMsg, signature
        );
        callPrecompile(CosmosSdkAddress, payload, "cosmos_sendMsg failed");
    }

    // EvmInterpreter

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
    function evm_analyzeFrag(
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
    ){
        bytes memory payload = abi.encodeWithSignature(
            "analyzeFrag(bytes,bytes32[],uint256,uint256)",
            bytecodeFrag, stack, gas, value
        );
        bytes memory res = staticcallPrecompile(EvmInterpreterAddress, payload, "evm_analyzeFrag failed");
        return abi.decode(res, (uint256, uint256, uint256, uint256, uint256, uint256, bytes32[]));
    }
   
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
    function evm_analyze(
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
    ){
        bytes memory payload = abi.encodeWithSignature(
            "analyze(bytes,bytes,uint256,uint256)",
            bytecode, input, gas, value
        );
        bytes memory res = staticcallPrecompile(EvmInterpreterAddress, payload, "evm_analyze failed");
        return abi.decode(res, (uint256, uint256, uint256, uint256, uint256, uint256, bytes));
    }
    
    /// @notice Executes (immutably) a contract call
    /// @param bytecode Any legal EVM bytecode (for a presumtive contract)
    /// @param input The EVM transaction calldata (for that contract)
    /// @param gas The available gas in Wei
    /// @param value The value in Wei sent to the transaction
    /// @return result The call result
    function evm_interpret(
        bytes memory bytecode,
        bytes memory input,
        uint256 gas,
        uint256 value
    ) view external returns (
        bytes memory result
    ){
        bytes memory payload = abi.encodeWithSignature(
            "interpret(bytes,bytes,uint256,uint256)",
            bytecode, input, gas, value
        );
        bytes memory res = staticcallPrecompile(EvmInterpreterAddress, payload, "evm_interpret failed");
        return abi.decode(res, (bytes));
    }
    
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
    function evm_part(
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
    ){
        bytes memory payload = abi.encodeWithSignature(
            "part(bytes32,bytes32[],bytes,bytes,uint256,uint256)",
            readHashInitial, writeHashInitial, bytecode, input, gas, value
        );
        bytes memory res = staticcallPrecompile(EvmInterpreterAddress, payload, "evm_part failed");
        return abi.decode(res, (bytes32, bytes32[], bytes));
    }
    
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
    function evm_partFrag(
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
    ){
        bytes memory payload = abi.encodeWithSignature(
            "partFrag(bytes32,bytes32[],bytes,bytes32[],uint256,uint256)",
            readHashInitial, writeHashInitial, bytecodeFrag, stack, gas, value
        );
        bytes memory res = staticcallPrecompile(EvmInterpreterAddress, payload, "evm_partFrag failed");
        return abi.decode(res, (bytes32, bytes32[], bytes32[]));
    }

    // InterTxPrecompile

    // emitTx will send the `data` to the chain that corresponds to the `connectionId`.
    // The message will carry `value` and will be signed by `signature`.
    /// @notice Sends a transaction
    /// @dev Demoed at https://www.youtube.com/watch?v=I7zYXEtMeD4
    /// @param to Address of the contract that will execute the transaction
    /// @param from Address of the sender
    /// @param value The value in Wei sent to the transaction
    /// @param gasLimit The maximum of gas that can be used
    /// @param data The calldata or transaction input
    /// @param connectionId The ID of the IBC connection
    /// @param chainId The ID of the targeted chain
    /// @param signature is 65 bytes in length and is further composed 1B + 32B + 32B (v, s, r).
    function intertx_emitTx(
        address to,
        address from, // removed when signature works
        uint256 value,
        uint256 gasLimit,
        bytes memory data,
        string memory connectionId,
        uint256 chainId,
        bytes memory signature
    ) external { // TODO return
        bytes memory payload = abi.encodeWithSignature(
            "emitTx(address,address,uint256,uint256,bytes,string,uint256,bytes)",
            to, from, value, gasLimit, data, connectionId, chainId, signature
        );
        callPrecompile(InterTxAddress, payload, "intertx_emitTx failed");
    }

    /// @notice Sends a dependent transaction
    /// @dev Demoed at https://www.youtube.com/watch?v=I7zYXEtMeD4
    /// @param to Address of the contract that will execute the transaction
    /// @param from Address of the sender
    /// @param value The value in Wei sent to the transaction
    /// @param gasLimit The maximum of gas that can be used
    /// @param data The calldata or transaction input
    /// @param connectionId The ID of the IBC connection
    /// @param chainId The ID of the targeted chain
    /// @param signature is 65 bytes in length and is further composed 1B + 32B + 32B (v, s, r).
    function intertx_emitDependentTx(
        address to,
        address from, // removed when signature works
        uint256 value,
        uint256 gasLimit,
        bytes memory data,
        string memory connectionId,
        uint256 chainId,
        bytes memory signature
    ) external { // TODO return
        bytes memory payload = abi.encodeWithSignature(
            "emitDependentTx(address,address,uint256,uint256,bytes,string,uint256,bytes)",
            to, from, value, gasLimit, data, connectionId, chainId, signature
        );
        callPrecompile(InterTxAddress, payload, "intertx_emitDependentTx failed");
    }


    /// @notice Sends a multi-chain transaction (sed only by the nBridge)
    /// @dev Demoed at hhttps://www.youtube.com/watch?v=12FU9iG1D08&list=PL323JufuD9JBvmyqYtYLSe-xSSdJS9NPO&index=3
    /// @param to Address of the contract that will execute the transaction
    /// @param from Address of the sender
    /// @param value The value in Wei sent to the transaction
    /// @param gasLimit The maximum of gas that can be used
    /// @param data The calldata or transaction input
    /// @param chainIdentifiers The IDs as a bit mapping to single out the chains where the transaction should be replayed. The chainIDs being the bit location of the set bits
    /// @param signature is 65 bytes in length and is further composed 1B + 32B + 32B (v, s, r).
    function intertx_emitTxMulti(
        address to,
        address from, // removed when signature works
        uint256 value,
        uint256 gasLimit,
        bytes memory data,
        uint256 chainIdentifiers,
        bytes memory signature
    ) external { // TODO return
        bytes memory payload = abi.encodeWithSignature(
            "emitTxMulti(address,address,uint256,uint256,bytes,uint256,bytes)",
            to, from, value, gasLimit, data, chainIdentifiers, signature
        );
        callPrecompile(InterTxAddress, payload, "intertx_emitTxMulti failed");
    }

    /// @notice Creation of new interchain account
    /// @param owner Owner of the inter-chain account
    /// @param connectionId Connection id for the IBC channel
    /// @param signature For 3rd party registration of accounts, users must provide signature
    function intertx_registerInterChainAccount(
        address owner, string memory connectionId, bytes memory signature
    ) external { // TODO return
        bytes memory payload = abi.encodeWithSignature(
            "emitTxMulti(address,string,bytes)",
            owner, connectionId, signature
        );
        callPrecompile(InterTxAddress, payload, "intertx_registerInterChainAccount failed");
    }

    /// @notice Retrieval of interchain account address
    /// @param owner Owner of the inter-chain account
    /// @param connectionId Connection id for the IBC channel
    function intertx_getInterChainAccountAddress(address owner, string memory connectionId) view external returns(string memory icaAddress) {
        bytes memory payload = abi.encodeWithSignature(
            "getInterChainAccountAddress(address,string)",
            owner, connectionId
        );
        bytes memory res = staticcallPrecompile(InterTxAddress, payload, "intertx_getInterChainAccountAddress failed");
        return abi.decode(res, (string));
    }
}