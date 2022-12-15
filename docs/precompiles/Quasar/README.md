# Quasar

## Demos

[https://www.youtube.com/playlist?list=PL323JufuD9JB1R28TdzCtiiIwTHy9TX5C](https://www.youtube.com/playlist?list=PL323JufuD9JB1R28TdzCtiiIwTHy9TX5C)


## Test Quasar

Register for tokens: https://docs.google.com/forms/d/e/1FAIpQLSebODebNu4eSVBGIY3EowXqHQTTaLAFngMiWHihVeKeHWuWYQ/viewform

Join Mythos Discord for support: https://discord.gg/dp4DaVz8

Add Mythos to Metamask:

```
Name: mythos.provable.dev
RPC URL: https://mythos-evm.provable.dev
ChainID: 7001
Currency: MYT
Block explorer: https://explorer-mythos.provable.dev/
```

Cosmos explorer: https://explorer.provable.dev/

### Quasar Precompile

- address: `0x000000000000000000000000000000000000001D`
- Solidity interface: [QuasarPrecompile interface](./CosmosSdkInterface.sol)
- abi: [QuasarPrecompile abi](./CosmosSdkAbi.json)

You can directly call the Quasar precompile as you would call any other contract.

Or you can call it from another smart contract:
* deploy the test contract [CosmosSdkProxyContract](./test/ProxyContract.sol)
* a more complex example with nested calls is the [CallSelf contract](./test/RecursiveProxyContract.sol). This was used in this demo video: [Quasar is on Mythos. Execute Cosmos Transactions & Queries from the EVM. For any Ethermint chain.](https://youtu.be/COu5Olszhtg). Already deployed at [0x38f006F11fbD148B269c2098743396ba802B301c](https://explorer-mythos.provable.dev/address/0x38f006F11fbD148B269c2098743396ba802B301c).

To easily encode your Cosmos messages (as shown in the above video), you can use: [https://mark.provable.dev/?ipfs=QmX81PMCPn8KgUehzperdH7DRxW7fYd9H1HrDkgkwstcKW](https://mark.provable.dev/?ipfs=QmX81PMCPn8KgUehzperdH7DRxW7fYd9H1HrDkgkwstcKW).

Note!: Right now you cannot directly use the `QuasarPrecompile` interface to initialize contract instances in Solidity and send calls, because Solidity does a check on whether bytecode exists at the precompile address (the precompile is a native contract, without bytecode, so this check fails). This is why you need to use a lower-level `call`. This will be mitigated in the near future.

### sendMsgRaw

### sendQueryRaw

### sendMsgAbiEncoded

Coming soon

### sendQueryAbiEncoded

Coming soon

### Protobuf-Encoding as a Solidity library

Coming soon
