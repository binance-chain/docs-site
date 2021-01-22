# Mirror BEP2 and BEP20 Token

> Note: this feature is only available in Testnet after Lagrange Upgrade.

## Prerequisit

This BEP20 token is not bond to any BEP2 token

## Motivation

Anyone can call the `mirror` [method](https://github.com/binance-chain/bsc-genesis-contract/blob/af4f3993303213052222f55c721e661862d19638/contracts/TokenManager.sol#L331) to issue a BEP2 token automatically and bind them.

## What happen under the hood

- Verify there is no pending mirror request
- Check the total supply and token symbol is valid
- Send a cross-chain package to issue a BEP2 token on Binance Chain
- The newly created BEP2 token is locked until token holder send cross-chain transfer


After binding, all liquid circulation is on BSC.


## Fee Table

Transaction Type  | Pay in BNB |
-- | -- |
mirror|it's 10 BNB in testnet now |
Relayer Fee|it's 0.01BNB in testnet now |

To query 	`mirrorFee` from system contract;

- Call `Tokenmanager` [Contract](https://testnet.bscscan.com/address/0x0000000000000000000000000000000000001008#writeContract) with the latest [ABI](https://github.com/binance-chain/bsc-genesis-contract/blob/master/abi/tokenmanager.abi )

- Query `mirrorFee` function

Fee= result/1e18

To query 	`relayerFee` from system contract;

- Call `TokenHub` [Contract](https://testnet.bscscan.com/address/0x0000000000000000000000000000000000001008#writeContract) with the latest [ABI](https://github.com/binance-chain/bsc-genesis-contract/blob/master/abi/tokenhub.abi )

- Query `getMiniRelayFee` function

Fee= result/1e18

## Mirror With MyEtherWallet

- Call `Tokenmanager` Contract

Use the latest [ABI](https://github.com/binance-chain/bsc-genesis-contract/blob/master/abi/tokenmanager.abi )

<img src="https://lh5.googleusercontent.com/SYyvWVcLHELSE72JSXqBwMJB6Y50jMz5HgH6irmCbyxGwr-W_Hz-vbm4IqWXAqE2hvCAXaqNKfs28ZhGFtMrMrDgWvDfEkHPunnSuxSKPpLBtuxmiX-b5yRjfczENJxKDrqSAYWy" alt="img" style="zoom:75%;" />

- Select `mirror` function and fill-in with your BEP20 address

The value here should be no less than  `mirrorFee`+ `Relayer Fee`. Besides, `mirrorFee` can be changed by on-chain governance

Time stamp should be greater than `unix_timestamp(now())`. The difference is between 120 and 86400. It's recommended to use `unix_timestamp(now())+1000`

<img src="https://lh3.googleusercontent.com/_DpAMjJwZeujn5bud485SPV014Gf4W8DRIcN9Y9FQyPxt3bveWPK8BImBbKF8pNHlE33a88I3aFLfP04uDZ8iFDvnUHtIj8cTuk_uEmImhsOmDU01UxtkNiHYNKxPGQ5jzLMpTzm" alt="img" style="zoom:75%;" />

All set!

<img src="https://lh4.googleusercontent.com/4SrlLnt8g699kcX6cRYviG1GXko7QQQsym4vShNOz3BVvlR9qUtCxGjoK5Mo8XUK23YQUTjgrPXRKLN9Qk_DVkmoVCEhO9K4g94CkrgJM6P8xTb4rV5r2TF0t61EKfxzS3M6fIyB" alt="img" style="zoom:67%;" />

## Query BEP2 Token Symbol

You can query BEP2 Token symbol from `tokenhub` contract.

Use the latest [ABI](https://raw.githubusercontent.com/binance-chain/bsc-genesis-contract/master/abi/tokenhub.abi)

Select `getBoundBep2Symbol` function

Then, you can see the tolen symbol in the result.

<img src="https://lh6.googleusercontent.com/i1NSu3t9lWEo5lRmsNw7moE_okqZe7VOto1vjGl3MXhQIoNJUJ0wMEwx-68LYRfMKbTs8TfCXzPGWJ7Oj9nSdtF3vo4wVnb_QFCeeC6RQk6kweQOe61_isnt8BOQs7mGmPpz7PKP" alt="img" style="zoom:67%;" />