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
cd node-binary/lightd/{network}
```

Start the light client node according to the Platform. Replace the `platform` var with `mac` or `linux` in the following command:
```bash
./{{platform}}/lightd --chain-id "{chain-id}"    --node tcp://{full node addr}:80  > node.log  &
```

There are two parameters you need to figure out to start a light client node: `chain id` and `full node addr`.
The `chain id` of the network that you want join in. You can find chain id at [genesis file in test network](https://github.com/binance-chain/node-binary/blob/master/fullnode/testnet/node/config/genesis.json)
or [genesis file in prod network](https://github.com/binance-chain/node-binary/blob/master/fullnode/prod/node/config/genesis.json).
 The `full node addr` can be any full nodes you have deployed. You can
refer to [Run a Binance Chain full node](fullnode.md) to get more detailed. We supply a bunch of full nodes that you can
connect in testnet.
You cat get full nodes info through a simple python script(notice to replace domain according to different network):
```python
import requests, json
d = requests.get('https://testnet-dex.binance.org/api/v1/peers').text
l = json.loads(d)
fullnodes = [(fullnode["listen_addr"].strip("http://")) for fullnode in l if "accelerated" not in fullnode ]
print fullnodes
```

example:
```bash
./lightd --chain-id "Binance-Chain-Nile"    --node tcp://data-seed-pre-0-s1.binance.org:80  > node.log  &
```


## Work with light client

Light client has the same RPC interface as the list here [rpc-api](api-reference/node-rpc.md), also the default port of light
client is `27147`.
