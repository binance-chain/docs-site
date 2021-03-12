# Best Practice

## Store your BNB with a hardware wallet

The most valuable assets of a validator are two keys: one for signing transactions and another for signing blocks


## Securing your fullnode RPC from hackers

Please do not expose your RPC endpoints to public network.


## Account Private keys

To protect your BNB, do not share your 24 words with anyone. The only person who should ever need to know them is you. In short, HSMs are affordable, performant and portable pieces of hardware that help to securely generate, store and manage your private keys. Malware attacks and remote extraction of private keys are much more difficult when an HSM is configured properly.

## Software Vulnerabilities

To protect your BNB, you should only download software directly from official sources, and make sure that you're always using the latest, most secure version


## Running Server as a Daemon
It is important to keep `geth` running at all times. There are several ways to achieve this, and the simplest solution we recommend is to register `geth`  as a systemd service so that it will automatically get started upon system reboots and other events.


## Set up a backup node
* Run validator node in archive mode
* Shut down nodes gracefully
* Active monitoring with tools

## Steps to run a backup node
1. Install the latest version of geth
2. Sync to the latest height using fast sync mode. You can either download the latest snapshot or start fast sync
once your node is fully synced
3. Shut down your node gracefully kill -HUP $(pgrep geth)
4. Restart your node with `--gcmode archive `

### Why node will be offline for a while after restart? or What will happen if client been force killed

After running (synchronized) for a long period of time and being abruptly terminated, only archived nodes are expected to quickly re-synchronize upon restart.

Steps to reproduce:

* Run the node synchronized for a period of time.
* Abruptly kill the node (kill -9 or system crash).
* Restart the node, observe where it resynchronizes from block height 1 hour ago.


**Reasons**

If Geth crashes (or is not shut down gracefully), the recent state held in memory is lost and needs to be regenerated. It takes Geth a long time to restore the states.

The root reason is that `geth` does flush the state trie periodically. The period is defined as `trieTimeout` in `config.toml`.



## How to upgrade a backup node to become a validator node?


* Make sure `geth` process is shut down completely
* Copy keystore folder from validator’s machine to backup node’s
* Shutdown the running `geth` process of backup node
* Restart `geth` with  `--gcmode archive --unlcok {your consensus ccount} --mine --password {your password file} --allow-insecure-unlock`




