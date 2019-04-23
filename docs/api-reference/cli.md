# Command Line Interface (CLI)

Binance Chain CLI is one of several ways to interact with Binance Chain.

Binance Chain CLI can be used as a local wallet, you can manage your keys via Binance CLI. You can add a new
key or restore your key from mnemonic words. And you can list your keys and show specified key info. 

With Binance Chain CLI, you can send transactions to Binance Chain, like placing an order, transferring token, 
issuing token and so on. Actually you can do almost everything you can do with Binance Chain web wallet. What is
more, you can propose to list trading pairs and join chain governance.

In addition, you can do some simple queries through CLI. For example, you can query your account's 
balance, transaction detail by transaction hash and etc.

## Where can I download the Binance Chain CLI?

You can download Binance Chain CLI releases here: [https://github.com/binance-chain/node-binary](https://github.com/binance-chain/node-binary/tree/master/cli)
```
git clone https://github.com/binance-chain/node-binary.git
```
You can choose to download the version for testnet or mainnet. Replace the network var with `testnet` or` prod` in the following command:
```
cd node-binary/cli/{network}/{version}
```
### CLI installation

Once you have downloaded the binary for your platform, you may drop it into any folder you like. Open a terminal window or `cmd.exe` in that folder, and then follow the examples on the documentation site.

```bash
$  ./bnbcli
```

On Windows you would most likely use this instead:

```bash
C:\> bnbcli.exe
```

## Where to connect

You can manage you keys locally without connecting to any node. But if you want to interact with Binance Chain, you need to connect to one of Binance Chain full nodes.

You can run your own full node, which may automatically connect to Binance Chain, and you can run your CLI there with your own full node. In the mean time, you can connect to any full nodes provided by other people. 

You could query this API for for a list of full node on mainnet: <https://dex.binance.org/api/v1/peers>.

For testnet, visit  <https://testnet-dex.binance.org/api/v1/peers>.

Full nodes will be denoted as the format of `ip:port`, you could use `access_addr` as your peer to get connected, such as `https://dataseed4.defibit.io:443`

Please note that there are two types of nodes that offer RPC services. Some support TLS and others don't.

## Which Chain-ID to use

`chain-id` is an important field to fill for every transaction sent from `bnbcli`. The` chain-id` for mainnet is `Binance-Chain-Tigris`, and is `Binance-Chain-Nile` for testnet. Please choose the correct one in your case. 

## How to use

When you have downloaded Binance Chain CLI, you can use `help` subcommand to see all the available commands:

```bash
$  ./bnbcli help
BNBChain light-client

Usage:
  bnbcli [command]

Available Commands:
  init        Initialize light client
  status      Query remote node for status

  txs         Search for all transactions that match the given tags.
  tx          Matches this txhash over all committed blocks

  account     Query account balance
  send        Create and sign a send tx
  transfer

  api-server  Start the API server daemon
  keys        Add or view local private keys

  version     Print the app version
  token       issue or view tokens
  dex         dex commands
  gov         gov commands
  help        Help about any command

Flags:
  -e, --encoding string   Binary encoding (hex|b64|btc) (default "hex")
  -h, --help              help for bnbcli
      --home string       directory for config and data (default "/root/.bnbcli")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors

Use "bnbcli [command] --help" for more information about a command.
```

**Note**:there is one special flag `--trust-node` of most subcommands, if not enabled which is by default the CLI 
will take an extra 2-4 seconds to verify blockchain proof at current height. You can enable that flag if the peer is trustful so that most commands will accomplish in 500 milliseconds. If your node cannot prove the transaction, there will be the following notice:
```
Create verifier failed: Commit: Response error: RPC error -32603 - Internal error: runtime error: invalid memory address or nil pointer dereference
Please check network connection and verify the address of the node to connect to
```
To solve this issue, you need to set `--trust-node` to `true`



## CLI Reference

For detailed usage, you can refer to:

- [transfer](../transfer.md)
- [trade](../trade.md)
- [issue](../tokens.md)
- [governance](../governance.md)
- [list](../list.md)
- [keys](../keys.md)

## Use CLI for Different Blockchain

`bnbcli` will save data about validatorset changes at home of `bnbcli`. Once you want to use `bnbcli` for different blockchains, for example, you want to change from testnet to mainnet, the data will be stale. In order to swtich between blockchains, you need clean data folder `rm -rf ~/.bnbcli/.bnblite/`  or create a new home folder for bnbcli with `--home` flag.
If you forget to specify different home folder path, then you will not be able to make queries with `bnbcli`.