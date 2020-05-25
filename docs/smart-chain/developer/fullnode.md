# How to Run A Fullnode on Binance Smart Chain

!!! Tip
       Please take a note that this software is not stabilized. Many changes and upgrades are expected to come.

## Fullnodes Functions

* Stores the full blockchain history on disk and can answer the data request from the network.
* Receives and validates the new blocks and transactions.
* Verifies the states of every accounts.

## Supported Platforms

We support running a full node on `Mac OS X`and `Linux`.

## Minimum Requirements

The hardware must meet certain requirements to run a full node.

- VPS running recent versions of Mac OS X or Linux.
- 500 GB of free disk space
- 8 cores of CPU and 16 gigabytes of memory (RAM) for mainnet.
- 4 cores of CPU and 8 gigabytes of memory (RAM) for testnet.
- A broadband Internet connection with upload/download speeds of at least 1 megabyte per second

## Settings

### Sync Mode

* Fast Sync

The **default** sync mode. Synchronizes a full node doing a fast synchronization by downloading the entire state database, requesting the headers first, and filling in block bodies and receipts afterward. Once the fast sync reaches the best block of the Ethereum network, it switches to full sync mode.

* Full Sync

Synchronizes a full node starting at genesis, verifying all blocks and executing all transactions. This mode is a bit slower than the fast sync mode but comes with increased security.


## Steps to Run a Fullnode

1.Build from source code

Make sure that you have installed [Go 1.13+](https://golang.org/doc/install) and have added `GOPATH` to `PATH` environment variable

```bash
git clone -b v1.9.13-alpha.0 https://github.com/binance-chain/bsc
# Enter the folder bsc was cloned into
cd bsc
# Comile and install bsc
make geth
```

or you can download the pre-build binaries from [release page](https://github.com/binance-chain/smart-chain-binary/tree/master/bsc)

2.Download the config files

You need to have [genesis.json](https://github.com/binance-chain/smart-chain-binary/blob/master/bsc/fullnode/config/genesis.json) and [config.toml](https://github.com/binance-chain/smart-chain-binary/blob/masterx/bsc/fullnode/config/config.toml)


3.Write genesis state locally

```bash
geth --datadir node init genesis.json
```

You could see the following output:

```
INFO [05-19|14:53:17.468] Allocated cache and file handles         database=/Users/huangsuyu/Downloads/bsc/node/geth/chaindata cache=16.00MiB handles=16
INFO [05-19|14:53:17.498] Writing custom genesis block
INFO [05-19|14:53:17.501] Persisted trie from memory database      nodes=21 size=56.84KiB time=357.915µs gcnodes=0 gcsize=0.00B gctime=0s livenodes=1 livesize=-574.00B
INFO [05-19|14:53:17.502] Successfully wrote genesis state         database=chaindata hash=7d79cc…fb0d1e
INFO [05-19|14:53:17.503] Allocated cache and file handles         database=/Users/huangsuyu/Downloads/bsc/node/geth/lightchaindata cache=16.00MiB handles=16
INFO [05-19|14:53:17.524] Writing custom genesis block
INFO [05-19|14:53:17.525] Persisted trie from memory database      nodes=21 size=56.84KiB time=638.396µs gcnodes=0 gcsize=0.00B gctime=0s livenodes=1 livesize=-574.00B
INFO [05-19|14:53:17.528] Successfully wrote genesis state         database=lightchaindata hash=7d79cc…fb0d1e
```

4.Start your fullnode or a validator node

```bash
## start a full node
geth --config ./config.toml --datadir ./node --pprofaddr 0.0.0.0 --metrics --pprof
```


start a validator node

```bash

geth --config ./config.toml --datadir ./node -unlock {your-validator-address} --mine --allow-insecure-unlock  --pprofaddr 0.0.0.0 --metrics --pprof
```

5.Monitor node status

you can monitor the log from `/node/bsc.log` by default.


