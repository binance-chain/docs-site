# BEP89

> Note: this feature is only available in Testnet after Lagrange Upgrade.


## Motivations

Peer-to-peer networking is a mess. Generally only a small fraction of nodes have publicly routed addresses and P2P networks rely mainly on these for forwarding data for everyone else. The best way to maximize the utility of the public nodes is to ensure their resources aren’t wasted on tasks that are worthless to the network.


By aggressively cutting off incompatible nodes from each other we can extract a lot more value from the public nodes, making the entire P2P network much more robust and reliable. Supporting this network partitioning at a discovery layer can further enhance performance as we avoid the costly crypto and latency/bandwidth hit associated with establishing a stream connection in the first place.

## Implementatiion

Introducing BEP89 to allow nodes to signal different chains, which will help with peering efficiency. Binance Smart Chain full nodes are able to display the whole view of validators that on different upcoming forks.

The proposal `FORK_HASH` takes an "IEEE CRC32 checksum ([4]byte) of the genesis hash + fork blocks numbers that already passed. By aggressively cutting  off incompatible nodes, we avoid the costly crypto and latencyor bandwidth issues when  establishing a stream connection.

Example log of warning:

```
t=2021-01-20T21:40:09+0800 lvl=warn msg="there is a possible fork, and your client is not the majority. Please check..." nextForkHash=cd0d163d
t=2021-01-20T21:40:09+0800 lvl=warn msg="there is a possible fork, and your client is not the majority. Please check..." nextForkHash=cd0d163d
t=2021-01-20T21:40:09+0800 lvl=warn msg="there is a possible fork, and your client is not the majority. Please check..." nextForkHash=cd0d163d
t=2021-01-20T21:40:09+0800 lvl=warn msg="there is a possible fork, and your client is not the majority. Please check..." nextForkHash=cd0d163d
t=2021-01-20T21:40:09+0800 lvl=warn msg="there is a possible fork, and your client is not the majority. Please check..." nextForkHash=cd0d163d
t=2021-01-20T21:40:09+0800 lvl=warn msg="there is a possible fork, and your client is not the majority. Please check..." nextForkHash=cd0d163d
t=2021-01-20T21:40:09+0800 lvl=warn msg="there is a possible fork, and your client is not the majority. Please check..." nextForkHash=cd0d163d
```
You can see the implementation in this [PR](https://github.com/binance-chain/bsc/pull/53)


