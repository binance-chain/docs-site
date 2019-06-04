# Governance
- [Governance](#governance)
  * [Primer on Governance](#primer-on-governance)
  * [Proposal Workflow](#proposal-workflow)
    + [Global Parameters](#global-parameters)
    + [Proposal Parameters](#proposal-parameters)
    + [Participate in Governance](#participate-in-governance)
        - [Submit a List Proposal](#submit-a-list-proposal)
        - [Add deposit for a Proposal](#add-deposit-for-a-proposal-optional)
        - [Query Information of a Proposal](#query-information-of-a-proposal)
        - [Query votes of a Proposal](#query-votes-of-a-proposal)
  * [Key Notions](#key-notions)
      - [Vote options](#vote-options)
      - [Quorum](#quorum)
      - [Veto](#veto)
      - [Threshold](#threshold)
      - [Tally Result Example](#tally-result-example)


## Primer on Governance

Binance Chain has its own built-in governance module that lets BNB holders submit proposals for adding trade pairs. In order for the proposal to be open for voting, it needs to come with a `deposit` that is greater than a parameter called `Deposit`. The `deposit` need not be provided in its entirety by the submitter. If the initial proposer's `deposit` is not sufficient, the proposal enters the `deposit_period` status. Then, any BNB holder can increase the deposit by sending a `depositTx`.

## Proposal Workflow
![workflow](./assets/workflow.jpg)

### Global Parameters
* `min-deposit`: The threshold for submitting a proposal on mainnet is **1000BNB**, and the threshold for submitting a proposal on testnet is **2000BNB**
* `deposit_period`: This is a global parameter and the value for mainnet is two days and testnet is two week. It means the time to deposit enough BNB tokens is two days in mainnet and two weeks in testnet.
* `fee`: Checkout the fee of governance-related transactions [here](trading-spec.md)

### Proposal Parameters
* `deposit` : your input must be larger than `min-deposit`.
* `voting-period`: This is the time for validators to vote, your input in seconds, if you omit this field, the default voting period is one week.
* `expire-time`: This is the time for you to send list transaction if your proposal passed. This time cannot be earlier than current time.

### Participate in Governance
#### Tools

Please use this [tool](<https://github.com/binance-chain/node-binary/tree/master/tools>) for generating

#### Submit a List Proposal
To add a new trading pairs, you can run the following command:<br/>
Please note:<br/>

+ `--init-price` is boosted by **1e8** for decimal part, such as 100000000, is 1 BNB
+ `--from`: put your key name for the address / key, you can only list with the owners address of your token.
+ `--expire-time`: expire time is the deadline after which you will no longer be able to list your token though your proposal is passed.
+ `--voting-period`: The voting period is for validators to vote. The unit is in seconds and the default voting period is one week. The max voting period is two weeks. The votes from validators will be tallied after the voting period ends.

Please note that the deposit and init-price are boosted by **1e8** for decimal part.

Example on **mainnet**:

```shell
./bnbcli gov submit-list-proposal --from test --deposit 100000000000:BNB
--base-asset-symbol AAA-254 --quote-asset-symbol BNB --init-price 100000000 --title "list AAA-254/BNB"
--description "list AAA-254/BNB" --expire-time 1570665600 --chain-id Binance-Chain-Tigris --node https://dataseed5.defibit.io:443 --voting-period 604800 --json
```

Example on **testnet**:

```shell
./tbnbcli gov submit-list-proposal --from test --deposit 200000000000:BNB
--base-asset-symbol AAA-254 --quote-asset-symbol BNB --init-price 100000000 --title "list AAA-254/BNB"
--description "list AAA-254/BNB" --expire-time 1570665600 --chain-id=Binance-Chain-Nile --node=data-seed-pre-2-s1.binance.org:80 --json --voting-period 604800
```

#### Add deposit for a Proposal (Optional)
If the initial deposit for your proposal in `submit-list-proposal` is not enough, you can increase the deposit with `deposit` operation. In current Binance Chain Mainnet, the max deposit period is **two days**. After submitting a proposal, you have two days to increase your deposit, otherwise your proposal will not go into the voting period and gets rejected directly.

Please note the amount is boosted by **1e8** for decimal part.

Example on **mainnet**:

```shell
./bnbcli gov deposit --from name --proposal-id <proposl-ID> --deposit <amount>:BNB --chain-id Binance-Chain-Tigris --node https://dataseed5.defibit.io:443
```

Example on **testnet**:

```shell
./tbnbcli gov deposit --from name --proposal-id <proposl-ID> --deposit <amount>:BNB --chain-id=Binance-Chain-Nile --node=data-seed-pre-2-s1.binance.org:80
```

#### Query Information of a Proposal
To see detailed information of specific proposal, you can run the following command:

Example on **mainnet**:

```shell
./bnbcli gov query-proposal --proposal-id <proposal-ID> --chain-id Binance-Chain-Tigris --node https://dataseed5.defibit.io:443
```

Example on **testnet**:

```shell
./tbnbcli gov query-proposal --proposal-id <proposal-ID> --chain-id=Binance-Chain-Nile --node=data-seed-pre-2-s1.binance.org:80
```

Example output:
```json
{
  "type": "gov/TextProposal",
  "value": {
    "proposal_id": "100",
    "title": "list CZZ-696/BNB",
    "description": "{\"base_asset_symbol\":\"CZZ-696\",\"quote_asset_symbol\":\"BNB\",\"init_price\":100000000,\"description\":\"list CZZ-696/BNB\",\"expire_time\":\"2019-03-21T09:00:00+09:00\"}",
    "proposal_type": "ListTradingPair",
    "proposal_status": "Passed",
    "tally_result": {
      "yes": "1100000000000",
      "abstain": "0",
      "no": "0",
      "no_with_veto": "0"
    },
    "submit_time": "2019-03-07T20:49:03.504103408Z",
    "total_deposit": [
      {
        "denom": "BNB",
        "amount": "200000000000"
      }
    ],
    "voting_start_time": "2019-03-07T21:01:36.159585594Z"
  }
}
```
You can get the information about the proposal's status and its tally result this way.

#### Query votes of a Proposal
You can track the votes for your proposal with the following command:

Example on **mainnet**:

```shell
./bnbcli gov query-votes --proposal-id 272 --chain-id Binance-Chain-Tigris --node https://dataseed5.defibit.io:443
```

Example on **testnet**:

```shell
./tbnbcli gov query-votes --proposal-id 272 --chain-id=Binance-Chain-Nile --node=data-seed-pre-2-s1.binance.org:80
```

Example output:
```
[
  {
    "voter": "tbnb1q82g2h9q0kfe7sysnj5w7nlak92csfjztymp39",
    "proposal_id": "272",
    "option": "Yes"
  },
  {
    "voter": "tbnb1r6l0c0fxu458hlq6m7amkcltj8nufyl9mr2wm5",
    "proposal_id": "272",
    "option": "Yes"
  },
  {
    "voter": "tbnb193t8pkhm2sxw5uy5ypesygda8rzsk25ge3e9y7",
    "proposal_id": "272",
    "option": "Yes"
  },
  {
    "voter": "tbnb183nch8pn3f698vurrqypq3s254slcane2t66aj",
    "proposal_id": "272",
    "option": "Yes"
  },
  {
    "voter": "tbnb12hlquylu78cjylk5zshxpdj6hf3t0tahwjt3ex",
    "proposal_id": "272",
    "option": "Yes"
  },
  {
    "voter": "tbnb1vehecekrsks5sshcwvxyeyrd469j9wvcqm37yu",
    "proposal_id": "272",
    "option": "Yes"
  },
  {
    "voter": "tbnb108drn8exhv72tp40e6lq9z949nnjj54yzqrr2f",
    "proposal_id": "272",
    "option": "Yes"
  },
  {
    "voter": "tbnb135mqtf9gef879nmjlpwz6u2fzqcw4qlzrqwgvw",
    "proposal_id": "272",
    "option": "Yes"
  },
  {
    "voter": "tbnb1hexqyu3m8uuudqdnnpnsnlwe6xg0n3078lx68l",
    "proposal_id": "272",
    "option": "Yes"
  },
  {
    "voter": "tbnb1earfwcjre04hp7phqnkw8ts04tkumdn0cyzun0",
    "proposal_id": "272",
    "option": "Yes"
  },
  {
    "voter": "tbnb167yp9jkv6uaqnyq62gfkx82xmfny0cl9xe04zj",
    "proposal_id": "272",
    "option": "Yes"
  }
]
```

## Key Notions

#### Vote options
There are four vote options:
- `Yes`
- `No`
- `NoWithVeto`
- `Abstain`

`No` represents the validator is against this proposal and `NoWithVeto` suggests the validator is strongly against
this proposal.<br/>
`Abstain` option allows voters to signal that they do not intend to vote in favor or against
the proposal but accept the result of the vote.

#### Quorum

Quorum is defined as the minimum percentage of voting power that needs to be casted on a proposal for the result to
be valid, which is 0.5(50%) now.

If voting power does not reach quorum at the end of the voting period, the proposal will be rejected and all deposits
will be returned to depositors' addresses.

**Note**: There is a special case when all votes are `Abstain` and voting power is superior to 50%, the proposal will be rejected and all deposits will be refunded.

#### Veto

Veto is defined as the minimum proportion of `NoWithVeto` votes for the proposal to be rejected, which is 0.334(1/3) now. If more than 1/3 voters veto, the proposal will be rejected and all deposits will be distributed to validator.

#### Threshold

Threshold is defined as the minimum proportion of `Yes` votes (excluding `Abstain` votes) for the proposal to be accepted, which is 0.5(50%) now.

If the proportion of `NoWithVeto` votes is inferior to 1/3 and the proportion of `Yes` votes (excluding `Abstain` votes) is superior to 50%, the proposal will be accepted and all deposits will be returned. Otherwise, the proposal will be rejected and all deposits will be distributed to validator.

#### Tally Result Example

You can query a proposal via `bnbcli`.

```bash
$ ./bnbcli gov query-proposal --chain-id Binance-Chain-Nile --node=tcp://data-seed-pre-1-s3.binance.org:80 --proposal-id 370
{
  "type": "gov/TextProposal",
  "value": {
    "proposal_id": "370",
    "title": "list JCC-CB1/BNB",
    "description": "{\"base_asset_symbol\":\"JCC-CB1\",\"quote_asset_symbol\":\"BNB\",\"init_price\":100000000,\"description\":\"list JCC-CB1/BNB\",\"expire_time\":\"2019-04-24T14:46:35+08:00\"}",
    "proposal_type": "ListTradingPair",
    "voting_period": "604800000000000",
    "proposal_status": "Passed",
    "tally_result": {
      "yes": "1100000000000",
      "abstain": "0",
      "no": "0",
      "no_with_veto": "0",
      "total": "1100000000000"
    },
    "submit_time": "2019-04-10T06:49:11.568747217Z",
    "total_deposit": [
      {
        "denom": "BNB",
        "amount": "200000000000"
      }
    ],
    "voting_start_time": "2019-04-10T06:52:00.064744275Z"
  }
}
```

You can get `tally result` and `proposal_status`.<br/>

For options in `tally result`:

- `yes` denotes voting power votes `Yes`
- `abstain` denotes voting power votes `Abstain`
- `no` denotes voting power votes `No`
- `no_with_veto` denotes voting power votes `NoWithVeto`
- `total` denotes total voting power when voting period ends

We can calculate proportion of each vote option easily.<br/>
In this case, total voting power is 1100000000000 and voting power of `Yes` is 1100000000000,
so the proportion of `Yes` is 100% and the proposal should be passed and and 2000 BNB will be returned.

**Note:** Trying to query proposal that didn't enter the voting period will result in `error`.

```bash
$ ./bnbcli gov query-proposal --chain-id Binance-Chain-Tigris --node https://dataseed5.defibit.io:443 --proposal-id 25
{
  "codespace": 5,
  "code": 1,
  "abci_code": 327681,
  "message": "Unknown proposal with id 25"
}
```
