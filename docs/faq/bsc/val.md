# Binance Smart Chain Validator

## How does a validator node work?

It powers the blockchain network by processing transactions and signing blocks.

## What are the incentives to run a validator node?

Validators and delegators will earn rewards from transaction fees: dApp usages

## What's on-chain governance proposal?

The proposal will decide: slash amount, cross-chain transfer fees

## How to join testnet as a validator?

1. Chooe your own server/PC
2. Install software:
3. Create a wallet and get some BNB
4. Run your fullnode and keep it synced
5. Stake your BNB on BC, the top 21 most staked nodes to be the validator set

## How to join mainnet as a validator?

1. Chooe your own server/PC
2. Install software:
3. Create a wallet and get some BNB
4. Run your fullnode and keep it synced
5. Stake your BNB on BC, the top 21 most staked nodes to be the validator set"

## What are hardware requirements of running a validator node?

Processing transactions is mostly CPU bound. Therefore we recommend running CPU optimized servers.
Directly facing internet (public IP, no NAT)
8 cores CPU
16GB of RAM
500 SSD storage"

## How many BNB are required to create a validator?

Validators can self-bond, meaning they can delegate BNB to themselves, and they can also receive delegations from any other BNB holders. These bonded BNB acts as collateral and cause each delegate, including validators, to have “skin in the game” so to speak. If any equivocation or byzantine behavior by a validator were to be committed, the validator and its delegates would be slashed a predefined amount of bonded stake.

The [minimum self-delegated amount](../../smart-chain/validator/Parameters.md) is **10000BNB**.

## When are rewards paid out?

The rewards will not be sent to validator right away, instead, they will be distributed and accumulated on a contract. The reward distribution happens on BC around every day UTC 00:00.

## What's the potential loss for validators?

Validators can suffer from “Slashing”, a punishment for their bad behaviors, such as double sign and/or instability. Such loss will not be shared by their delegators.

Slashing is a punitive function that is triggered by a validator ’s bad actions. Getting slashed is losing self delegation of a validator. Validators will be slashed for the actions below:

* Going offline or unable to communicate with the network.
* Double signing. If a validator node tries to split the network by signing two different blocks and broadcasting them, it will be removed from validator set definitely.


* [minimum self-delegated amount](../../smart-chain/validator/Parameters.md): **10000BNB**

* Unbonding time: 7 days

* offline Unjail fee:  1BNB

* offline Jailed time: 2 days. A validator can only unjail 2 days later after it has been jailed

* offline slashing amount: 50BNB

* Double-sign slashing amount: 10000BNB


## Does an inactive validator receive any rewards?

No, they will not.

## Can I receive my staking rewards if my chosen validator is inactive?

No, you cannot.

## When can I receive my unstaked BNB?

After you sent `undelegate` transaction, you have to wait 7 days. This period starts at UTC 00:00 next day



