# Run Full Node to Join Binance Chain
- [Run Full Node to Join Binance Chain](#run-full-node-to-join-binance-chain)
- [Supported Platforms](#supported-platforms)
- [Minimum System Requirements](#minimum-system-requirements)
- [Steps to Run a Full Node](#steps-to-run-a-full-node)
    + [Download Binary:](#download-binary)
    + [Initialize Home Folder](#initialize-home-folder)
    + [Setup Configuration](#setup-configuration)
    + [Add Seed Nodes](#add-seed-nodes)
        - [Additional Configuration](#additional-configuration)
        - [Start your node](#start-your-node)
        - [Sync Data](#sync-data)
            * [Fast Sync](#fast-sync)
            * [State Sync](#state-sync)
            * [Monitor Syncing Process](#monitor-syncing-process)
  * [Upgrading Full Node](#upgrading-full-node)
  * [Monitoring](#monitoring)
  * [Get Extra Data From Your Full Node](#get-extra-data-from-your-full-node)
  * [Common Issues and Solutions](#common-issues-and-solutions)


>Note: Please take a note that this is a pre-alpha version and the software is not stabilized.<br/>
Many changes and upgrades are expected to come.

A `full node` of Binance Chain is a `witness`, which observes the consensus messaging, <br/>
downloads blocks from `data seed nodes` and executes business logic to achieve the consistent state as `validator node` (and other `full node`).<br/>
Full nodes also help the network by accepting transactions from other nodes and then relaying them to the core Binance network.

## Supported Platforms

We support running a full node on `Mac OS X`, `Windows` and `Linux`.

## Minimum System Requirements

The hardware must meet certain requirements to run a full node.

- Desktop or laptop hardware running recent versions of Mac OS X, Windows, or Linux.
- 500 GB of free disk space, accessible at a minimum read/write speed of 100 MB/s.
- 4 cores of CPU and 8 gigabytes of memory (RAM).
- A broadband Internet connection with upload/download speeds of at least 1 megabyte per second
- Your full node has to run at least 4 hours per 24 hours in order to catch up with Binance Chain
More hours will be better, run your node continuously for best results.

## Steps to Run a Full Node

### Install Git LFS

Git Large File Storage (LFS) replaces large files such as audio samples, videos, datasets, and graphics with text pointers inside Git, while storing the file contents on a remote server like GitHub.com or GitHub Enterprise.

Please go to <https://git-lfs.github.com/> and install `git lfs`.

### Download Binary with Git LFS:

```bash
git lfs clone https://github.com/binance-chain/node-binary.git
```

Please go to [changelog](https://github.com/binance-chain/node-binary/blob/master/fullnode/Changelog.md) to get the information about the latest release of full node version.

Go to directory according to the network you want to join in.<br/>
Replace the `network` variable with `testnet` or `prod` in the following command:

```bash
cd node-binary/fullnode/{network}/{version}
```

### Initialize Home Folder

First you need to choose a home folder `$BNCHOME` (i.e. ~/.bnbchaind) for Binance Chain.<br/>
You can setup this by:

```
mkdir ~/.bnbchaind
mkdir ~/.bnbchaind/config
```

### Setup Configuration

Put `app.toml`, `config.toml` and `genesis.json` from `node-binary/fullnode/{network}/{version}/config/` into `$BNCHOME/config`

### Add Seed Nodes

For a full node to function, it must connect to one or more known nodes to join Binance Chain.<br/>
There are several famous `seed nodes` that offer known node addresses in the network to newly joined full nodes.<br/>
They are already in `node-binary/fullnode/{network}/{version}/config/config.toml` file.

You cat also get seeds info through a simple python script (replace domain name depending on which network you are using):

```python
import requests, json
d = requests.get('https://dex.binance.org/api/v1/peers').text # replace dex.binance.org with testnet-dex.binance.org for testnet
l = json.loads(d)
seeds = ",".join([ (seed["id"]+"@"+seed["original_listen_addr"]) for seed in l if seed["accelerated"] == False])
print (seeds)
```

If you want to add seed nodes, please feel free to edit the field `seeds` of `$BNCHOME/config/config.yaml` with returned seed node info from previous request.

#### Additional Configuration

- Log: The log file is under `home`- the directory specified when starting `bnbchaind`.<br/>
The latest log file is `bnc.log`. The process will create a new log file every one hour.<br/>
To make sure you have sufficient disk space to keep the log files, we strongly recommend you to change the log location by changing `logFileRoot` option in `$BNCHOME/config/app.toml`.<br/>
- Service Port: RPC service listens on port `27147` and P2P service listens on port `27146` by default.<br/>
Make sure these two ports are open before starting a full node, unless the full node has to listen on other ports.
- Store: All the state and block data will store under `$BNCHOME/data`, do not delete or edit any of these files.

#### Start your node

Start the full node according to the platform.<br/>
Replace the `platform` variable with `mac` `windows` or `linux` in the following command:

```bash
./{{platform}}/bnbchaind start --home $BNCHOME&
```

Only after catching up with Binance Chain, the full node can handle requests correctly.

#### Sync Data

There are two ways for you to get synced with other peers in blockchain network:
* Fast Sync
* State Sync

These two method can be used together.

##### Fast Sync
The default way for syncing with other data seed node is fast sync.<br/>
In fast sync, you need to download all the blocks from your peers and execute all the transaction in every block.<br/>
The sync speed is about 20 blocks/s, which is slower than state sync.

Configuration is located in `$BNCHOME/config/config.toml`:

* `fast_sync` Must be set to `true`
* `state_sync_reactor` Can be set to `false` or `true`
* `state_sync` Can be set to `false` or `true`

##### State Sync

`Caution: this function is under refactoring.`

State sync will get the application state of your full node to be up to date without downloading all of the blocks.The sync speed is faster than fast sync.<br/>
But, you need to allocate more than `16 GB memory` to your full node for this feature to work.

Configuration is located in `$BNCHOME/config/config.toml`:

* `state_sync_reactor` Must be set to `true`
* `recv_rate` Must set to `102428800`
* `ping_interval` Recommendation is set to `10m30s`
* `pong_timeout` Recommendation is set to `450s`
* `state_sync_height` Recommendation is set to `0`, so it allows to state sync from the peers's latest height.

State sync can help fullnode in same status with other peers within short time (according to our test, a one month ~800M DB snapshot in binance chain testnet can be synced in around 45 minutes) so that you can receive latest blocks/transactions and query latest status of orderbook, account balances etc.. But state sync DOES NOT download historical blocks before state sync height, if you start your node with state sync and it synced at height 10000, then your local database would only have blocks after height 10000.

If full node has already started, suggested way is to delete the (after backup) `$BNCHOME/data` directory and `$BNCHOME/config/priv_validator_key.json` before enabling state sync.

##### Monitor Syncing Process

You can verify if state sync is done by `curl localhost:27147/status` several times and see whether `latest_block_height` is increasing in response.

```
"sync_info": {
  ...
  "latest_block_height": "878092",
  "latest_block_time": "2019-04-15T00:01:22.610803768Z",
  ...
}
```

If state sync did not succeed, please repeat deletion of `$BNCHOME/data` directory and `$BNCHOME/config/priv_validator_key.json` before starting full node next time in case of data inconsistency.

Once state sync succeeded, later full node restart would not state sync anymore (in case the local blocks are not continuous).<br/>
But if you do want state sync again (don't care that there are missing blocks between last stop and latest state sync snapshot) and you want to keep already synced blocks, you can just delete `$BNCHOME/data/STATESYNC.LOCK`.

For example, you start your full node at Jan 1st with state sync at height 10000 and after a while you shut it down at height 22000 on Feb 10th.<br/>
Now its Mar 1st, latest sync-able block height is 50000, you don't care blocks between 22000 and 50000, you can delete `$BNCHOME/data/STATESYNC.LOCK` before start your node.<br/>
Then the full node would continue state sync from height 50000.

Turning off `state_sync_reactor` and `state_sync` can save your memory after you successfully state synced.

## Upgrading Full Node

In most cases, download the new binary and replace it, then restart the full node.<br/>
In special cases, you may have to do extra steps for an incompatible version (hard fork).

## Monitoring

Prometheus is enabled on port `28660` by default, and the endpoint is `/metrics`.

## Get Extra Data From Your Full Node

Full node has the same RPC interface as the one listed here [rpc-api](api-reference/node-rpc.md)

If you want to get extra information about order book, balance changes or block fee changes from blocks, please refer to [getting extra data from fullnode](get-extra-data-from-fullnode.md).

## Common Issues and Solutions

Please refer to this [doc](fullnodeissue.md) to find answers to common issues.

