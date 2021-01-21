# Sync BEP2 and BEP20 Token Supply

> Note: this feature is only available in Testnet after Lagrange Upgrade


## Prerequisit

This BEP20 token is [mirrored](./mirror.md) to a BEP2 token.

## Motivation

For a BEP20 token that has been mirrored to BC, anyone can call the `sync` method to balance the total supply on BC and BSC. Thus, the total supply among two blockchain will remain the same.

## What happen under the hood

- Verify there is already mirrored
- Check the total supply and token symbol is valid
- Send a cross-chain package to modify a BEP2 token total supply on Binance Chain


After syncing, the total circulation is the same.


## Fee Table

Transaction Type  | Pay in BNB |
-- | -- |
sync| it's 1BNB in testnet now |
relayerFee| it's 0.01BNB in testnet now|

To query 	`syncFee` from system contract;

- Call `Tokenmanager` [Contract](https://testnet.bscscan.com/address/0x0000000000000000000000000000000000001008#writeContract) with the latest [ABI](https://github.com/binance-chain/bsc-genesis-contract/blob/master/abi/tokenmanager.abi )

- Query `syncFee` function

Fee= result/1e18

To query 	`relayerFee` from system contract;

- Call `TokenHub` [Contract](https://testnet.bscscan.com/address/0x0000000000000000000000000000000000001008#writeContract) with the latest [ABI](https://github.com/binance-chain/bsc-genesis-contract/blob/master/abi/tokenhub.abi )

- Query `getMiniRelayFee` function

Fee= result/1e18

## Mirror With MyEtherWallet

- Call `Tokenmanager` Contract

Use the latest [ABI](https://github.com/binance-chain/bsc-genesis-contract/blob/master/abi/tokenmanager.abi )

<img src="https://lh5.googleusercontent.com/SYyvWVcLHELSE72JSXqBwMJB6Y50jMz5HgH6irmCbyxGwr-W_Hz-vbm4IqWXAqE2hvCAXaqNKfs28ZhGFtMrMrDgWvDfEkHPunnSuxSKPpLBtuxmiX-b5yRjfczENJxKDrqSAYWy" alt="img" style="zoom:75%;" />

- Select `sync` function and fill-in with your BEP20 address

The value here should be no less than  `syncFee`+ `Relayer Fee`. Besides, `syncFee` can be changed by on-chain governance

Time stamp should be greater than `unix_timestamp(now())`. The difference is between 120 and 86400. It's recommended to use `unix_timestamp(now())+1000`


<img src="https://lh5.googleusercontent.com/EIgRKIBY8unMsuSBa88jY_EXdJeO1WtaXTQLV905AZmPJDsN72chHcPZrDEWOeD8m1a1awEwP43Uh0eFURLXSKQvnfc3J9YzWLYuBvAeVwIwicKfLUZlCkvkR0NdWxkYWAQKa3Ii" alt="img" style="zoom:67%;" />

All set!