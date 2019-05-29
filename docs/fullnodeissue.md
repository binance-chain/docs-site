# Common Issues When Running a Full Node

+ [How to monitor your full node syncing process?](#how-to-monitor-your-full-node-syncing-process)
+ [Common Issues](#common-issues)
    - [AppHash Confliction](#apphash-confliction)
        - [Peer connection error](#peer-connection-error)
        - [Connection Timeout](#connection-timeout)
        - [Out of memory](#out-of-memory)
        - [No priv_validator_state.json after reset](#no-priv_validator_statejson-after-reset)


### How to monitor your full node syncing process?

* You can check the current height of full node by visiting `localhost:26657/status`
* You can check the log info in your log under your $BNCHOME.<br/>
Monitor the output with:
```
tail -f $BNCHOME/bnc.log
```
### Common Issues

If you start running a full node from scratch, you are likely to encounter the following issues:

#### AppHash Confliction

* Error Log
```
panic: Tendermint state.AppHash does not match AppHash after replay. Got XXXXXXX, expected 251DF08F2BA7824F0875D33992CF03EA35106DDD34B3A9FE4EFA0B73CDD2FE14
```
This error is caused by a consensus issue and thus bnbchaind will panic.

* Solution

To solve this issue, make sure that you have downloaded the correct genesis file.<br/>
If you replaced the genesis file, then you need to do a node reset.<br/>
To reset node:
```
rm $BNCHOME/data

rm $BNCHOME/config/priv_validator_key.json
```
Then, start again.

#### Peer connection error

* Error log:
```
E[2019-04-17|23:52:24.069] Connection failed @ recvRoutine (reading byte) module=p2p peer=[aea74b16d28d06cbfbb1179c177e8cd71315cce4@54.64.99.130:27146](http://aea74b16d28d06cbfbb1179c177e8cd71315cce4@54.64.99.130:27146)conn=MConn{[52.199.237.19:27146](http://52.199.237.19:27146)} err=EOF
E[2019-04-17|23:52:24.070] Stopping peer for error module=p2p peer=&quot;Peer{MConn{[52.199.237.19:27146](http://52.199.237.19:27146)} aea74b16d28d06cbfbb1179c177e8cd71315cce4 out}&quot; err=EOF
```

This error is caused by the handshake failing between two peers.

* Solution

To solve this problem, you need to make sure node_key.json is under `$BNCHOME/config` and nodes will try to re-connect automatically, so this issue should not persist.

#### Connection Timeout

* Error log
```
Dialing failed module=pex addr=2c1fa9c1698961da38d8cd50da9fe8b4bc433c50@34.202.245.91:26856 err=&quot;dial tcp 34.202.245.91:26856: i/o timeout&quot; attempts=3
```

* Solution

Check your internet connection and make sure it is stable.

#### Out of memory

* Error Log
```
fatal error: out of memory
```

* Solution

Your machine must have more than `16 GB of memory`, otherwise, it will not handle DB restoration during state sync.

#### No priv_validator_state.json after reset

* Error log
```
open /Users/.bnbchaind/data/priv_validator_state.json: no such file or directory
```
* Solution

Delete both `priv_validator_state.json` file and `data` folder if you want to reset your full node.