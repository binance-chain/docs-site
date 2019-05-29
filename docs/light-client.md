# Run a light client to join Binance Chain

Light client is a program that connect to a full node to help users access and interact with Binance chain
in a secure and decentralized manner without having to sync the full blockchain.

## Light Client Versus Full Node

- Light client do not store blocks or states so that it need less disk space(50 megabytes will be enough).
- Light client do not join p2p network and it do not produce any network cost when it is idle. The network
overhead depends on how many requests the light client handles concurrently.
- Light client do not replay state of the chain so that there is not cpu cost when idle. The cpu cost also
depends on how many requests the light client handles concurrently.
- Light client is more fast than full node even it lagged behind the core network monthly. It only need a few seconds
to catch up with core network.

## Platforms and System Requirement

### Platforms

We support running light client node on `Mac OS X` and `Linux`. The light client will soon be open source,
then you can cross compile light client binary and run it on other platforms.

### Requirements
Light client node has little requirements.

- 50 megabytes of free disk space.
- 0.2 cores of CPU, 50 megabytes of memory (RAM).

## Run a light client node

Download:
```bash
git clone https://github.com/binance-chain/node-binary.git
```

Go to directory according to the network you want to join in. Replace the `network` var with `testnet` or `prod` in the
following command:
```bash
cd node-binary/lightd/{network}/{version}
```

Help info:

```
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

You can specify all the parameters above.

Start the light client node according to the Platform. Replace the `platform` var with `mac` or `linux` in the following command:
```bash
./{{platform}}/lightd --chain-id "{chain-id}"    --node tcp://{full node addr}:80  > node.log  &
```

There are two parameters you need to figure out to start a light client node: `chain id` and `full node addr`.
The `chain id` of the network that you want join in. You can find chain id at [genesis file in test network](https://github.com/binance-chain/node-binary/blob/master/fullnode/testnet/0.5.8/config/genesis.json)
or [genesis file in prod network](https://github.com/binance-chain/node-binary/blob/master/fullnode/prod/0.5.8/config/genesis.json).

 The `node` field can be any full nodes you have deployed. You can
refer to [Run a Binance Chain full node](fullnode.md) to get more detailed. We supply a bunch of full nodes that you can

connect in testnet.
You cat get full nodes info through a simple python script(notice to replace domain according to different network):
```python
import requests, json
d = requests.get('https://dex.binance.org/api/v1/peers').text # replace dex.binance.org with testnet-dex.binance.org for testnet
l = json.loads(d)
seeds = ",".join([ (seed["id"]+"@"+seed["original_listen_addr"]) for seed in l if seed["accelerated"] == False])
print (seeds)
```

### Example for Mainnet:
```bash
./lightd --chain-id "Binance-Chain-Tigris"    --node tcp://dataseed1.binance.org:80 > node.log  &
```

### Example for Testnet:
```bash
./lightd --chain-id "Binance-Chain-Nile"    --node tcp://data-seed-pre-0-s1.binance.org:80  > node.log  &
```


## Work with light client

Light client has the same RPC interface as the list here [rpc-api](api-reference/node-rpc.md), also the default port of light
client is `27147`.
