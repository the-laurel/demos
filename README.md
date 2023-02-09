# The EVM for the Inter-Chain

Register for tokens: https://docs.google.com/forms/d/e/1FAIpQLSebODebNu4eSVBGIY3EowXqHQTTaLAFngMiWHihVeKeHWuWYQ/viewform

For tech support you can ask a question on
- Mythos Discord, #support channel: https://discord.gg/DQn3f4yu

## UPDATE!

_The information below is outdated. We no longer use Ethermint for our chains. We have implemented our own eWASM engine for Cosmos SDK chains. If you want to test it, you can join the Mythos Discord with the above link._

## About

Mythos, Ethos and Logos are Cosmos-EVM cutting-edge chains [based on Ethermint](https://github.com/evmos/ethermint) (and therefore Evmos-compatible) that host live, publicly verifiable prototypes of our work at The Laurel Project https://laurel.provable.dev.

We showcase innovative features that Cosmos-EVM chains can have, some of which have been/will be proposed to Evmos. This is the future of Cosmos-EVM and you can help us build it.

All this effort is volunteer effort. To support these EVM inter-chain projects on Evmos, you can join as a volunteer or give 100% of your staking reward to our validator: https://evolve.provable.dev/.

Note: the Mythos, Logos, Ethos tokens do not have value outside of transaction gas. Mythos, Logos, Ethos might be restarted from scratch at a later time, (1 month after the hackathon).

## Quasar Demo

See [./docs/precompiles/Quasar](./docs/precompiles/Quasar)

*Note*: Information below might be outdated.

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

MacOS binaries: https://drive.google.com/file/d/1USKotmn882BzVVhWDiirf3TZy9Oz_nQl/view?usp=sharing
Binaries are only needed for the Cosmos SDK part of: opening an interchain account, forwarding the abstract account across chains and sending tokens for each interchain account (on each chain). Some of these messages are also exposed on the EVM side, in the precompiles (Quasar feature). The intent is to expose all of them in the EVM.

- register for tokens and support to do the setup
- create interchain accounts for your Ethereum address (replace with the account that you have)

```
mythosd tx intertx register --from mythos1kjuzm2lsa8ndlc904gvnex9lur8tuputpzq928 --connection-id connection-0 --chain-id mythos_7001-1 --node https://mythos-rpc.provable.dev:443 --home ~/.mythosd --fees 30aMYT --gas=251206 -y
```

- it may take 1-2 min to create, check creation with:
```
mythosd q intertx account-interchain mythos1kjuzm2lsa8ndlc904gvnex9lur8tuputpzq928 connection-0 --chain-id mythos_7001-1 --node https://mythos-rpc.provable.dev:443
```

- send funds to your interchain account on Logos: (replace the inter-chain account address with yours)
```
logosd tx bank send logos1kjuzm2lsa8ndlc904gvnex9lur8tuputgvrq5e logos1eqtc4q6sxt9lglqz8nuvtn0e2cxmrpkkwgkj3dyf9x0vh5lq0nzse9mc7m 1000000000000000000aLYT --fees 20aLYT --chain-id logos_7002-1 --node https://logos-rpc.provable.dev:443 --home ~/.logosd --keyring-backend test -y

# check balance
logosd q bank balances logos1eqtc4q6sxt9lglqz8nuvtn0e2cxmrpkkwgkj3dyf9x0vh5lq0nzse9mc7m --chain-id logos_7002-1 --node https://logos-rpc.provable.dev:443 --home ~/.logosd
```

- repeat same process for Logos and Ethos

```
logosd tx intertx register --from logos1kjuzm2lsa8ndlc904gvnex9lur8tuputgvrq5e --connection-id connection-1 --chain-id logos_7002-1 --node https://logos-rpc.provable.dev:443 --home ~/.logosd --fees 30aLYT --gas=251206 -y

ethosd tx bank send ethos1kjuzm2lsa8ndlc904gvnex9lur8tuput6gll4p ethos1zz38ahrqfkrrzffqc5eceywz57fspdlh35sqvavk6ufew0m0ectscwmz3u 1000000000000000000aRYT --fees 20aRYT --chain-id ethos_7003-1 --node https://ethos-rpc.provable.dev:443 --home ~/.ethosd --keyring-backend test -y
```

- create and forward the abstract account to each chain - from Mythos -> Logos, from Logos -> Ethos
```
mythosd tx intertx account-abstract-forward mythos1kjuzm2lsa8ndlc904gvnex9lur8tuputpzq928 connection-0 --from newacc --chain-id mythos_7001-1 --home ~/.mythosd --node https://mythos-rpc.provable.dev:443 --keyring-backend test --fees 300aMYT -y

logosd tx intertx account-abstract-forward logos1kjuzm2lsa8ndlc904gvnex9lur8tuputgvrq5e connection-1 --from logos1kjuzm2lsa8ndlc904gvnex9lur8tuputgvrq5e --chain-id logos_7002-1 --home ~/.logosd --node https://logos-rpc.provable.dev:443 --keyring-backend test --fees 300aLYT -y

mythosd q intertx account-abstract mythos1kjuzm2lsa8ndlc904gvnex9lur8tuputpzq928 "connection-0" --home ~/.mythosd --node https://mythos-rpc.provable.dev:443
```

### Use nBridge dApp

To do a multi-chain deploy or a multi-chain transaction.

https://mark.provable.dev/?ipfs=QmPDfrDDaH8yoNcagz8pwMPsT2tFze7YvjCih9MDWn5XVq&m=e

### Multi-Chain Simple Storage

Deploy a multi-chain SimpleStorage smart contract, modify the state on all chains in a single transaction.

Smart contract: https://github.com/the-laurel/demos/tree/main/multi-chain-simple-storage.

Use nBridge dApp.

Make sure the abstract account has the same nonce on all chains. E.g. if you sent a multi-chain transaction on Mythos and Logos, you must send it on Ethos too, if you want to later be able to replay a second transaction on all three. Otherwise, the second transaction will fail on Ethos.

### Inter-Chain ERC20

Inter-Chain ERC20 (ICERC20) smart contract is at address [Ethereum address]. See contract code & ABI at https://github.com/the-laurel/demos/tree/main/IcERC20.

A deployed example on Mythos and Logos is at `0x67d71BcE3cdBa17E40883398dB5aec8c6b7e96a3`.
Use nBridge dApp to encode the calldata and send a `replay` dependent transaction.

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

### Quasar/Cosmos Sdk Precompile

- Address: `0x000000000000000000000000000000000000001d`
- Interface: https://github.com/the-laurel/demos/tree/main/docs/precompiles/CosmosSdk
