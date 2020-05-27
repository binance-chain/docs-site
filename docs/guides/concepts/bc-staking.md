# Staking

## PoSA Consensus of Binance Smart Chain

[Binance Smart Chain](https://community.binance.org/topic/2686) is an innovative solution to bring programmability and interoperability to [Binance Chain](https://www.binance.org). Binance Smart Chain relies on a system of 21 validators with Proof of [Staked Authority (PoSA) consensus](../../smart-chain/guides/concepts/consensus.md) that can support short block time and lower fees. The most bonded validator candidates of staking will become validators and produce blocks. The double-sign detection and other slashing logic guarantee security, stability, and chain finality.

## Staking on Binance Chain

Ideally, Binance Smart Chain should build such staking and reward logic into the blockchain, and automatically distribute rewards as the blocking happens. [Cosmos Hub](https://hub.cosmos.network/), who also build on top of Tendermint consensus like Binance Chain, works in this way.

However, as BSC wants to remain compatible with Ethereum as much as possible. On the other side, Binance Chain already has a staking module and could be extended to support both BC and BSC. In this way, all the staking related operations are recorded in BC. Once there are any changes about BSC's validator set or voting power, the new message will be transferred to BSC through cross-chain communication.

## Staking Economics

1. The staking token is **[BNB](https://www.binance.com/cn/trade/BNB_USDT)**, as it is a native token on both blockchains anyway
2. The staking, i.e. token bond and delegation actions and records for BSC, happens on BC.
3. The BSC validator set is determined by its staking and delegation logic, via a staking module built on BC for BSC, and propagated every day UTC 00:00 from BC to BSC via Cross-Chain communication.
4. The reward distribution happens on BC around every day UTC 00:00.

## Ranking Algorithm

Validators are ranked by their power and operator address. The more its delegation tokens, the higher ranking is. If two validators get the same amount of delegated tokens, validator with smaller address bytes has higher ranking.

## Reward Distrubution

Since BSC uses PoSA as its consensus engine, all the delegators of validators can receive some share of the validators’ reward.

However, the rewards(fees) are collected on BSC while the staking info is stored on BC.

So the main idea is we transfer all the rewards from BSC to BC once every day and execute the distribution on BC.

### Main Workflow:
1. ValidatorSet is updated in BreatheBlock, the frequency is once a day. let’s assume it happens on day N.
2. The info of validator set changes of day N would be transmitted to BSCthrough interchain communication.
3. The validator set contract on BSC would receive and update the new validatorset.

After that, it would trigger several interchain transfer to transfer the fees that every **previous validators** collected in this period to their addresses on BC. we can see that fees belongs to the validators of day N-1.

4. To make some room for the error handling, we distribute the fees of day N-1 in the next breathe block (day N+1).

### Details

1. even if validator set or any their voting powers are not changed on that day, we still transmit the validator set info to BSC.
2. the validator set contract maintains a map like `ValidatorFeeMap` recording the fees value that every validators collected after the previous period(We define the **period**     as the time between two contract calls of validator set changes). The actual fees are collected on the contract address.
3. the interchain transfer to send fees from the contract address to each validator’s distribution address on BC. Note the distribution address is **auto generated** on BC when     handling the create-validator tx, so no private key is corresponded to     that address and no one except the distribution module can move the tokens     on that address.
4. we have a lower limit of the value of interchain transfer, at least the value can cover the transfer fee. Also, interchain transfer will only allow max 8 decimals for the amount. The tiny left part would be kept in the contract or put into the system reward pool.
5. the reward(totalfees \* commissionRate) would be distributed in proportion to the delegations, the left part would be sent to the validator fee address.

### Error handling:

1. if the cross-chain transfer failed, the tokens would be sent back to a specified address(i.e. the  `SideFeeAddr` in the store section, validators can change this address via the EditValidator tx). After that, validators can manually deposit the tokens to its own `DistributionAddr` on BC via Transfer tx. We do not force the validator to do so, but it’s an indicator that can help delegators choose validators.

## Fee Table

Transaction Type  | Pay in BNB |
-- | -- |
Create A New Smart Chain Validator | 10 |
Edit Smart Chain Validator Information| 1 |
Delegate Smart Chain Validator | 1 |
Redelegate Smart Chain Validator | 3 |
Undelegate Smart Chain Validator | 2 |


## Commands

### Download
Please download `tbnbcli` binary from [here](https://github.com/binance-chain/smart-chain-binary/tree/master/bc/cli)

### Create BSC Validator

#### Parameters for bsc-create-validator


| **parameter name**           | **example**                          | **comment**                                                  | **required** |
| ---------------------------- | ------------------------------------ | ------------------------------------------------------------ | ------------ |
| --chan-id                    | Binance-Chain-XXX                    | the chain id of binance  chain                               | Yes          |
| --from                       | bnb1xxx/tbnb1xxx                     | address of private key  with which to sign this tx, also be used as the validator operator address | Yes          |
| --address-delegator          | bnb1xxx/tbnb1xxx                     | optional, bech32 address  of the self-delegator. if not provided, --from address will be used as  self-delegator. | No           |
| --amount                     | 2000000000000:BNB  (means 20000 BNB) | self-delegation amount,  it has 8 decimal places             | Yes          |
| --moniker                    | myval1                               | validator name                                               | Yes          |
| --identity                   | xxx                                  | optional identity  signature (ex. UPort or Keybase)          | No           |
| --website                    | www.example.com                      | optional website                                             | No           |
| --details                    | some details                         | optional details                                             | No           |
| --commission-rate            | 80000000(that means 0.8  or 80%)     | The initial commission  rate percentage, it has 8 decimal places. | Yes          |
| --commission-max-rate        | 95000000  (0.95 or 95%)              | The maximum commission  rate percentage, it has 8 decimal places. | Yes          |
| --commission-max-change-rate | 3000000   (0.03 or 3%)               | The maximum commission  change rate percentage (per day)     | Yes          |
| --side-chain-id              | rialto                               | chain-id of the side  chain the validator belongs to         | Yes          |
| --side-cons-addr             | 0x1234abcd                           | consensus address of the  validator on side chain, please use hex format prefixed with 0x | Yes          |
| --side-fee-addr              | 0xabcd1234                           | address that validator  collects fee rewards on side chain, please use hex format prefixed with 0x | Yes          |
| --home                       | /path/to/cli_home                    | home directory of bnbcli  data and config, default to “~/.bnbcli” | No           |

Some address parameters we need to highlight here:

| Field Name | Usage |
| ------------- | ------------------------------------------------------------ |
| DelegatorAddr | Self  delegator address. For BC, this address also used to collect fees. |
| ValidatorAddr | validator  operator’s address, used in governance ops like voting. |
| SideConsAddr  | block  producer’s address on side chain, i.e. consensus address. BC has another  parameter named `PubKey`, here SideConsAddr replaced that for BSC.  Only  BSC validators need this parameter. |
| SideFeeAddr   | fees  are collected in this address on BSC,   Only  BSC validators need this parameter. |



#### Examples

1. If you want to create a validator with the same operator address and self-delegator address, you only need one signature for this transaction.

* Mainnet

```bash
bnbcli staking bsc-create-validator --chain-id Binance-Chain-Tigris --from bnb1tfh30c67mkzfz06as2hk0756mgdx8mgypu7ajl --amount 2000000000000:BNB --moniker bsc_v1 --identity "xxx" --website "[www.example.](http://www.binance.org)com" --details "bsc validator node 1" --commission-rate 80000000 --commission-max-rate 95000000 --commission-max-change-rate 3000000 --side-chain-id rialto --side-cons-addr 0x9B24Ee0BfBf708b541fB65b6087D6e991a0D11A8 --side-fee-addr 0x5885d2A27Bd4c6D111B83Bc3fC359eD951E8E6F8 --home ~/home_cli
```

* Testnet

```bash
tbnbcli staking bsc-create-validator --chain-id Binance-Chain-Kongo --from tbnb1tfh30c67mkzfz06as2hk0756mgdx8mgypu7ajl --amount 2000000000000:BNB --moniker bsc_v1 --identity "xxx" --website "[www.example.](http://www.binance.org)com" --details "bsc validator node 1" --commission-rate 80000000 --commission-max-rate 95000000 --commission-max-change-rate 3000000 --side-chain-id rialto --side-cons-addr 0x9B24Ee0BfBf708b541fB65b6087D6e991a0D11A8 --side-fee-addr 0x5885d2A27Bd4c6D111B83Bc3fC359eD951E8E6F8 --home ~/home_cli
```

2. If you want a separated self-delegator address, both `self-delegator` and `validator operator` need to sign this transaction. Here we need to use another two commands to support multiple signatures.

a. use the following commands appended with a parameter “**--generate-only**” and save the result to a json file which would be used to be signed.

```bash
tbnbcli staking bsc-create-validator --chain-id Binance-Chain-Kongo --from {validator-operator-address}  --address-delegator {delegator-address} --amount 5000000000000:BNB --moniker bsc_v1 --identity "xxx" --website "www.example.com" --details "bsc validator node 1" --commission-rate 80000000 --commission-max-rate 95000000 --commission-max-change-rate 3000000 --side-chain-id rialto --side-cons-addr 0x9B24Ee0BfBf708b541fB65b6087D6e991a0D11A8 --side-fee-addr 0x5885d2A27Bd4c6D111B83Bc3fC359eD951E8E6F8 --home ~/home_cli --generate-only > unsigned.json
```

b. both validator operator(--from) and self-delegator(--address-delegator) use “**bnbcli sign**” command to sign the file from a).

**Delegator** address need to sign `unsigned.json` first

* Online Mode

```bash
./tbnbcli sign unsigned.json --from {delegator-address} --node data-seed-prealpha-1-s1.binance.org:80 --chain-id Binance-Chain-Kongo >> delegator-signed.json
```

* Offline Mode

```bash
./tbnbcli sign unsigned.json --account-number <delegator-account-number> --sequence <address-sequence> --chain-id Binance-Chain-Kongo --offline --name {delegator-address} >> delegator-signed.json
```

Then, **validator** operator addres will sign it later.

* Online Mode

```bash
./tbnbcli sign delegator-signed.json --from {validator-address} --node data-seed-prealpha-1-s1.binance.org:80 --chain-id Binance-Chain-Kongo >> both-signed.json
```

* Offline Mode

```bash
./tbnbcli sign delegator-signed.json --account-number <validator-account-number> --sequence <address-sequence> --chain-id Binance-Chain-Kongo --offline --name {validator-address} >> both-signed.json
```

c. use “**bnbcli broadcast**” to send the transaction from above to the blockchain nodes.

```bash
./tbnbcli broadcast both-signed.json  --node data-seed-prealpha-1-s1.binance.org:80 --chain-id Binance-Chain-Kongo
```

Verify your transaction in [explorer](https://explorer.binance.org/testnet)

### Edit BSC Validator

#### Parameters for bsc-edit-validator

| **parameter name** | **example**                      | **comments**                                                 | **required** |
| ------------------ | -------------------------------- | ------------------------------------------------------------ | ------------ |
| --chan-id          | Binance-Chain-XXX                | the chain id of binance  chain                               | Yes          |
| --from             | bnb1xxx/tbnb1xxx                 | address of private key  with which to sign this tx, that also indicate the validator that you want to  edit. | Yes          |
| --side-chain-id    | rialto                           | chain-id of the side  chain the validator belongs to         | Yes          |
| --moniker          | myval1                           | validator name (default  "[do-not-modify]")                  | No           |
| --identity         | xxx                              | optional identity  signature (ex. UPort or Keybase) (default "[do-not-modify]") | No           |
| --website          | www.example.com                  | optional website (default  "[do-not-modify]")                | No           |
| --details          | some details                     | optional details (default  "[do-not-modify]")                | No           |
| --commission-rate  | 80000000(that means 0.8  or 80%) | The new commission rate  percentage                          | No           |
| --side-fee-addr    | 0xabcd1234                       | address that validator  collects fee rewards on side chain, please use hex format prefixed with 0x. | No           |



#### Examples

* Mainnet

```bash
bnbcli staking bsc-edit-validator --chain-id Binance-Chain-Kongo --side-chain-id rialto --moniker bsc_v1_new --from bnb1tfh30c67mkzfz06as2hk0756mgdx8mgypu7ajl --home ~/home_cli
```

* Testnet

```bash
tbnbcli staking bsc-edit-validator --chain-id Binance-Chain-Kongo --side-chain-id rialto --moniker bsc_v1_new --from bnb1tfh30c67mkzfz06as2hk0756mgdx8mgypu7ajl --home ~/home_cli
```


### Delegate BNB

#### Parameters for staking bsc-delegate

| **parameter name** | **example**              | **comments**                                                 | **required** |
| ------------------ | ------------------------ | ------------------------------------------------------------ | ------------ |
| --chan-id          | Binance-Chain-XXX        | the chain id of binance  chain                               | Yes          |
| --from             | bnb1xxx/tbnb1xxx         | address of private key  with which to sign this tx, that is also the delegator address | Yes          |
| --side-chain-id    | rialto                   | chain-id of the side  chain the validator belongs to         | Yes          |
| --validator        | bva1xxx                  | bech32 address of the  validator, starts with “bva”          | Yes          |
| --amount           | 1000000000:BNB  (10 BNB) | delegation amount, it has  8 decimal places                  | Yes          |



#### Examples

* Mainnet

```bash
bnbcli staking bsc-delegate --chain-id Binance-Chain-Kongo --side-chain-id rialto --from bnb1tfh30c67mkzfz06as2hk0756mgdx8mgypu7ajl --validator bva1tfh30c67mkzfz06as2hk0756mgdx8mgypqldvm --amount 1000000000:BNB --home ~/home_cli
```
* Testnet


### Redelegate BNB

#### Parameters for staking bsc-redelegate

| **parameter name**      | **example**              | **comments**                                                 | **required** |
| ----------------------- | ------------------------ | ------------------------------------------------------------ | ------------ |
| --chan-id               | Binance-Chain-XXX        | the chain id of binance  chain                               | Yes          |
| --from                  | bnb1xxx/tbnb1xxx         | address of private key  with which to sign this tx, that is also the delegator address | Yes          |
| --side-chain-id         | rialto                   | chain-id of the side  chain the validator belongs to         | Yes          |
| --addr-validator-source | bva1xxx                  | bech32 address of the  source validator, starts with “bva”   | Yes          |
| --addr-validator-dest   | bva1yyy                  | bech32 address of the  destination validator, starts with “bva” | Yes          |
| --amount                | 1000000000:BNB  (10 BNB) | delegation amount, it has  8 decimal places                  | Yes          |

#### Examples

* Mainnet

```bash
bnbcli staking bsc-redelegate --chain-id Binance-Chain-Tigris --side-chain-id rialto --from bnb1tfh30c67mkzfz06as2hk0756mgdx8mgypu7ajl --addr-validator-source bva1tfh30c67mkzfz06as2hk0756mgdx8mgypqldvm --addr-validator-dest bva1jam9wn8drs97mskmwg7jwm09kuy5yjumvvx6r2 --amount1000000000:BNB --home ~/home_cli
```


* Mainnet

```bash
tbnbcli staking bsc-redelegate --chain-id Binance-Chain-Kongo --side-chain-id rialto --from bnb1tfh30c67mkzfz06as2hk0756mgdx8mgypu7ajl --addr-validator-source bva1tfh30c67mkzfz06as2hk0756mgdx8mgypqldvm --addr-validator-dest bva1jam9wn8drs97mskmwg7jwm09kuy5yjumvvx6r2 --amount1000000000:BNB --home ~/home_cli
```


### Undelegate BNB

#### Parameters for staking bsc-unbond

| **parameter name** | **example**              | **comments**                                                 | **required** |
| ------------------ | ------------------------ | ------------------------------------------------------------ | ------------ |
| --chan-id          | Binance-Chain-XXX        | the chain id of binance  chain                               | Yes          |
| --from             | bnb1xxx/tbnb1xxx         | address of private key  with which to sign this tx, that is also the delegator address | Yes          |
| --side-chain-id    | rialto                   | chain-id of the side  chain the validator belongs to         | Yes          |
| --validator        | bva1xxx                  | bech32 address of the  validator, starts with “bva”          | Yes          |
| --amount           | 1000000000:BNB  (10 BNB) | delegation amount, it has  8 decimal places                  | Yes          |

#### Examples

* Mainnet

```bash
bnbcli staking bsc-unbond --chain-id Binance-Chain-Kongo --side-chain-id rialto --from bnb1tfh30c67mkzfz06as2hk0756mgdx8mgypu7ajl --validator bva1tfh30c67mkzfz06as2hk0756mgdx8mgypqldvm --amount 1000000000:BNB --home ~/home_cli
```


### Query side chain vaildator by operator

#### Parameters for staking side-validator

| **parameter name** | **example**       | **comments**                                         | **required** |
| ------------------ | ----------------- | ---------------------------------------------------- | ------------ |
| --chan-id          | Binance-Chain-XXX | the chain id of binance  chain                       | Yes          |
| --side-chain-id    | rialto            | chain-id of the side  chain the validator belongs to | Yes          |

#### Examples

* Mainnet

```bash
bnbcli staking side-validator bva1hz5sg3u0v4gq2veyw5355z7qx6y7uuqhcuzf3f  --side-chain-id rialto --chain-id=Binance-Chain-Kongo --home ~/home_cli
```

### Query side chain delegation by delegator and operator

#### Parameters for staking side-delegation

| **parameter name** | **example**       | **comments**                                         | **required** |
| ------------------ | ----------------- | ---------------------------------------------------- | ------------ |
| --chan-id          | Binance-Chain-XXX | the chain id of binance  chain                       | Yes          |
| --side-chain-id    | rialto            | chain-id of the side  chain the validator belongs to | Yes          |

#### Examples

* Mainnet

```bash
bnbcli staking side-delegation bnb1hz5sg3u0v4gq2veyw5355z7qx6y7uuqhcqre0d bva1hz5sg3u0v4gq2veyw5355z7qx6y7uuqhcuzf3f --chain-id=Binance-Chain-Kongo --side-chain-id rialto --home ~/home_cli
```


### Query side chain delegations by delegator

#### Parameters for staking side-delegations

| **parameter name** | **example**       | **comments**                                         | **required** |
| ------------------ | ----------------- | ---------------------------------------------------- | ------------ |
| --chan-id          | Binance-Chain-XXX | the chain id of binance  chain                       | Yes          |
| --side-chain-id    | rialto            | chain-id of the side  chain the validator belongs to | Yes          |

#### Examples

* Mainnet

```bash
bnbcli staking side-delegations bnb1hz5sg3u0v4gq2veyw5355z7qx6y7uuqhcqre0d --side-chain-id rialto --node=0.0.0.0:26657 --chain-id=Binance-Chain-Kongo --trust-node
```

###  Query side chain unbonding delegation

#### Parameters for staking side-unbonding-delegation

**Usage:**
```bash
bnbcli staking side-unbonding-delegation [delegator-addr] [operator-addr] [flags]
```

| **parameter  name** | **example**       | **comments**                                        | **required** |
| ------------------- | ----------------- | --------------------------------------------------- | ------------ |
| --chan-id           | Binance-Chain-XXX | the chain id of binance chain                       | Yes          |
| --side-chain-id     | rialto            | chain-id of the side chain the validator belongs to | Yes          |

**For example**
```bash
bnbcli staking     side-unbonding-delegation bnb1rtzy6szuyzcj4amfn6uarvne8a5epxrdklwhhj bva12hlquylu78cjylk5zshxpdj6hf3t0tahqmr98n --side-chain-id=rialto --chain-id=test-chain-8d7sJz --home ~/home_cli
```


### Query side chain unbonding delegations by delegator

#### Parameters for staking side-unbonding-delegations

**Usage:**

```bash
bnbcli staking side-unbonding-delegations [delegator-addr] [flags]
```

| **parameter  name** | **example**       | **comments**                                        | **required** |
| ------------------- | ----------------- | --------------------------------------------------- | ------------ |
| --chan-id           | Binance-Chain-XXX | the chain id of binance chain                       | Yes          |
| --side-chain-id     | rialto            | chain-id of the side chain the validator belongs to | Yes          |

**For example**

```bash
bnbcli staking     side-unbonding-delegations bnb1rtzy6szuyzcj4amfn6uarvne8a5epxrdklwhhj --side-chain-id=rialto --chain-id=test-chain-8d7sJz --home ~/home_cli
```


###  Query side chain unbonding delegations by validator

#### Parameters for staking side-val-unbonding-delegations

**Usage:**
```bash
bnbcli staking side-val-unbonding-delegation [operator-addr] [flags]
```

| **parameter  name** | **example**       | **comments**                                        | **required** |
| ------------------- | ----------------- | --------------------------------------------------- | ------------ |
| --chan-id           | Binance-Chain-XXX | the chain id of binance chain                       | Yes          |
| --side-chain-id     | rialto            | chain-id of the side chain the validator belongs to | Yes          |

**For example**
```bash
bnbcli staking     side-val-unbonding-delegations bva12hlquylu78cjylk5zshxpdj6hf3t0tahqmr98n --side-chain-id=rialto --chain-id=test-chain-8d7sJz --home ~/home_cli
```

### Query side chain re-delegation

#### Parameters for staking side-redelegation

**Usage:**

```bash
bnbcli staking side-redelegation [delegator-addr] [src-operator-addr] [dst-operator-addr] [flags]
```

| **parameter  name** | **example**       | **comments**                                        | **required** |
| ------------------- | ----------------- | --------------------------------------------------- | ------------ |
| --chan-id           | Binance-Chain-XXX | the chain id of binance chain                       | Yes          |
| --side-chain-id     | rialto            | chain-id of the side chain the validator belongs to | Yes          |

**For example**

```bash
bnbcli staking     side-redelegation bnb1rtzy6szuyzcj4amfn6uarvne8a5epxrdklwhhj bva12hlquylu78cjylk5zshxpdj6hf3t0tahqmr98n  bva1hz5sg3u0v4gq2veyw5355z7qx6y7uuqhcuzf3f --side-chain-id=rialto --chain-id=test-chain-8d7sJz --home ~/home_cli
```

### Query side chain re-delegations by delegator

#### Parameters for staking side-redelegations

**Usage:**

```bash
bnbcli staking side-redelegations [delegator-addr] [flags]
```

| **parameter  name** | **example**       | **comments**                                        | **required** |
| ------------------- | ----------------- | --------------------------------------------------- | ------------ |
| --chan-id           | Binance-Chain-XXX | the chain id of binance chain                       | Yes          |
| --side-chain-id     | rialto            | chain-id of the side chain the validator belongs to | Yes          |

**For example**

```bash
bnbcli staking side-redelegations bnb1rtzy6szuyzcj4amfn6uarvne8a5epxrdklwhhj --side-chain-id=rialto --chain-id=test-chain-8d7sJz --home ~/home_cli
```

### Query side chain re-delegations by validator

#### Parameters for staking side-val-redelegations

**Usage:**
```bash
bnbcli staking side-val-redelegations [operator-addr] [flags]
```
| **parameter  name** | **example**       | **comments**                                        | **required** |
| ------------------- | ----------------- | --------------------------------------------------- | ------------ |
| --chan-id           | Binance-Chain-XXX | the chain id of binance chain                       | Yes          |
| --side-chain-id     | rialto            | chain-id of the side chain the validator belongs to | Yes          |

**For example**

```bash
bnbcli staking side-val-redelegations bva12hlquylu78cjylk5zshxpdj6hf3t0tahqmr98n --side-chain-id=rialto --chain-id=test-chain-8d7sJz --home ~/home_cli
```


### Query side chain staking pool

#### Parameters for staking side-pool

| **parameter  name** | **example**       | **comments**                                        | **required** |
| ------------------- | ----------------- | --------------------------------------------------- | ------------ |
| --chan-id           | Binance-Chain-XXX | the chain id of binance chain                       | Yes          |
| --side-chain-id     | rialto            | chain-id of the side chain the validator belongs to | Yes          |


**For example**

```bash
bnbcli staking     side-pool --side-chain-id=rialto --chain-id=test-chain-8d7sJz --home     ~/home_cli
```


###  Query side chain top validators

#### Parameters for  staking side-top-validators

| **parameter  name** | **example**       | **comments**                                                 | **required** |
| ------------------- | ----------------- | ------------------------------------------------------------ | ------------ |
| --chan-id           | Binance-Chain-XXX | the chain id of binance chain                                | Yes          |
| --side-chain-id     | rialto            | chain-id of the side chain the validator belongs to          | Yes          |
| --top               | 10                | number of validators to be returned. set as maximum number of  validators  by default | Option       |

**For example**

```bash
bnbcli staking side-top-validators --top 10 --side-chain-id=rialto --chain-id=test-chain-8d7sJz --home ~/home_cli
```

###  Query side chain validators count

#### Parameters for staking side-validators-count

| **parameter  name** | **example**       | **comments**                                                 | **required** |
| ------------------- | ----------------- | ------------------------------------------------------------ | ------------ |
| --chan-id           | Binance-Chain-XXX | the chain id of binance chain                                | Yes          |
| --side-chain-id     | rialto            | chain-id of the side chain the validator belongs to          | Yes          |
| --jail-involved     | true              | if true, meaning that the jailed validators will be involved to count | Option       |

**For example**

```bash
bnbcli staking  side-validators-count --jail-involved --side-chain-id=rialto --chain-id=test-chain-8d7sJz --home ~/home_cli
```
