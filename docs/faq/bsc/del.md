# Binance Smart Chain Delegator

## What's the role of a delegator?

A delegator can delegate its BNB to a chosen validator to participate the consensus and earn rewards.


Staking BNB directly contributes to the security of the entire network.

## How to delegate my BNB?

Please read the guide [here](../../smart-chain/delegator/del-guide.md)

You can use:

* [command line tool](https://github.com/binance-chain/smart-chain-binary/tree/master/bc/cli)
* [Binance Chain extension wallet](../../smart-chain/wallet/binance.md)
* [Math Wallet](http://blog.mathwallet.xyz/?p=3890)


## How to undelegate my BNB?

Delegates and validators themselves may choose to unbond their BNB for a variety of reasons. It is important to note that these ATOMs are subject to what is known as the **UnbondingTime**, an on-chain parameterized period of time upon which all delegates, including validators, must wait for their BNB to become fully unbonded. In addition, these BNB are still subject to be potentially slashed upon commitment of any byzantine behavior. The **UnbondingTime** ensures a variety of security measures in the network, such as accounting for network synchrony assumptions, providing a lower bound for the length of a [long-range attack](https://cosmos.network/docs/spec/ibc/references.html#3) and solving the “nothing-at-stake” problem.

The current  **UnbondingTime**  in Binance Smart Chain mainnet is **7 days**.

## How to redelegate my BNB?

Redelegations between a unique delegator, source validator, and destination validator can only happen once every **UnbondingTime**

## How many tokens are required to stake BNB?

The [minimum delegated amount](../../smart-chain/validator/Parameters.md) is **1BNB**.

## How to claim my rewards?

The rewards will be distributed to every delegators from `bscvalidator` [smart contract](https://explorer.binance.org/smart-testnet/address/0x0000000000000000000000000000000000001000/transactions) everyday.

You can read about the details [here](../../guides/concepts/bc-staking.md)
