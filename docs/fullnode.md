# Run Full Node to Join Binance Chain
- [Run Full Node to Join Binance Chain](#run-full-node-to-join-binance-chain)
  * [Platforms and System Requirement](#platforms-and-system-requirement)
    + [Platforms Requirements](#platforms-requirements)
    + [Minimum System Requirements](#minimum-system-requirements)
  * [Steps to Run a Full Node](#steps-to-run-a-full-node)
    + [Download Binary:](#download-binary-)
    + [Initialize Home Folder](#initialize-home-folder)
    + [Setup Configuration](#setup-configuration)
    + [Add Seed Nodes](#add-seed-nodes)
      - [More Configurations](#more-configurations)
      - [Start your node](#start-your-node)
      - [Sync Data](#sync-data)
        * [Fast Sync](#fast-sync)
        * [State Sync](#state-sync)
        * [Monitor Syncing Process](#monitor-syncing-process)
  * [Upgrade a Full Node](#upgrade-a-full-node)
  * [Monitor](#monitor)
  * [Get Extra Data From Your Full Node](#get-extra-data-from-your-full-node)
  * [Common Issues and Solutions](#common-issues-and-solutions)


>Note:  Please take a note that this is a pre-alpha version and the software is not stablized. Many changes and upgrades are expected to come.

A `full node` of Binance Chain is a `witness`, which observes the consensus messaging,
downloads blocks from `data seed nodes` and executes business logic to achieve the consistent state as `validator node` (and other `full node`).
Full nodes also help the network by accepting transactions from other nodes and then relaying them to the core Binance network.

## Requirements

### Platforms Requirements

We support running a full node on `Mac OS X` and `Linux`.

### Minimum System Requirements
The hardware must meet certain requirements to run a full node.

- Desktop or laptop hardware running recent versions of Mac OS X, or Linux.
- 500 GB of free disk space, accessible at a minimum read/write speed of 100 MB/s.
- 4 cores of CPU and 8 gigabytes of memory (RAM).
- A broadband Internet connection with upload/download speeds of at least 1 megabytes per second
- Your full node has to run at least 4 hours per 24 hours in order to catch up with Binance Chain.
More hours would be better, and best of all would be if you can run your node continuously.

## Steps to Run a Full Node

###  Download Binary:
```bash
git clone https://github.com/binance-chain/node-binary.git
```

Go to directory according to the network you want to join in. Replace the `network` var with `testnet` or `prod` in the following command:

> Please go to https://github.com/binance-chain/node-binary/blob/master/fullnode/Changelog.md  to get the information about the latest release of full node version.

```bash
cd node-binary/fullnode/{network}/{version}
```
###  Initialize Home Folder

First you need to choose a home folder `$BNCHOME` (i.e. ~/.bnbchaind) for Binance Chain. You can setup this by:

```
mkdir ~/.bnbchaind
mkdir ~/.bnbchaind/config
```

###  Setup Configuration

Put `app.toml`, `config.toml` and `genesis.json` from `node-binary/fullnode/{network}/{version}/config/` into `$BNCHOME/config`

### Add Seed Nodes

For a full node, it must connect to one or more known nodes to join Binance Chain. There are several famous `seed node` that offer known nodes address of the network to newly joined full nodes. They are already in `node-binary/fullnode/{network}/{version}/config/config.toml` together with full node we released.

You cat also get seeds info through a simple python script(notice to replace domain according to different network):
```python
import requests, json
d = requests.get('https://dex.binance.org/api/v1/peers').text # replace dex.binance.org with testnet-dex.binance.org for testnet
l = json.loads(d)
seeds = ",".join([ (seed["id"]+"@"+seed["original_listen_addr"]) for seed in l if "accelerated" not in seed ])
print seeds
```

If you want to add  seed nodes, please feel free to edit the field `seeds` of `$BNCHOME/config/config.yaml` with returned seed node info from previous request.

####  More Configurations

- Log: The log file is under `home`- the directory specified when starting `bnbchaind`. The latest log file is `bnc.log`. The process will create a new log file every one hour. To make sure you have sufficient disk space to keep the log, we strongly recommend you to change the log location by changing `logFileRoot` option in `$BNCHOME/config/app.toml`.
- Service Port: RPC service listen on port 27147 and P2P service listens on port 27146 by default. Make sure these two ports are open before starting a full node, unless the full node has to listen on other ports.
- Store: All the state and block data will store under `$BNCHOME/data`, do not delete or edit any of these files.

#### Start your node

Start the full node according to the platform. Replace the `platform` var with `mac` or `linux` in the following command:
```bash
./{{platform}}/bnbchaind start --home $BNCHOME --pruning breathe &
```

Only after catching up with Binance Chain, the full node can handle requests correctly.

#### Sync Data

There are two ways for you to get synced with other peers in blockchain network:
* Fast sync
* State Sync

#####  Fast Sync
The default way for syncing with other data seed node is fast sync. In fast sync, you need to download all the blocks from your peers and execute all the transansaction in every block. The sync speed is about 20 blocks/s, which is slower than state sync.

Configuration for `$BNCHOME/config/config.toml`:

* `fast_sync` Must be set to `true`
* `state_sync_reactor` Must be set to `false`
* `state_sync` Must be set to `false`

#####  State Sync

> Caution: this function is under refactoring.

State sync will get the application state of your full node to be up to date without downloading all the blocks.  The sync speed is faster than fast sync. But, you need to allocate more than 16 GB memory to your full node for this feature.

Configuration for `$BNCHOME/config/config.toml`:

* `state_sync_reactor` Must be set to `true`
* `state_sync` Must be set to `true`
* `recv_rate` Must set to `102428800`
* `ping_interval` Suggest set to `10m30s`
* `pong_interval` Suggest set to `450s`

State sync can help fullnode in same status with other peers within short time (according to our test, a one month ~800M db snapshot in binance chain testnet can be synced around 45 minutes) so that you can receive latest blocks/transactions and query latest status of orderbook, account balances etc.. But state sync DOES NOT download historical blocks before state sync height, if you start your node with state sync and it synced at height 10000, then your local database would only have blocks after height 10000.

If full node has already started, suggested way is delete (after backup) `$BNCHOME/data` directory and `$BNCHOME/config/priv_validator_key.json` before enable state sync.
##### Monitor Syncing Process
You can verify whether state sync is done by `curl localhost:27147/status` several times and see whether `latest_block_height` is incresing in response.

```
"sync_info": {
  ...
  "latest_block_height": "878092",
  "latest_block_time": "2019-04-15T00:01:22.610803768Z",
  ...
}
```

If state sync is not success, please repeat deletion of `$BNCHOME/data` directory and `$BNCHOME/config/priv_validator_key.json` before start full node next time in case data inconsistency.

Once state sync is succeed, later full node restart would not state sync anymore (in case the local blocks are not continuous). But if you do want state sync again (don't care missing blocks between last stop and latest state sync snapshot) and keep already synced blocks, you can just delete `$BNCHOME/data/STATESYNC.LOCK`.

For example, you start your full node at Jan 1st with state sync at height 10000 and after play a while shutdown it at height 22000 on Feb 10th. Now its Mar 1st, latest synable block height is 50000, you don't care blocks between 22000 and 50000, you can delete `$BNCHOME/data/STATESYNC.LOCK` before start your node. Then the full node would continue state sync from height 50000.

Turning off `state_sync_reactor` and `state_sync` can save your memory after you successfully state synced.

## Upgrade a Full Node

For most cases, download the new binary and replace it, then restart the full node will work. For the special case, you may have to run some extra steps for an incompatible version (hard fork).

## Monitor

Prometheus is enabled on port 26660 by default, and the endpoint is `/metrics`.

## Get Extra Data From Your Full Node

Full node has the same RPC interface as the list here [rpc-api](api-reference/node-rpc.md)

If you want to get extra information about order book, balance changes or block fee changes from blocks, please refer to [get extra data from fullnode](get-extra-data-from-fullnode.md).

## Common Issues and Solutions

Please refer to this [doc](fullnodeissue.md) to find answers to common issues.

