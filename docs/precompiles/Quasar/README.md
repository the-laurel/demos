# Quasar

## Demos

[https://www.youtube.com/playlist?list=PL323JufuD9JB1R28TdzCtiiIwTHy9TX5C](https://www.youtube.com/playlist?list=PL323JufuD9JB1R28TdzCtiiIwTHy9TX5C)


## Test Quasar

Join Mythos Discord for support & receiving test tokens: https://discord.gg/dp4DaVz8

Add Mythos to Metamask:

Name: mythos.provable.dev
RPC URL: https://mythos-evm.provable.dev
ChainID: 7001
Currency: MYT
Block explorer: https://explorer-mythos.provable.dev/

Cosmos explorer: https://explorer.provable.dev/

### Quasar Precompile

- address: `0x000000000000000000000000000000000000001D`
- Solidity interface: [QuasarPrecompile interface](./CosmosSdkInterface.sol)
- abi: [QuasarPrecompile abi](./CosmosSdkAbi.json)

You can directly call the Quasar precompile as you would call any other contract.

Or you can call it from another smart contract. A more complex example with nested calls is the [CallSelf contract](./test/RecursiveProxyContract.sol). This was used in this demo video: [Quasar is on Mythos. Execute Cosmos Transactions & Queries from the EVM. For any Ethermint chain.](https://youtu.be/COu5Olszhtg)

To easily encode your Cosmos messages (as shown in the above video), you can use: [https://mark.provable.dev/?ipfs=QmQHcms35m1mmc7PMQD3nzp47gAsXk9aMu59uw6bNo8MTM](https://mark.provable.dev/?ipfs=QmQHcms35m1mmc7PMQD3nzp47gAsXk9aMu59uw6bNo8MTM).


### sendMsgRaw

### sendQueryRaw

### sendMsgAbiEncoded

Coming soon

### sendQueryAbiEncoded

Coming soon

### Protobuf-Encoding as a Solidity library

Coming soon
