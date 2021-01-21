# Mirror BEP2 and BEP20 Token

> Note: this feature is only available in Testnet after Lagrange Upgrade.

## Motivation

If a BEP20 token is not bond to any BEP2 token, anyone can call the `mirror` [method](https://github.com/binance-chain/bsc-genesis-contract/blob/af4f3993303213052222f55c721e661862d19638/contracts/TokenManager.sol#L331) to issue a BEP2 token automatically and bind them.




The user must not have any BEP20 token and needs to pay enough BEP2 issue fee. Besides, the BEP20 contract is even not required to implement getOwner method. After binding, all the initial circulation is on BSC.

BC都锁定在死地址

