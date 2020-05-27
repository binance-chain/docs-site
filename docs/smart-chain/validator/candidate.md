# How to become a Validator Candidate

## Install Fullnode

Please follow this [guide](../developer/fullnode.md) to install bsc fullnode locally.

## Create an account

You need to create an account that represents a key pair first. Use the following command to create a new account and set a password for that account:
```bash
geth account new
```

This command will return the public address and the path to your private key. BACKUP of keyfile is necessory!

If you already have an account, use the seed phrase to recover it:

```bash
geth account import
```
## Get some testnet fund from faucet

Go to this faucet page: <https://testnet.binance.org/faucet-smart>

## Start Fullnode on BSC Testnet

Please run this command to run a fullnode as validator candidate

```bash
geth --config ./config.toml --datadir ./node -unlock {validator-address} --mine --allow-insecure-unlock  --rpcapi "eth,web3,miner,net,admin,personal,debug" --metrics
```

## Transfer BNB from BSC to BC

Please refer to this [guide](../validator/cross-chain-transfer.md)

## Become a validator candidate

You can use `tbnbcli` to [declare your candidacy](../../guides/concepts/bc-staking.md#create-bsc-validator) some of BNB to a validator

Go to [explorer](https://explorer.binance.org/testnet/) to verify your transactions.

