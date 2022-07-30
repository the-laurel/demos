# The EVM for the Inter-Chain

Register for tokens: https://docs.google.com/forms/d/e/1FAIpQLSebODebNu4eSVBGIY3EowXqHQTTaLAFngMiWHihVeKeHWuWYQ/viewform

For tech support you can ask a question on
- Mythos Discord, #support channel: https://discord.gg/DQn3f4yu
- ask Loredana directly at the hackathon, if you see her

If you want to build your hackathon project on our chains, let us know: in case you need additional features or fixes for the chains or smart contracts, we might be able to solve it during the hackathon if you tell us early. 

Mythos, Ethos and Logos are Cosmos-EVM cutting-edge chains [based on Ethermint](https://github.com/evmos/ethermint) (and therefore Evmos-compatible) that host live, publicly verifiable prototypes of our work at The Laurel Project https://laurel.provable.dev.

We showcase innovative features that Cosmos-EVM chains can have, some of which have been/will be proposed to Evmos. This is the future of Cosmos-EVM and you can help us build it.

All this effort is volunteer effort. To support these EVM inter-chain projects on Evmos, you can join as a volunteer or give 100% of your staking reward to our validator: https://evolve.provable.dev/.

Note: the Mythos, Logos, Ethos tokens do not have value outside of transaction gas. Mythos, Logos, Ethos might be restarted from scratch at a later time, (1 month after the hackathon).

## Interactive Workshop

Presentation: https://docs.google.com/presentation/d/1A6kFqRLrCv5n755kU6duAJz2UQdbJlpRqpIADvfJjfM/edit?usp=sharing

### Prerequsite

- Install Metamask (or another EVM wallet) in your browser (ideally Chrome): https://metamask.io/
- Fill in this form with your Ethereum address, to receive tokens on the Mythos, Ethos, Logos chains: https://forms.gle/3sGGBEPzqLQM7Zp7A
- Add Mythos, Logos, Ethos to your Metamask:

#### Mythos Metamask settings:
* Name: `mythos.provable.dev`
* RPC URL: `https://mythos-evm.provable.dev`
* ChainID: `7001`
* Currency: `aMYT`
* Block explorer: `https://explorer-mythos.provable.dev/`

#### Logos Metamask settings:
* Name: `logos.provable.dev`
* RPC URL: `https://logos-evm.provable.dev`
* ChainID: `7002`
* Currency: `aLYT`
* Block explorer: `https://explorer-logos.provable.dev`

#### Ethos Metamask settings:
* Name: `ethos.provable.dev`
* RPC URL: `https://ethos-evm.provable.dev`
* ChainID: `7003`
* Currency: `aRYT`
* Block explorer: `https://explorer-ethos.provable.dev`


### Setup

After you have your tokens, go the HackAtomWorkshopSetup smart contract & dApp: [TODO marks factory] and click the Setup button. This will trigger an EVM transaction that you will need to sign with Metamask.

This transaction will:
-> send you some inter-chain-powered ERC20 tokens
-> create an interchain account for your Ethereum address. This is a Cosmos SDK message sent through our Quasar feature, that connects Cosmos to the EVM and back.

### Multi-Chain Simple Storage

Deploy a multi-chain SimpleStorage smart contract, modify the state on all chains in a single transaction.

Smart contract, dApp code: https://github.com/the-laurel/demos/tree/main/multi-chain-simple-storage.

### Inter-Chain ERC20

Inter-Chain ERC20 (ICERC20) smart contract is at address [Ethereum address]. See contract code & ABI at https://github.com/the-laurel/demos/tree/main/IcERC20.

A deployed example on Mythos and Logos is at `0x67d71BcE3cdBa17E40883398dB5aec8c6b7e96a3`.
The dApp to interact with it is at [TODO marks factory]

You can:
-> move your ICERC20 tokens from Mythos to your account (same Ethereum address) on another chain (Logos, Ethos)
-> transfer your ICERC20 tokens from Mythos to another account, on another chain (Logos, Ethos)

#### Learn more:
- The EVM Inter-Chain playlist: https://www.youtube.com/playlist?list=PL323JufuD9JCrElzoheW-oJMujGjHtp-k

## Tools

### Marks Factory

https://mark.provable.dev/?m=e

## The Development Process

1. know well your intent and the limitations of the EVM chain
2. develop the smart contracts in Solidity with Remix
3. test the ABI in Remix
4. produce a simple dApp to test independently from Remix
5. make the dApp intuitive, secure, and bug-free
6. deploy the contracts on the pubic chain
7. deploy the dApp on IPFS
8. profit

We simplified the process:

1. know well your intent and the limitations of the EVM chain
2. develop the smart contracts in Solidity with Remix or in our taylor IDE
3. export the ABI to obtain a simple dApp
4. make the dApp intuitive, secure, and bug-free in the same IDE
5. press a button and it gets saved to IPFS and QR created for mobile share
6. deploy the contracts too on the public chain
7. profit

For todays lessons, you will receive stubs of code from IPFS. You should be able to further develop the code to work in the Inter-Chain environment.

Plus: after you develop a dApp, you will be able to share it with the others.

## Transaction Replay

needs to:
- be signed by the same account
- the contract has to have the same address
- with the same nonce
- on each chain that is played on

We have created 2 types of trustless bridges that use transaction replay: 1 can be used between 2 chains and 1 can be used on 3 or more chains and it uses a router to create a ring of chains. The router selects on wich chains the transaction should be replayed.

## Relevant Infrastructure

### The Necessay Precompiles

For ease of use, you can find all the precompile interfaces in `./docs/precompiles/PrecompileWrap.sol`, deployed at `0x320555a5112A4a5572bF37573Ce8973bAeDab9B2`, on Mythos.

#### EvmInterpreter Precompile

- Address: `0x0000000000000000000000000000000000000014`
- Interface: https://github.com/the-laurel/demos/tree/main/docs/precompiles/EvmInterpreter

### InterTx Precompile

- Address: `0x0000000000000000000000000000000000000019`
- Interface: https://github.com/the-laurel/demos/tree/main/docs/precompiles/InterTx

### AbstractAccount Precompile

- Address: `0x000000000000000000000000000000000000001a`
- Interface: https://github.com/the-laurel/demos/tree/main/docs/precompiles/AbstractAccount

### CosmosSdk Precompile

- Address: `0x000000000000000000000000000000000000001d`
- Interface: https://github.com/the-laurel/demos/tree/main/docs/precompiles/CosmosSdk
