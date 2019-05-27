# Exchange Integration
- [Public Services](#public-services)
    - [REST API](#rest-api)
    - [Node RPC](#node-rpc)
- [Full Node](#full-node)
- [Access via Node Command Line Interface (CLI)](#access-via-node-command-line-interface-cli)
- [SDKs](#sdks)


## Public Services
There are public nodes running by Binance Chain community which will allow you to interact with the blockchain.

### REST API
[Accelerated nodes](https://docs.binance.org/faq.html#what-is-the-accelerated-node) provide advanced API services for the public.<br/>
List of all the Rest API information available on accelerated node can be found: [here](api-reference/dex-api/paths.md)

### Node RPC
There are multiple data seed node in the network which allow users to  perform low-level operations like executing ABCI queries, broadcasting a transaction or viewing network/consensus state.<br/>
If you run a full node by yourself, you can also use those RPC functions.<br/>
List of all endpoints Node RPC service provides can be found: [here](api-reference/node-rpc.md)

## Full Node
Running a full node requires considerable computational/bandwidth resources.<br/>
Please refer to this guide about [how to run your own node](fullnode.md).

## Access via Node Command Line Interface (CLI)
Command Line Interface is currently available for Linux, Mac and Windows.<br/>
Please refer to the [CLI Reference](api-reference/cli.md).

## SDKs
There are multiple advanced SDK solutions available for Binance chain.<br/>
Majority of SDKs provide simplified functions to:

- Create wallets and manage keys
- Encode/sign transactions and submit to Binance Chain/DEX, including Transfer, New Order, Cancel Order, etc.
- Communicate with Binance Chain/DEX via Node RPC calls through public node RPC services or your own private full nodes

List of currently available SDKs and their respective documentations:

- [Go](https://github.com/binance-chain/go-sdk) - [Documentation](https://github.com/binance-chain/go-sdk/wiki)
- [Java](https://github.com/binance-chain/java-sdk) - [Documentation](https://github.com/binance-chain/java-sdk/wiki)
- [JavaScript](https://github.com/binance-chain/javascript-sdk) - [Documentation](https://github.com/binance-chain/javascript-sdk/wiki)
- [C++](https://github.com/binance-chain/cplusplus-sdk) - [Documentation](https://github.com/binance-chain/cplusplus-sdk/wiki)
- [C#](https://github.com/binance-chain/csharp-sdk) - [Documentation](https://github.com/binance-chain/csharp-sdk)
- [Python](https://github.com/binance-chain/python-sdk) - [Documentation](https://python-binance-chain.readthedocs.io/en/latest/binance-chain.html#module-binance_chain)
- [Swift](https://github.com/binance-chain/swift-sdk) - [Documentation](https://github.com/binance-chain/swift-sdk/blob/master/README.md)

