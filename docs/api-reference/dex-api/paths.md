HTTP API
========
The Binance Chain HTTP API provides access to a Binance Chain node deployment and market data services.

**Version:** 1.0.0

**License:** [Apache 2.0](http://www.apache.org/licenses/LICENSE-2.0.html)

### /api/v1/time
---
##### ***GET***
**Summary:** Get the block time.

**Description:** Gets the latest block time and the current time according to the HTTP service.

**Destination:** Validator node.

**Rate Limit:** 1 request per IP per second.

**Test URL:** [https://testnet-dex.binance.org/api/v1/time](https://testnet-dex.binance.org/api/v1/time)


**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | Success | [Times](#times) |
| 400 | Bad Request | [Error](#error) |
| 404 | Not Found |  |
| default | Generic error response | [Error](#error) |

### /api/v1/node-info
---
##### ***GET***
**Summary:** Get node information.

**Description:** Gets runtime information about the node.

**Destination:** Validator node.

**Rate Limit:** 1 request per IP per second.

**Test URL:** [https://testnet-dex.binance.org/api/v1/node-info](https://testnet-dex.binance.org/api/v1/node-info)


**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | Success | object |

### /api/v1/validators
---
##### ***GET***
**Summary:** Get validators.

**Description:** Gets the list of validators used in consensus.

**Destination:** Witness node.

**Rate Limit:** 10 requests per IP per second.

**Test URL:** [https://testnet-dex.binance.org/api/v1/validators](https://testnet-dex.binance.org/api/v1/validators)


**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | Success | [ [Validator](#validator) ] |
| 400 | Bad Request | [Error](#error) |
| 404 | Not Found |  |
| default | Generic error response | [Error](#error) |

### /api/v1/peers
---
##### ***GET***
**Summary:** Get network peers.

**Description:** Gets the list of network peers.

**Destination:** Witness node.

**Rate Limit:** 1 request per IP per second.

**Test URL:** [https://testnet-dex.binance.org/api/v1/peers](https://testnet-dex.binance.org/api/v1/peers)


**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | Success | [ [Peer](#peer) ] |
| 400 | Bad Request | [Error](#error) |
| 404 | Not Found |  |
| default | Generic error response | [Error](#error) |

### /api/v1/account/{address}
---
##### ***GET***
**Summary:** Get an account.

**Description:** Gets account metadata for an address.

**Destination:** Witness node.

**Rate Limit:** 5 requests per IP per second.

**Test URL:** [https://testnet-dex.binance.org/api/v1/account/bnc18hy3dz0lfky74shaatswmuhd2dxyl847fwsvkk](https://testnet-dex.binance.org/api/v1/account/bnc18hy3dz0lfky74shaatswmuhd2dxyl847fwsvkk)


**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| address | path | The account address to query | Yes | string |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | Success | [Account](#account) |
| 400 | Bad Request | [Error](#error) |
| 404 | Not Found |  |
| default | Generic error response | [Error](#error) |

### /api/v1/account/{address}/sequence
---
##### ***GET***
**Summary:** Get an account sequence.

**Description:** Gets an account sequence for an address.

**Destination:** Validator node.

**Rate Limit:** 5 requests per IP per second.

**Test URL:** [https://testnet-dex.binance.org/api/v1/account/bnc18hy3dz0lfky74shaatswmuhd2dxyl847fwsvkk/sequence](https://testnet-dex.binance.org/api/v1/account/bnc18hy3dz0lfky74shaatswmuhd2dxyl847fwsvkk/sequence)


**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| address | path | The account address to query | Yes | string |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | Success | [AccountSequence](#accountsequence) |
| 400 | Bad Request | [Error](#error) |
| 404 | Not Found |  |
| default | Generic error response | [Error](#error) |

### /api/v1/tx/{hash}
---
##### ***GET***
**Summary:** Get a transaction.

**Description:** Gets transaction metadata by transaction ID.

**Destination:** Seed node.

**Rate Limit:** 10 requests per IP per second.

**Example:**
If `format` is not provided or `format` is not `json`, the response should look like:
```
{
    data: "Tx{DD01F0625DEE0A65CE6DC0430A148672775CD0C8EA51364B5231FD9A63893B55FF82122B383637323737354344304338454135313336344235323331464439413633383933423535464638322D32391A0D4144412E422D4632465F424E422002280230E0891C3880C2D72F4001126E0A26EB5AE98721034C8D7630EAB6CF86963D0CFBAFBC01A4E78841334A740726BCBC4E531957B0D7124053C0B41B7FAD40BD1B25E592A20B7D95A871975A209A9AB5D156717B7BCE36F66495D23705B253A7C63781E17E0EC17D2D6AB809C37E29BBA0F1468200D7C4231818201C2003}",
    hash: "E81BAB8E555819E4211D62E2E536B6D5812D3D91C105F998F5C6EB3AB8136482",
    log: "Msg 0: ",
    ok: true
}
```

If `format` is `json`, the response should look like:
```
 {
     "hash": "E81BAB8E555819E4211D62E2E536B6D5812D3D91C105F998F5C6EB3AB8136482",
     "height": "754",
     "tx": {
         "type": "auth/StdTx", // fixed, type of transaction
         "value": {            // fixed, detail of the transaction
             "data": null,     // fixed, data of the transaction
             "memo": "",       // fixed, memo
             "msg": [          // fixed, msgs of the transaction
                 {
                     "type": "cosmos-sdk/Send",  // vary with msg type
                     "value": {                  // value content vary with mst type
                         "inputs": [
                             {
                                 "address": "bnb1vt4zwu5hy7tyryktud6mpcu8h2ehh6xw66gzwp",
                                 "coins": [
                                     {
                                         "amount": "100000000000000",
                                         "denom": "BNB"
                                     }
                                 ]
                             }
                         ],
                         "outputs": [
                             {
                                 "address": "bnb1kg8mh20tndur9d9rry4wjunhpfzcud30qzf0qv",
                                 "coins": [
                                     {
                                         "amount": "100000000000000",
                                         "denom": "BNB"
                                     }
                                 ]
                             }
                         ]
                     }
                 }
             ],
             "signatures": [ // fixed, signatures of the transaction
                 {
                     "account_number": "0",
                     "pub_key": {
                         "type": "tendermint/PubKeySecp256k1",
                         "value": "AoWY3eWBOnnvLPTz4RsUlX1pWCkLLPewu1vAAoTEzxzR"
                     },
                     "sequence": "1",
                     "signature": "6O2TQAgleFNPw4zIWBLaNvOf5dR7DHNSr2DwAPeFK6lokRqZd2KR2BD+WlmaWj4LdLo5N+utN1JtY41E91N0uw=="
                 }
             ],
             "source": "0"  // fixed, source of the transaction
         }
     }
 }
 ```


**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| hash | path | The transaction hash to query | Yes | string |
| format | query | format of tx, if provided, will return specific format of tx, only support `json` (optional) | No | string |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | Success | [Transaction](#transaction) |
| 400 | Bad Request | [Error](#error) |
| 404 | Not Found |  |
| default | Generic error response | [Error](#error) |

### /api/v1/tokens
---
##### ***GET***
**Summary:** Get tokens list.

**Description:** Gets a list of tokens that have been issued.

**Destination:** Witness node.

**Rate Limit:** 1 request per IP per second.

**Test URL:** [https://testnet-dex.binance.org/api/v1/tokens](https://testnet-dex.binance.org/api/v1/tokens)


**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | Success | [ [Token](#token) ] |
| 400 | Bad Request | [Error](#error) |
| 404 | Not Found |  |
| default | Generic error response | [Error](#error) |

### /api/v1/markets
---
##### ***GET***
**Summary:** Get market pairs.

**Description:** Gets the list of market pairs that have been listed.

**Destination:** Witness node.

**Rate Limit:** 1 request per IP per second.

**Test URL:** [https://testnet-dex.binance.org/api/v1/markets](https://testnet-dex.binance.org/api/v1/markets)


**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | Success | [ [Market](#market) ] |
| 400 | Bad Request | [Error](#error) |
| 404 | Not Found |  |
| default | Generic error response | [Error](#error) |

### /api/v1/fees
---
##### ***GET***
**Summary:** Obtain trading fees information.

**Description:** Gets the current trading fees settings.

**Destination:** Witness node.

**Rate Limit:** 1 request per IP per second.

**Test URL:** [https://testnet-dex.binance.org/api/v1/fees](https://testnet-dex.binance.org/api/v1/fees)


**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | Success | [ [Fee](#fee) ] |
| default | Generic error response | [Error](#error) |

### /api/v1/depth
---
##### ***GET***
**Summary:** Get the order book.

**Description:** Gets the order book depth data for a given pair symbol.

The given _limit_ must be one of the allowed limits below.

**Destination:** Validator node.

**Rate Limit:** 10 requests per IP per second.

**Test URL:** [https://testnet-dex.binance.org/api/v1/depth?symbol=xxx-000_BNB](https://testnet-dex.binance.org/api/v1/depth?symbol=xxx-000_BNB)


**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| symbol | query | Market pair symbol, e.g. NNB-0AD_BNB | Yes | string |
| limit | query | The limit of results. Allowed limits: [5, 10, 20, 50, 100, 500, 1000] | No | integer |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | Success | [MarketDepth](#marketdepth) |
| 400 | Bad Request | [Error](#error) |
| 404 | Not Found |  |
| default | Generic error response | [Error](#error) |

### /api/v1/broadcast
---
##### ***POST***
**Summary:** Broadcast a transaction.

**Description:** Broadcasts a signed transaction. A single transaction must be sent hex-encoded with a `content-type` of `text/plain`.

**Destination:** Witness node.

**Rate Limit:** 5 requests per IP per second.

**Test URL:** [https://testnet-dex.binance.org/api/v1/broadcast](https://testnet-dex.binance.org/api/v1/broadcast)


**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| sync | query | Synchronous broadcast (wait for [DeliverTx](https://github.com/tendermint/tendermint/wiki/Application-Developers#delivertx))?  | No | boolean |
| body | body |  | Yes | binary |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | Success | [ [Transaction](#transaction) ] |
| 400 | Bad Request | [Error](#error) |
| 404 | Not Found |  |
| default | Generic error response | [Error](#error) |

### /api/v1/klines
---
##### ***GET***
**Summary:** Get candlestick bars.

**Description:** Gets candlestick/kline bars for a symbol. Bars are uniquely identified by their open time.

**Rate Limit:** 10 requests per IP per second.

**Test URL:** [https://testnet-dex.binance.org/api/v1/klines?symbol=NNB-338_BNB&interval=5m](https://testnet-dex.binance.org/api/v1/klines?symbol=NNB-338_BNB&interval=5m)

**Example**

```
[
  1499040000000,      // Open time
  "0.01634790",       // Open
  "0.80000000",       // High
  "0.01575800",       // Low
  "0.01577100",       // Close
  "148976.11427815",  // Volume
  1499644799999,      // Close time
  "2434.19055334",    // Quote asset volume
  308                // Number of trades
]
```


**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| symbol | query | symbol | Yes | string |
| interval | query | interval. Allowed value: [1m, 3m, 5m, 15m, 30m, 1h, 2h, 4h, 6h, 8h, 12h, 1d, 3d, 1w, 1M] | Yes | string |
| limit | query | default 300; max 1000. | No | integer |
| startTime | query | start time | No | long |
| endTime | query | end time | No | long |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | OK | [ [Candlestick](#candlestick) ] |

### /api/v1/orders/closed
---
##### ***GET***
**Summary:** Get closed orders.

**Description:** Gets closed (filled and cancelled) orders for a given address.

**Rate Limit:** 5 requests per IP per second.


**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| address | query | the owner address | Yes | string |
| end | query | end time | No | long |
| limit | query | default 500; max 1000. | No | integer |
| offset | query | start with 0; default 0. | No | integer |
| side | query | order side. 1 for buy and 2 for sell. | No | integer |
| start | query | start time; The maximum start - end query window is 3 months; Default query window is latest 7 days. | No | long |
| status | query | order status list. Allowed value: [Ack, PartialFill, IocNoFill, FullyFill, Canceled, Expired, FailedBlocking, FailedMatching] | No | [ string ] |
| symbol | query | symbol | No | string |
| total | query | total number required, 0 for not required and 1 for required; default not required, return total=-1 in response | No | integer |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | OK | [OrderList](#orderlist) |

### /api/v1/orders/open
---
##### ***GET***
**Summary:** Get open orders.

**Description:** Gets open orders for a given address.

**Rate Limit:** 5 requests per IP per second.


**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| address | query | the owner address | Yes | string |
| limit | query | default 500; max 1000. | No | integer |
| offset | query | start with 0; default 0. | No | integer |
| symbol | query | symbol | No | string |
| total | query | total number required, 0 for not required and 1 for required; default not required, return total=-1 in response | No | integer |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | OK | [OrderList](#orderlist) |
| 400 | Bad Request | [Error](#error) |
| 404 | Not Found |  |
| default | Generic error response | [Error](#error) |

### /api/v1/orders/{id}
---
##### ***GET***
**Summary:** Get an order.

**Description:** Gets metadata for an individual order by its ID.

**Rate Limit:** 5 requests per IP per second.


**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | order id | Yes | string |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | OK | [Order](#order) |
| 400 | Bad Request | [Error](#error) |
| 404 | Not Found |  |
| default | Generic error response | [Error](#error) |

### /api/v1/ticker/24hr
---
##### ***GET***
**Summary:** Get a market ticker.

**Description:** Gets 24 hour price change statistics for a market pair symbol.

**Rate Limit:** 5 requests per IP per second.


**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| symbol | query | symbol | No | string |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | OK | [ [TickerStatistics](#tickerstatistics) ] |
| 400 | Bad Request | [Error](#error) |
| 404 | Not Found |  |
| default | Generic error response | [Error](#error) |

### /api/v1/trades
---
##### ***GET***
**Summary:** Get market trades.

**Description:** Gets a list of historical trades.

**Rate Limit:** 5 requests per IP per second.


**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| address | query | the buyer/seller address | No | string |
| buyerOrderId | query | buyer order id | No | string |
| end | query | end time | No | long |
| height | query | block height | No | long |
| limit | query | default 500; max 1000. | No | integer |
| offset | query | start with 0; default 0. | No | integer |
| quoteAsset | query | quote asset | No | string |
| sellerOrderId | query | seller order id | No | string |
| side | query | order side. 1 for buy and 2 for sell. | No | integer |
| start | query | start time; The maximum start - end query window is 3 months; Default query window is latest 7 days. | No | long |
| symbol | query | symbol | No | string |
| total | query | total number required, 0 for not required and 1 for required; default not required, return total=-1 in response | No | integer |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | OK | [TradePage](#tradepage) |
| 400 | Bad Request | [Error](#error) |
| 404 | Not Found |  |
| default | Generic error response | [Error](#error) |

### /api/v1/transactions
---
##### ***GET***
**Summary:** Get transactions.

**Description:** Gets a list of transactions.

**Rate Limit:** 60 requests per IP per minute.


**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| address | query | address | Yes | string |
| blockHeight | query | blockHeight | No | long |
| endTime | query | endTime | No | long |
| limit | query | limit | No | integer |
| offset | query | offset | No | integer |
| side | query | transaction side. Allowed value: [ RECEIVE, SEND] | No | string |
| startTime | query | start time; The maximum start - end query window is 3 months; Default query window is latest 24 hours. | No | long |
| txAsset | query | txAsset | No | string |
| txType | query | transaction type. Allowed value: [ NEW_ORDER,ISSUE_TOKEN,BURN_TOKEN,LIST_TOKEN,CANCEL_ORDER,FREEZE_TOKEN,UN_FREEZE_TOKEN,TRANSFER,PROPOSAL,VOTE] | No | string |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | OK | [TxPage](#txpage) |
| 400 | Bad Request | [Error](#error) |
| 404 | Not Found |  |
| default | Generic error response | [Error](#error) |

### Models
---

### Error  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| code | long |  |  |
| message | string |  |  |

### Times  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| ap_time | string | e.g. 2019-01-21T10:30:00Z |  |
| block_time | string | format as above |  |

### Validator  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| block_height | long | Current block height |  |
| validators | [  ] |  |  |

### Peer  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| id | string | Authenticated identifier |  |
| original_listen_addr | string (RemoteAddr) | Original listen address before PeersService changed it |  |
| listen_addr | string (RemoteAddr) | Listen address |  |
| access_addr | string (RemoteAddr) | Access address (HTTP) |  |
| stream_addr | string (RemoteAddr) | Stream address (WS) |  |
| network | string | Chain ID |  |
| version | string | Version |  |
| moniker | string | Moniker (Name) |  |
| capabilities | [ string ] | Array of capability tags: node, qs, ap, ws | node,ap |
| accelerated | boolean | Is an accelerated path to a validator node |  |

### Transaction  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| hash | string | Hash of transaction |  |
| log | string | Log of transaction |  |
| data | string | Data of transaction |  |
| tx | object | Detail of transaction, like transaction type, messages and signature

For example, below is the detail of a send transaction. Most of the fields are fixed, but the detail of msg
varies with msg type.

```
{
    "type": "auth/StdTx", // fixed, type of transaction
    "value": {            // fixed, detail of the transaction
        "data": null,     // fixed, data of the transaction
        "memo": "",       // fixed, memo
        "msg": [          // fixed, msgs of the transaction
            {
                "type": "cosmos-sdk/Send",  // vary with msg type
                "value": {                  // value content vary with mst type
                    "inputs": [
                        {
                            "address": "bnb1vt4zwu5hy7tyryktud6mpcu8h2ehh6xw66gzwp",
                            "coins": [
                                {
                                    "amount": "100000000000000",
                                    "denom": "BNB"
                                }
                            ]
                        }
                    ],
                    "outputs": [
                        {
                            "address": "bnb1kg8mh20tndur9d9rry4wjunhpfzcud30qzf0qv",
                            "coins": [
                                {
                                    "amount": "100000000000000",
                                    "denom": "BNB"
                                }
                            ]
                        }
                    ]
                }
            }
        ],
        "signatures": [ // fixed, signatures of the transaction
            {
                "account_number": "0",
                "pub_key": {
                    "type": "tendermint/PubKeySecp256k1",
                    "value": "AoWY3eWBOnnvLPTz4RsUlX1pWCkLLPewu1vAAoTEzxzR"
                },
                "sequence": "1",
                "signature": "6O2TQAgleFNPw4zIWBLaNvOf5dR7DHNSr2DwAPeFK6lokRqZd2KR2BD+WlmaWj4LdLo5N+utN1JtY41E91N0uw=="
            }
        ],
        "source": "0"  // fixed, source of the transaction
    }
}
```
 |  |
| height | string | Height of transaction |  |
| code | integer | Result code of transaction |  |
| ok | boolean |  |  |

### Account  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| account_number | integer |  |  |
| address | string (address) |  |  |
| balances | [ [Balance](#balance) ] |  |  |
| public_key | [ integer ] | Public key bytes |  |
| sequence | long |  |  |

### AccountSequence  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| sequence | long |  |  |

### Balance  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| symbol | string (currency) |  | BNB |
| free | string (fixed8) | In decimal form, e.g. 0.00000000 | 0.00000000 |
| locked | string (fixed8) | In decimal form, e.g. 0.00000000 | 0.00000000 |
| frozen | string (fixed8) | In decimal form, e.g. 0.00000000 | 0.00000000 |

### Token  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| name | string |  | Binance Chain Native Token |
| symbol | string |  | BTC-000 |
| original_symbol | string |  | BTC |
| total_supply | string (fixed8) | In decimal form, e.g. 1.00000000 | 0.00000000 |
| owner | string (address) | Address |  |

### Market  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| base_asset_symbol | string (currency) |  | BNB |
| quote_asset_symbol | string (currency) |  | BNB |
| price | string (fixed8) | In decimal form, e.g. 1.00000000 | 0.00000000 |
| tick_size | string (fixed8) | In decimal form, e.g. 1.00000000 | 0.00000000 |
| lot_size | string (fixed8) | In decimal form, e.g. 1.00000000 | 0.00000000 |

### Fee  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| msg_type | string | Transaction msg type that this fee applies to | submit_proposal |
| fee | number | The fee amount | 1000000000 |
| fee_for | integer | 1 = proposer, 2 = all, 3 = free | 1 |
| multi_transfer_fee | string | Fee for multi-transfer | 200000 |
| lower_limit_as_multi | string | e.g. 2 | 2 |
| fixed_fee_params | [FixedFeeParams](#fixedfeeparams) | Set if the fee is fixed |  |

### FixedFeeParams  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| msg_type | string | Transaction msg type that this fee applies to | submit_proposal |
| fee | number | The fixed fee amount | 1000000000 |
| fee_for | integer | 1 = proposer, 2 = all, 3 = free | 1 |

### MarketDepth  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| asks | [ string (fixed8) ] | Price and qty in decimal form, e.g. 1.00000000 | ["1.00000000","800.00000000"] |
| bids | [ string (fixed8) ] | Price and qty in decimal form, e.g. 1.00000000 | ["1.00000000","800.00000000"] |

### BlockTradePage  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| blockTrade | [ [BlockTrade](#blocktrade) ] |  |  |
| total | long |  |  |

### BlockTrade  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| blockTime | long |  |  |
| fee | string |  |  |
| height | long |  |  |
| trade | [ [Trade](#trade) ] |  |  |

### Candlestick  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| close | number |  |  |
| closeTime | long |  |  |
| high | number |  |  |
| low | number |  |  |
| numberOfTrades | integer |  |  |
| open | number |  |  |
| openTime | long |  |  |
| quoteAssetVolume | number |  |  |
| volume | number |  |  |

### OrderList  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| order | [ [Order](#order) ] |  |  |
| total | long |  |  |

### Order  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| cumulateQuantity | string |  |  |
| fee | string |  |  |
| lastExecutedPrice | string |  |  |
| lastExecutedQuantity | string |  |  |
| orderCreateTime | dateTime |  |  |
| orderId | string |  |  |
| owner | string |  |  |
| price | string |  |  |
| quantity | string |  |  |
| side | integer | 1 for buy and 2 for sell |  |
| status | string | enum [Ack, PartialFill, IocNoFill, FullyFill, Canceled, Expired, FailedBlocking, FailedMatching] |  |
| symbol | string |  |  |
| timeInForce | integer | 1 for Good Till Expire(GTE) order and 3 for Immediate Or Cancel (IOC) |  |
| tradeId | string |  |  |
| transactionHash | string |  |  |
| transactionTime | dateTime |  |  |
| type | integer | only 2 is available for now, meaning limit order |  |

### TickerStatistics  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| askPrice | string |  |  |
| askQuantity | string |  |  |
| bidPrice | string |  |  |
| bidQuantity | string |  |  |
| closeTime | long |  |  |
| count | long |  |  |
| firstId | string |  |  |
| highPrice | string |  |  |
| lastId | string |  |  |
| lastPrice | string |  |  |
| lastQuantity | string |  |  |
| lowPrice | string |  |  |
| openPrice | string |  |  |
| openTime | long |  |  |
| prevClosePrice | string |  |  |
| priceChange | string |  |  |
| priceChangePercent | string |  |  |
| quoteVolume | string |  |  |
| symbol | string |  |  |
| volume | string |  |  |
| weightedAvgPrice | string |  |  |

### TradePage  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| total | long |  |  |
| trade | [ [Trade](#trade) ] |  |  |

### Trade  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| baseAsset | string |  |  |
| blockHeight | long |  |  |
| buyFee | string |  |  |
| buyerId | string |  |  |
| buyerOrderId | string |  |  |
| price | string |  |  |
| quantity | string |  |  |
| quoteAsset | string |  |  |
| sellFee | string |  |  |
| sellerId | string |  |  |
| sellerOrderId | string |  |  |
| symbol | string |  |  |
| time | long |  |  |
| tradeId | string |  |  |

### TxPage  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| total | long |  |  |
| tx | [ [Tx](#tx) ] |  |  |

### Tx  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| blockHeight | long |  |  |
| code | integer |  | 0 |
| confirmBlocks | long |  |  |
| data | string |  |  |
| fromAddr | string |  |  |
| orderId | string |  |  |
| timeStamp | dateTime |  |  |
| toAddr | string |  |  |
| txAge | long |  |  |
| txAsset | string |  |  |
| txFee | string |  |  |
| txHash | string |  |  |
| txType | string |  |  |
| value | string |  |  |

### ExchangeRate  

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| ExchangeRate | object |  |  |