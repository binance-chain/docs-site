# Binance Smart Chain  Testnet Staking Parameters

## Staking Token

BNB

## Max Validator Count

11, which is different from 21 validators in Mainnet


## Validator Candidate

* Minimiun Self-delegate Amount: 50000BNB
* Claim reward frequency: everyday at 0:00 UTC
* Unbonding Period: 7 days

## Delegator

* Redelegate frequency: 7 days

## Slashing

* Double-Sign Slash: 10000BNB
    * Details: Anyone can submit a slashing request on BC with the evidence of Double Sign of BSC, which should contain the 2 block headers with the same height and parent block, sealed by the offending validator.
* Offline Slash: 50BNB
    * Details: If a validator missed more than 50 blocks every 24h, the blocking reward for validator will not be relayed to BC for distribution but shared with other better validators. If it missed more than 150 blocks every 24h, then this will be propagated back to BC where another Slashing will happen
* Rewards for submitting double-sign evidence: 1000BNB
* Double-Sign Jail time: 2^63-1 seconds
* Downtime Jail time: 2 days
* Too Low self-delegation Jail time: 1 day



