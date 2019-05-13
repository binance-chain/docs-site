# Get Started with Binance Chain


## Wallet

The easiest way to use Binance Chain is through a wallet with support for Binance Chain accounts and transfers.

For example, Binance provides a Web Wallet at https://www.binance.org (https://testnet.binance.org for testnet), which provides the below functions:

- Generating crypto keys and addresses, which serves as the base of a wallet
- Showing the balances of assets on the addresses
- Sending and receiving assets

Binance Chain Web Wallet also presents a trading UI similar to Binance.com, where you can examine market data and manage your orders to trade among the listed assets. Learn about the list of wallet available [here](wallets.md).

## Chain Explorer
Chain Explorer provides a portal to explore blocks and transaction details. On Binance Chain Explorer, you can also check different types assets, the distribution of their ownerships, and owners' transactions.

## REST API
There are some [accelerate nodes](https://docs.binance.org/faq.html#what-is-the-accelerated-node) which provides some advanced API services for the public.
Here is a list of all the Rest API information it provides: <https://docs.binance.org/api-reference/dex-api/paths.html>

### Node RPC
There are some data seed node in the network which allow users perform low-level operations like executing ABCI queries, viewing network/consensus state or broadcasting a transaction.
If you run a full node by yourself, you can also use those RPC functions. Here is a list of all the Node RPC services it provides: <https://docs.binance.org/api-reference/node-rpc.html>

## Advanced Ways To Use Blockchain
### Run your own full node

Please refer to this guide about [how to run your own node](fullnode.md).
### Run your own light client

Please refer to this guide about [how to run your own light client](light-client.md).

### Access via Node Command Line Interface (CLI)

A Command Line Interface is available for Linux and Mac platforms. Please refer to the
[CLI Reference](api-reference/cli.md).

### Use SDKs

SDKs are also provided as a starting point for your apps. There are two advanced sdk solutions for Binance chain: [Java](<https://github.com/binance-chain/java-sdk>) and [Golang](<https://github.com/binance-chain/go-sdk>). Both solutions provide functions for:
* Create wallets and manage keys
* Encode/sign transactions and submit to Binance Chain/DEX, including Transfer, New Order, Cancel Order, etc.
* Communicate with Binance Chain/DEX Node RPC calls through public node RPC services or your own private full nodes

Please refer to its documents for more informations:

* <https://github.com/binance-chain/go-sdk/wiki>
* <https://github.com/binance-chain/java-sdk/wiki>
## Blockchain Details
Please check the [technical details](index.md#technology-details) for more technical information.
