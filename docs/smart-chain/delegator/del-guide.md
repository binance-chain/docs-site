# How to Delegate on Testnet

## Create an account

Please refer to this guide on [how to create a wallet](../wallet/metamask.md) with MetaMask

## Get some testnet fund from faucet

Go to this faucet page: <https://testnet.binance.org/faucet-smart>

## Transfer BNB from BSC to BC

Please refer to this [guide](../validator/cross-chain-transfer.md)

## Choose a validator

You can use `tbnbcli` for querying the [list of current validators](../../guides/concepts/bc-staking.md#query-side-chain-top-validators).

```bash
tbnbcli staking side-top-validators --top 10 --side-chain-id=chapel --chain-id=Binance-Chain-Ganges
```

## Delegate BNB

You can use `tbnbcli` to [delegate](../../guides/concepts/bc-staking.md#delegate-bnb) some of BNB to a validator

Go to [explorer](https://explorer.binance.org/testnet/) to verify your transactions.

## Undelegate BNB

You can use `tbnbcli` to [undelegate](../../guides/concepts/bc-staking.md#undelegate-bnb) some bonded BNB from a validator
