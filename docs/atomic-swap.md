# Atomic Swap
- [Atomic Swap](#atomic-swap)
  * [Introduction](#introduction)
  * [Commands](#commands)
    * [Hash Timer Locked Transfer](#hash-timer-locked-transfer)
    * [Deposit HTLT](#deposit-htlt)
    * [Claim HTLT](#claim-htlt)
    + [Refund HTLT](#refund-htlt)
    + [Query Atomic Swap](#query-atomic-swap)
    + [Query Atomic Swap ID By Recipient](#query-atomic-swap-id-by-recipient)
    + [Query Atomic Swap ID By Creator](#query-atomic-swap-id-by-creator)
  * [Fees](#fees)
  * [Workflows](#workflows)
    + [Preparations](#preparations)
    + [Swap Tokens from Ethereum to Binance Chain](#swap-tokens-from-ethereum-to-binance-chain)
    + [Swap Tokens from Binance Chain to Ethereum](#swap-tokens-from-binance-chain-to-ethereum)
    + [Swap between Several BEP2 tokens](#swap-between-several-bep2-tokens)
    + [Swap between Several BEP2 tokens fails](#swap-between-several-bep2-tokens-fails)

## Introduction
As explained in [BEP3](https://github.com/binance-chain/BEPs/blob/master/BEP3.md), Hash Timer Locked Contract(HTLC) has been used for Atomic Swap and cross payment channels between different blockchains. BEP3 defines native transactions to support HTLC on Binance Chain and also proposes the standard infrastructure and procedure to use HTLC for inter-chain atomic swap to easily create and use pegged token.
During the swap process, the related fund will be locked to a purely-code-controlled escrow account. The account for mainnet is: **bnb1wxeplyw7x8aahy93w96yhwm7xcq3ke4f8ge93u** and the account for testnet is: **tbnb1wxeplyw7x8aahy93w96yhwm7xcq3ke4ffasp3d**. Once the swap is claimed or refunded, the fund will be transfered from the purely-code-controlled escrow account to client accounts.
## Commands

### Hash Timer Locked Transfer

Hash Timer Locked Transfer (HTLT) is a new transaction type on Binance Chain, to serve as HTLC in the first step of Atomic Swap,


#### Parameters
| Name | Type | Description | Optional |
| -----| ---- | ----------- | -------- |
| From | Address | Sender address, where the asset is from | No |
| recipient-addr | Address | Receiver address, where the asset is to, if the proper condition meets. | No |
| recipient-other-chain | bytes | a byte array, maximum 32 bytes, in any proper encoding. leave it empty for single chain swap | Yes |
| sender-other-chain | bytes | a byte array, maximum 32 bytes, in any proper encoding. leave it empty for single chain swap | Yes |
| RandomNumberHash | 32 bytes | hash of a random number and timestamp, based on SHA256. If left out, a random value will be generated | True |
| Timestamp | int64 | Supposed to be the time of sending transaction, counted by second. It should be identical to the one in swap contract. If left out, current timestamp will be used. | No |
| OutAmount | Coins | similar to the Coins in the original Transfer defined in BEP2, assets to swap out | No |
| ExpectedIncome | string | Expected income from swap counter party, example: "100:BNB" or "100:BNB,10000:BTCB-1DE" The amount needs to be bumped by e^8 | No |
| HeightSpan | int64   | number of blocks to wait before the asset may be returned to From if not claimed via Random. The number must be larger than or equal to 360 (>2 minutes), and smaller than 518400 (< 48 hours) | No  |
| CrossChain | bool   | Specify if the HTLT is for cross chain atomic swap | True, the default value is False |

#### Outputs
| Name | Type | Description |
| -----| ---- | ----------- |
|Random number|32 bytes||
|Timestamp|int64||
|Random number hash|32 bytes||
|Swap ID|32 bytes||

#### Examples

1. Swap between BEP2 tokens

* On *testnet*:

```shell
./tbnbcli token HTLT --recipient-addr <recipient-addr> --amount 100:BNB --expected-income <expectedIncome> --height-span <span> --from <from-addr> --chain-id Binance-Chain-Nile --trust-node --node http://data-seed-pre-0-s3.binance.org:80
```

**Example output:**

Please take a note of returned `swap ID`. This
```
Random number: 927c1ac33100bdbb001de19c626a05a7c3c11304fc825f5eabb22e741507711b
Timestamp: 1568792486
Random number hash: 5768702259ee55983378d7b8207890c666648264524b9dada551386f832ba6b1
Password to sign with 'guest':
Committed at block 39984169 (tx hash: B5A3DD92A40E98745BBE9F608944FE5511B81071B34E9947A754A04A5F378A85, response: {Code:0 Data:[77 137 139 200 85 141 170 77 129 116 134 215 169 59 119 178 200 47 206 194 18 58 191 74 30 183 210 82 18 55 236 205] Log:Msg 0: swapID: 4d898bc8558daa4d817486d7a93b77b2c82fcec2123abf4a1eb7d2521237eccd Info: GasWanted:0 GasUsed:0 Tags:[{Key:[115 101 110 100 101 114] Value:[116 98 110 98 49 103 57 114 122 99 48 101 50 106 102 56 101 102 51 113 112 57 97 120 56 104 48 112 109 112 109 118 106 122 119 109 116 113 52 106 120 102 114] XXX_NoUnkeyedLiteral:{} XXX_unrecognized:[] XXX_sizecache:0} {Key:[114 101 99 105 112 105 101 110 116] Value:[116 98 110 98 49 119 120 101 112 108 121 119 55 120 56 97 97 104 121 57 51 119 57 54 121 104 119 109 55 120 99 113 51 107 101 52 102 102 97 115 112 51 100] XXX_NoUnkeyedLiteral:{} XXX_unrecognized:[] XXX_sizecache:0} {Key:[97 99 116 105 111 110] Value:[72 84 76 84] XXX_NoUnkeyedLiteral:{} XXX_unrecognized:[] XXX_sizecache:0}] Codespace: XXX_NoUnkeyedLiteral:{} XXX_unrecognized:[] XXX_sizecache:0})
```

2. Swap from Binance Chain to Ethereum

* On *testnet*:


```shell
./tbnbcli token HTLT --from <from-addr> --chain-id Binance-Chain-Nile  --height-span <heightSpan> --amount <amount> --expected-income <expectedIncome> --recipient-addr <recipient-addr>  --recipient-other-chain [client ethereum address]  --cross-chain --trust-node --node http://data-seed-pre-0-s3.binance.org:80
```

3. Swap from Ethereum to Binance Chain

> Note: Once cross-chain is true, --recipient-other-chain must not be empty

* On *testnet*:


```shell
./tbnbcli token HTLT --from  <from-addr> --chain-id Binance-Chain-Nile --height-span  <heightSpan>  --amount  <amount> --expected-income <expectedIncome> --recipient-other-chain [deputy ethereum address] --sender-other-chain [client ethereum address] --recipient-addr --cross-chain --trust-node --node http://data-seed-pre-0-s3.binance.org:80
```

### Deposit HTLT

Deposit Hash Timer Locked Transfer is to lock new BEP2 asset to an existed HTLT which is for single chain atomic swap.

#### Parameters

| Name | Type | Description | Optional |
| -----| ---- | ----------- | -------- |
| From | Address | Sender address, where the assets are from | No |
| SwapID | 32 bytes | ID of previously created swap, hex encoding | No |
| Amount | Coins | The swapped out amount BEP2 tokens, example: "100:BNB" or "100:BNB,10000:BTCB-1DE" | No |

#### Examples

* On testnet:

```shell
./tbnbcli token deposit --swap-id <swap-id>  --amount 10000:TEST-599 --from <from-key> --chain-id Binance-Chain-Nile --trust-node --node http://data-seed-pre-0-s3.binance.org:80
```

Example output
```
Committed at block 39984686 (tx hash: AA118F7CFCB3FFF86EF5EED8D2B9ADEAC5D9F242497910DAA232BDE5F6A84C1E, response: {Code:0 Data:[] Log:Msg 0:  Info: GasWanted:0 GasUsed:0 Tags:[{Key:[115 101 110 100 101 114] Value:[116 98 110 98 49 110 107 120 57 57 52 113 118 113 109 113 103 107 53 55 118 103 117 113 104 54 122 106 108 97 99 113 122 120 100 107 117 101 53 122 106 121 120] XXX_NoUnkeyedLiteral:{} XXX_unrecognized:[] XXX_sizecache:0} {Key:[114 101 99 105 112 105 101 110 116] Value:[116 98 110 98 49 119 120 101 112 108 121 119 55 120 56 97 97 104 121 57 51 119 57 54 121 104 119 109 55 120 99 113 51 107 101 52 102 102 97 115 112 51 100] XXX_NoUnkeyedLiteral:{} XXX_unrecognized:[] XXX_sizecache:0} {Key:[97 99 116 105 111 110] Value:[100 101 112 111 115 105 116 72 84 76 84] XXX_NoUnkeyedLiteral:{} XXX_unrecognized:[] XXX_sizecache:0}] Codespace: XXX_NoUnkeyedLiteral:{} XXX_unrecognized:[] XXX_sizecache:0})
```

After the deposit, you may observe that the balance of sender is decreased.

### Claim HTLT

Claim Hash Timer Locked Transfer is to claim the locked asset by showing the random number value that matches the hash. Each HTLT locked asset is guaranteed to be release once.

#### Parameters

| Name | Type | Description | Optional |
| -----| ---- | ----------- | -------- |
| From | Address | Sender address | No |
| SwapID | 32 bytes |  ID of previously created swap, hex encoding | No |
| RandomNumber | 32 bytes | The random number to unlock the locked hash, 32 bytes, hex encoding | No |

#### Examples

* On testnet:

```shell
./tbnbcli token claim --swap-id  <swap-id> --random-number <random-number> --from <from-key> --chain-id Binance-Chain-Nile --trust-node --node http://data-seed-pre-0-s3.binance.org:80
```

Example output:
```
Committed at block 39984971 (tx hash: 15B8625E0247DE54700D3C5C110BE0CE279D33CC13A73845F3E0305758A40902, response: {Code:0 Data:[] Log:Msg 0:  Info: GasWanted:0 GasUsed:0 Tags:[{Key:[115 101 110 100 101 114] Value:[116 98 110 98 49 119 120 101 112 108 121 119 55 120 56 97 97 104 121 57 51 119 57 54 121 104 119 109 55 120 99 113 51 107 101 52 102 102 97 115 112 51 100] XXX_NoUnkeyedLiteral:{} XXX_unrecognized:[] XXX_sizecache:0} {Key:[114 101 99 105 112 105 101 110 116] Value:[116 98 110 98 49 110 107 120 57 57 52 113 118 113 109 113 103 107 53 55 118 103 117 113 104 54 122 106 108 97 99 113 122 120 100 107 117 101 53 122 106 121 120] XXX_NoUnkeyedLiteral:{} XXX_unrecognized:[] XXX_sizecache:0} {Key:[115 101 110 100 101 114] Value:[116 98 110 98 49 119 120 101 112 108 121 119 55 120 56 97 97 104 121 57 51 119 57 54 121 104 119 109 55 120 99 113 51 107 101 52 102 102 97 115 112 51 100] XXX_NoUnkeyedLiteral:{} XXX_unrecognized:[] XXX_sizecache:0} {Key:[114 101 99 105 112 105 101 110 116] Value:[116 98 110 98 49 103 57 114 122 99 48 101 50 106 102 56 101 102 51 113 112 57 97 120 56 104 48 112 109 112 109 118 106 122 119 109 116 113 52 106 120 102 114] XXX_NoUnkeyedLiteral:{} XXX_unrecognized:[] XXX_sizecache:0} {Key:[97 99 116 105 111 110] Value:[99 108 97 105 109 72 84 76 84] XXX_NoUnkeyedLiteral:{} XXX_unrecognized:[] XXX_sizecache:0}] Codespace: XXX_NoUnkeyedLiteral:{} XXX_unrecognized:[] XXX_sizecache:0})
```

### Refund HTLT

Refund Hash Timer Locked Transfer is to refund the locked asset after timelock is expired.

#### Parameters

| Name | Type | Description | Optional |
| -----| ---- | ----------- | -------- |
| From | Address | Sender address | No |
| SwapID | 32 bytes | ID of previously created swap, hex encoding | No |

#### Examples

* On testnet:

```shell
./tbnbcli token refund --swap-id <swap-id> --from <from-key>  --chain-id Binance-Chain-Nile --trust-node --node http://data-seed-pre-0-s3.binance.org:80
```

Common error:

* Already complete
```shell
ERROR: {"codespace":8,"code":12,"abci_code":524300,"message":"Expected swap status is Open, actually it is Completed"}
```
* Not expired
```json
ERROR: {"codespace":8,"code":8,"abci_code":524296,"message":"Current block height is 40003412, the expire height (40013236) is still not reached"}
```

### Query Atomic Swap

Query atomic swap allows you to search swap information by `swap-ID`

#### Parameters

| Name | Type | Description | Optional |
| -----| ---- | ----------- | -------- |
| SwapID | 32 bytes | ID of previously created swap, hex encoding | No |

#### Examples

* On testnet:
```
./tbnbcli token query-swap --swap-id <swap-id> --chain-id Binance-Chain-Nile --trust-node --node http://data-seed-pre-0-s3.binance.org:80
```
Expected output
```json
{
  "from": "tbnb1g9rzc0e2jf8ef3qp9ax8h0pmpmvjzwmtq4jxfr",
  "to": "tbnb1nkx994qvqmqgk57vguqh6zjlacqzxdkue5zjyx",
  "out_amount": [
    {
      "denom": "BNB",
      "amount": "100"
    }
  ],
  "in_amount": [
    {
      "denom": "TEST-599",
      "amount": "10000"
    }
  ],
  "expected_income": "10000:TEST-599",
  "recipient_other_chain": "",
  "random_number_hash": "5768702259ee55983378d7b8207890c666648264524b9dada551386f832ba6b1",
  "random_number": "927c1ac33100bdbb001de19c626a05a7c3c11304fc825f5eabb22e741507711b",
  "timestamp": "1568792486",
  "cross_chain": false,
  "expire_height": "39994169",
  "index": "53",
  "closed_time": "1568792927",
  "status": "Completed"
}
```
### Query Atomic Swap ID By Recipient

Query atomic swap ID allows you to search swap history of an address

#### Parameters

| Name | Type | Description | Optional |
| -----| ---- | ----------- | -------- |
| recipient-addr | Address | Receiver address, where the asset is to, if the proper condition meets. | No |

#### Examples

* On testnet:
```
./tbnbcli token query-swapIDs-by-recipient  --recipient-addr <address> --chain-id Binance-Chain-Nile --trust-node --node http://data-seed-pre-0-s3.binance.org:80
```

Example output:
```
[
  "4d898bc8558daa4d817486d7a93b77b2c82fcec2123abf4a1eb7d2521237eccd",
  "e7cc2e2eb025cc4617ff0bb84fcffc973d7ba34f15dbc51383fe3543ff143e9c"
]
```

### Query Atomic Swap ID By Creator

Query atomic swap ID allows you to search swap history of an initiator

#### Parameters

| Name | Type | Description | Optional |
| -----| ---- | ----------- | -------- |
| creator-addr | Address | Receiver address, where the asset is to, if the proper condition meets. | No |

#### Examples

* On testnet:
```
./tbnbcli token query-swapIDs-by-creator  --creator-addr <address> --chain-id Binance-Chain-Nile --trust-node --node http://data-seed-pre-0-s3.binance.org:80
```

Example output:
```
[
  "7341d4ea0519af90d98f60fee45fdc7e385621875ea982bc8caf1fd7a49af8c3",
  "290664c1e8123966d8f9050fdc9d93e94b0e51b36e2e2a6978e492d3796423f1",
  "b260dad3cf63e558fe102a050afbe52d5dd2e30c7db76da33d02ce5f85d07fcf",
  "2b532bf9171c4d33d80fc4a8d6603581a86345b41552337482224d8476fcf5f7",
  "20d22bbfa579520f0ba79cd176fb2b06aa8dbe5b0a6ba8c9b761129f6a42a94c"
]
```


## Fees

Transaction Type | Pay in Non-BNB Asset | Pay in BNB | Exchange (DEX) Related
-- | -- | -- | --
HTLT | N/A |  0.000375 BNB | Y
depositHTLT | N/A |  0.000375 BNB | Y
claimHTLT | N/A |  0.000375 BNB | Y
refundHTLT | N/A |  0.000375 BNB | Y




## Workflows

### Preparations

1. Deploy smart-contract which supports Atomic Peg Swap (APS), there is  already [one example](https://github.com/binance-chain/bep3-smartcontracts) for Ethereum
2. Deploy `deputy` process for handling swap activities by token owners, there is an existing open-source solution here: <https://github.com/binance-chain/bep3-deputy>
3. Issue and transfer enough tokens

### Testnet Deployment

* ERC20 contract has been deployed here: <https://ropsten.etherscan.io/address/0xd93395b2771914e1679155f3ea58c41d89d96098>
* Token Symbol: **PPC**
* SmartContract has been deployed here:  <https://ropsten.etherscan.io/address/0x12dcbf79be178479870a473a99d91f535ed960ad>
* Its corresponding address on testnet is: `tbnb1pk45lc2k7lmf0pnfa59l0uhwrvpk8shsema7gr`on Binance Chain and `0xD93395B2771914E1679155F3EA58C41d89D96098` on Ethereum testnet

### Swap Tokens from Ethereum to Binance Chain
![image-20190918193751444](assets/eth2bnc.png)
#### 1.  Approve Swap Transaction

Go to: https://ropsten.etherscan.io/address/0xd93395b2771914e1679155f3ea58c41d89d96098#writeContract and approve some amount of tokens.
 * Function: *Approve*
 * Prameters:
     * _spender: address of smartcontract, which is `0x12DCBf79BE178479870A473A99d91f535ed960AD`
     * _value: approved amount, should be bumped by e^10

> Note: Please approve more than 1token.  In the following example, 100 PPC token was approved:

Example of approve 1000 PPC: <https://ropsten.etherscan.io/tx/0xfa640b382d3842cf508ac347090d2550e35e2193804d2a9318fbbdcdd54c846b>
#### 2. Call `HTLT` function From Ethereum

Go to: https://ropsten.etherscan.io/address/0xd93395b2771914e1679155f3ea58c41d89d96098#writeContract and call `HTLT` function
 * Function: *htlt*
 * Prameters:
      * _randomNumberHash: SHA256(secret||timestamp), your secret should be 32 bytes,
      * _timestamp: it should be about 10 mins span around current timestamp
      * _heightSpan: it's a customized filed for deputy operator. it should be more than 200 for this deputy.
      * _recipientAddr: deputy address on Ethereum, it's `0x1C002969Fe201975eD8F054916b071672326858e` for this one
      * _bep2SenderAddr: omit this field with `0x0`
      * _bep2RecipientAddr: Decode your testnet address from bech32 encoded to hex, for example: 0xc41f2a85e1d3629637de1222017dce46c6c8e4b9
      * _outAmount:  approved amount, should be bumped by e^10
      * _bep2Amount: _outAmount * exchange rate, the default rate is 1

Example of `htlt`: <https://ropsten.etherscan.io/tx/0xa2444cc1e52e09027ec68bf8955e7084235255f9f18d9b837a12fd63e6f0145c>

#### 3. Deputy Call HTLT on Binance Chain
Then, Deputy will send `HTLT` transaction here: <https://testnet-explorer.binance.org/tx/99CBC2896F0CF14DDAB0684BDA0A3E9FF2271056E68EC3559AB7FB24E0EE97DE>

#### 4. Claim HTLT on Binance Chain
* Confirm the HTLT from Deputy
```
./tbnbcli token query-swapIDs-by-recipient  --recipient-addr tbnb1cs0j4p0p6d3fvd77zg3qzlwwgmrv3e9e63423w --chain-id Binance-Chain-Nile --trust-node --node http://data-seed-pre-0-s3.binance.org:80
[
  "12aacc3bdc2cef97e8e45cc9b409796df57904a4e9c76863ad8420ff75f13128"
]
```

Please use this ID and the secrect you used for generating secret hash to claim BEP2 tokens.

```
./tbnbcli token claim --swap-id  12aacc3bdc2cef97e8e45cc9b409796df57904a4e9c76863ad8420ff75f13128  --random-number <random-number> --from <from-key>  --chain-id Binance-Chain-Nile --trust-node --node http://data-seed-pre-0-s3.binance.org:80
```

Example of `claim` tx on testnet: <https://testnet-dex.binance.org/api/v1/tx/6BA714E6D107F1D9634DDC159F560A1FB61393B8E15723EFD70B9EA8B0B1AA9A?format=json>

#### 5. Deputy Claim ERC20 Token

Deputy will claim ERC20 tokens afterwards: <https://ropsten.etherscan.io/tx/0x3a422bdb273d4eb4d112ae8e51e8acd3ad706b2af67af20a5f15a18e4acc70fc>

### Swap Tokens from Binance Chain to Ethereum
![image-20190918193910521](assets/bnc2eth.png)

#### 1. Send `HTLT` Transaction from Binance Chain

Please read this [section](#hash-timer-locked-transfer) to generate a valid `HTLT` transaction. Please write down the `secret` and `secret hash`.
```
./tbnbcli token HTLT --from atomic --recipient-addr tbnb1pk45lc2k7lmf0pnfa59l0uhwrvpk8shsema7gr  --chain-id Binance-Chain-Nile  --height-span 10000 --amount  9900000000:PPC-00A  --expected-income 9900000000:PPC  --recipient-other-chain 0x133D144F52705cEb3f5801B63b9EBcCF4102f5Ed  --cross-chain --trust-node --node http://data-seed-pre-0-s3.binance.org:80
Random number: 4811959406ea3e69721d944d308880ec41323b7f89e51a78df3693348779315e
Timestamp: 1569578936
Random number hash: b03f256c9efdb97b9815faa1417e1da4cca7672e0bb26e4e7d9bfc82d0f1f15e
```
> Note: the swap amount should be more than one.

Please write down the `secret` and `secret hash` for next steps.

Example is here: <https://testnet-explorer.binance.org/tx/9ECECE9E0F08EE78583CFA37FD4C3F03521289F0F229A612886B8B21B9C62D7F>

Then, you can query the `Swap-ID`:
```
./tbnbcli token query-swapIDs-by-creator --creator-addr tbnb1cs0j4p0p6d3fvd77zg3qzlwwgmrv3e9e63423w --trust-node --node https://seed-pre-s3.binance.org:443 --chain-id Binance-Chain-Nile --limit 10
[
"f85dd907df0a5897927b949c0f9e2563d453ba698ff9941fed1ce91f8057afc2"
]
```
#### 2.  Deputy Approve Tokens

You should see that **Deputy** has approve enough amount of tokens for atomic swap.

#### 3. Deputy Send HTLT on Ethereum

You should see that **Deputy** has sent the `htlt` transaction afterwards: <https://ropsten.etherscan.io/tx/0x142fb8db7eb66feb241ca710a028678e36595fc8aea03858672288fcac8e4494>

You can use this `Swap-ID` for refund.

#### 4. Claim ERC20 Tokens on Ethereum

You should see that **Deputy** has already approved enough tokens and

In its event log, you should see the `Swap-ID`. Then, you can call the `claim` function:
 * Function: *claim*
 * Prameters:
    * _swapID: this is get from event, you can also calculate it from `calSwapID` function
    * _randomNumber: reveal your secret

Example: https://ropsten.etherscan.io/tx/0x9cf7cc7891b86987c4eef59e3b4950324d656e6937a38b91786894f52c76f41b

#### 5. Deputy Claim on Binance Chain

`HTLT Claim` transaction from **Deputy** is sent afterwards: <https://testnet-explorer.binance.org/tx/8C616DEFD2EAA41E13D2DC4844B218DFF8CFE24B4C7A693AAD700381B5FF7B48>

### Swap between Several BEP2 tokens

![image-20190918193422062](assets/same-chain.png)

### Swap between Several BEP2 tokens fails

![image-20190918193518929](assets/samechain-fail.png)

