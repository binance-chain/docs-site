# Incentive Mechanism

The BSC relayers play an important role in relaying interchain packages from BC to BSC.
All BSC relayers build their stable infrastructure, watch any event happened on the Binance Chain, and act timely to get paid accordingly. The following discussion is about how to distribute the rewards to let the relayers are willing to make a long-term contribution.

## Principle
Considering the following points:

1. Fairness, competitiveness, and redundancy: Everyone has a chance to run a relayer even on cheap hardware. It should be hard for someone to get all the rewards.
2. Simplicity. 
3. Robustness: The relayer may have a strategy to make its largest profit accordingly, under any condition, the interchain communication should not be blocked.
4. Low Risk: The relayer should take a little risk to play in this game. For the top N relayers, they should gain enough rewards to cover the cost.

It is tough hard to achieve all these goals; we make some trade-off on robustness and low risk in the following design.

## Rewards Distribution Formula

To prevent the relayer who has the best network always winning the game, we gather the reward in a round and reallocate to the relayers to achieve redundancy. 
Definitions:

1. *S* is a constant number of transactions that in around. Each round, there are *S* transactions, and the last transaction of the round will trigger reward distribution. 
2. *N* is the maximum weight that a relayer can gain in a round. *R* is the total reward in this round. *Ki* is the number of successful transactions from Relayer i. *Wi* is the reward weight of Relayer i. *Ri* is the rewards of Relayer i.
3. *R* is the total reward in this round.
4. *Ki* is the number of successful transactions from Relayer i.
5. *Wi* is the reward weight of Relayer i.
6. *Ri* is the rewards of Relayer i.

We have the following reward formula:

![formula](../../../assets/formula.png)

We consider to set these parameters a reasonable value:

1. S to be 1000. Some rewards come from gas fee, we can not guarantee enough rewards during a small round, a large round may dismiss deviation and let relayer give up relaying when it has made its max profit. 
2. N to be 400. We think the redundancy of relayer around 3-5 is best. If N is too large, the redundancy will decrease, if too small there are no enough relayers. Set N as 400 may be a reasonable value, at least 3 relayers can compete.
3. For system rewards, R to be 10*{gas fee of sync light client}*S. We will reward a replayer 10 times of gas fee it has paid for the transaction. Assuming that the transaction to update a block header of light client consumes the most gas comparing to other transactions, the R to be 10*{gas fee of sync light client}*S.
4. For interchain token transfer rewards, R is the total value that users would pay.

## Rewards Source and Allocation

We have three reward source: 

1. Users paid reward: Users who send `bind` or `cross chain transfer` transactions need to pay extra fee as bsc-relayer rewards.
2. System reward: Rewards comes from `SystemReward` contract.

The role of relayers and their rewards comes from:

|Relayer Behavior|Rewards come from|follow the distribution formula?|
|---|---|---|
|Deliver token `bind` or `transfer` package | Users who send `bind` or `cross chain transfer` transactions |Yes.|
|Sync Binance Chain Header| First-part: if the Header contract Binance Chain validatorSet changes, <br>`SystemReward` will pay some reward to relayers. <br>Second-part: if the header is referenced in delivering other packages, <br>part of package reward will be distributed to this header relayer. | The first part is not, <br>the second part is yes |
|Delivering BSC staking package |System reward|No|
|Delivering refund package |System reward|No|

## Other Consideration 

### System Reward Pool
The system reward pool can hold at most 100BNB for example, to prevent the pool get unnecessary income. 

The client needs to query the balance of the contract to decide whether to distribute 1/16 of the transaction fee to the contract or not. It seems not that fair that some validators pay more to the reward pool than others, but this is random and will eventually become fair in the long run.

If there are not enough rewards in the pool, all the tokens in the pool will be distributed. 

Block header sync transaction and `validatorSet` change sync transaction will claim reward to relayers from system reward pool directly.

### Foul Play
For example, a relayer may deliver packages using a different address in round robin, we can’t recognize this. We try to introduce registration and BNB deposit for relayer to raise the cost of cheat.  How it works:
* A BSC account needs call `register` of [RelayerHub](https://explorer.binance.org/smart-testnet/address/0x0000000000000000000000000000000000001006/contracts) contract to deposit 100BNB(more or less than 100 BNB will be rejected) to become a BSC relayer.
* Only a valid relayer can sync Binance Chain Headers and deliver cross-chain packages.
* Relayer can withdraw its deposit, but we will charge 0.1 BNB as the transaction fee so that it will receive 99.9 BNB back.
* The charged fee will directly go to system reward pool.
