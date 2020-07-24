# Light Client

## Introduction

A light client allows clients, such as mobile phones, to receive proofs of the state of the blockchain from any full node. Light clients do not have to trust any full node, since they are able to verify any proof they receive.

A light client can provide the same security as a full node with minimal requirements for bandwidth, computing and storage resource. It can also provide modular functionality according to users' configuration. These features allow developers to build secure, efficient, and usable mobile apps, websites, and other applications without deploying or maintaining any full blockchain nodes.

## Light Client Versus Full Node

* Light client does not store blocks or states,this way it needs less disk space (50 megabytes will be enough).
* Light client does not join p2p network and it does not produce any network cost when it is idle. The network overhead depends on how many requests the light client handles concurrently.
* Light client does not replay state of the chain so that there is not CPU cost when idle. The CPU cost also depends on how many requests the light client handles concurrently.
* Light client is faster than a full node even if it lagged behind the core network for a few months. It only needs a few seconds to catch up with core network.

## Install Light Client

We have a community-maintained installer script (`install.sh`) that takes care of chain directory setup. This uses the following defaults:

- Home folder in `~/.bnbchaind`
- Client executables stored in `/usr/local/bin` (i.e. `lightd` or `bnbchaind`)

```
# One-line install
sh <(wget -qO- https://raw.githubusercontent.com/binance-chain/node-binary/master/install.sh)
```
The script will install the `lightd` binaries. Verify that everything is OK:

```shell
./lightd --help
This node will run a secure proxy to a binance rpc server.

All calls that can be tracked back to a block header by a proof
will be verified before passing them back to the caller. Other that
that it will present the same interface as a full binance node,
just with added trust and running locally.

Usage:
  lite [flags]

Flags:
      --cache-size int             Specify the memory trust store cache size (default 10)
      --chain-id string            Specify the binance chain ID (default "bnbchain")
  -h, --help                       help for lite
      --home-dir string            Specify the home directory (default ".binance-lite")
      --laddr string               Serve the proxy on the given address (default "tcp://localhost:27147")
      --max-open-connections int   Maximum number of simultaneous connections (including WebSocket). (default 900)
      --node string                Connect to a binance node at this address (default "tcp://localhost:27147")
```

## Get Started

Start your Light Client with the following command:
```shell
lightd --chain-id "{chain-id}" --node tcp://{full node addr}:80 > node.log  &
```
* chain-id: it should be the network that you want join in
* full node addr: it can be your own Full Node or public [Witness Node]()

<!--DOCUSAURUS_CODE_TABS-->
<!--Mainnet-->
```bash
./lightd --chain-id "Binance-Chain-Tigris" --node tcp://dataseed1.binance.org:80 > node.log  &
```
<!--Testnet-->
```bash
./lightd --chain-id "Binance-Chain-Ganges" --node tcp://data-seed-pre-0-s1.binance.org:80 > node.log  &
```
<!--END_DOCUSAURUS_CODE_TABS-->

## Working with the Light Client

Light client has the same RPC interface as [Node RPC]().<br/>
The default port of light client is `27147`.
