# Upcoming Changes in Binance Chain API v0.6.0



## HTTP API

As you know, There are some accelerate nodes which provides some advanced API services for the public. Here is a list of all the HTTP API information it provides on mainnet: https://docs.binance.org/api-reference/dex-api/paths.html

In the latest update of HTTP API for testnet, there are the following changes:

1. /api/v1/orders/{id}
Example:

https://dex-atlantic.binance.org/api/v1/

##### ***Changes***
Please note that `singleFee` is added in the `Order` data structure to help you know the trading fee of this order.

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

### Order

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| cumulateQuantity | string |  |  |
| fee | string | trading fee on the block of this order |  |
| lastExecutedPrice | string | price of last execution |  |
| lastExecutedQuantity | string | quantity of last execution |  |
| orderCreateTime | dateTime | time of order creation |  |
| orderId | string | order ID |  |
| owner | string | order issuer |  |
| price | string | order price |  |
| quantity | string | order quantity |  |
| side | integer | 1 for buy and 2 for sell |  |
| **singleFee** | string | trading fee of this order |  |
| status | string | enum [Ack, PartialFill, IocNoFill, FullyFill, Canceled, Expired, FailedBlocking, FailedMatching, IocExpire] |  |
| symbol | string |  |  |
| timeInForce | integer | 1 for Good Till Expire(GTE) order and 3 for Immediate Or Cancel (IOC) |  |
| tradeId | string | trade ID |  |
| transactionHash | string |  |  |
| transactionTime | dateTime | time of transaction |  |
| type | integer | only 2 is available for now, meaning limit order |  |


### /api/v1/trades
---
##### ***Changes***
In the `Trade` data structure, a new field `Ticker Type` is added. The enumerate values are: "Unknown", "SellTaker","BuyTaker","BuySurplus","SellSurplus","Neutral". When there is a maker and taker, `SellTaker` and  `BuyTaker` are used to indicate the side. When both sides are taker,  `BuySurplus`, `SellSurplus` and `Neutral` are used to indicate market pressure.`Unknown` mean the type is not possible to define.

* `buySingleFee` is used to show trading fee for the buyer address on this single trade .
* `sellSingleFee`is used to show  trading fee for the seller address on this single trade.

##### ***GET***
**Summary:** Get market trades.

**Description:** Gets a list of historical trades.

**Query Window:** Default query window is latest 7 days; The maximum start - end query window is 3 months.

**Rate Limit:** 5 requests per IP per second.


**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| address | query | the buyer/seller address | No | string |
| buyerOrderId | query | buyer order id | No | string |
| end | query | end time in Milliseconds | No | long |
| height | query | block height | No | long |
| limit | query | default 500; max 1000. | No | integer |
| offset | query | start with 0; default 0. | No | integer |
| quoteAsset | query | quote asset | No | string |
| sellerOrderId | query | seller order id | No | string |
| side | query | order side. 1 for buy and 2 for sell. | No | integer |
| start | query | start time in Milliseconds | No | long |
| symbol | query | symbol | No | string |
| total | query | total number required, 0 for not required and 1 for required; default not required, return total=-1 in response | No | integer |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | OK | [TradePage](#tradepage) |
| 400 | Bad Request | [Error](#error) |
| 404 | Not Found |  |
| default | Generic error response | [Error](#error) |


### TradePage

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| total | long |  |  |
| trade | [ [Trade](#trade) ] |  |  |

### Trade

| Name | Type | Description | Example |
| ---- | ---- | ----------- | ------- |
| baseAsset | string | base asset |  |
| blockHeight | long | block height |  |
| buyFee | string | trading fee for the buyer address on the block of this trade |  |
| buyerId | string | id of buyer |  |
| buyerOrderId | string | order id for buyer |  |
| **buySingleFee** | string | trading fee for the buyer address on this single trade |  |
| price | string | trade price |  |
| quantity | string | trade quantity |  |
| quoteAsset | string | quote asset |  |
| sellFee | string | trading fee for the seller address on the block of this trade |  |
| sellerId | string | seller ID |  |
| sellerOrderId | string | seller order ID |  |
| **sellSingleFee** | string | trading fee for the seller address on this single trade |  |
| symbol | string | asset symbol |  |
| **tickType** | string | enum [Unknown,SellTaker,BuyTaker,BuySurplus,SellSurplus,Neutral] |  |
| time | long | trade time |  |
| tradeId | string | trade ID |  |



## Websocket

### Trades
#### Changes

In received Payload of `trades`, a new filed `tt` is added. Its enumerate values are:
* 0: Unknown
* 1: SellTaker
* 2: BuyTaker
* 3: BuySurplus
* 4: SellSurplus
* 5: Neutral

  **Received Payload:**

```javascript
{
    "stream": "trades",
    "data": [{
        "e": "trade",       // Event type
        "E": 123456789,     // Event height
        "s": "BNB_BTC",     // Symbol
        "t": "12345",       // Trade ID
        "p": "0.001",       // Price
        "q": "100",         // Quantity
        "b": "88",          // Buyer order ID
        "a": "50",          // Seller order ID
        "T": 123456785,     // Trade time
        "sa": "bnb1me5u083m2spzt8pw8vunprnctc8syy64hegrcp", // SellerAddress
        "ba": "bnb1kdr00ydr8xj3ydcd3a8ej2xxn8lkuja7mdunr5" // BuyerAddress
        "tt": 1   //tiekertype
    },
    {
        "e": "trade",       // Event type
        "E": 123456795,     // Event time
        "s": "BNB_BTC",     // Symbol
        "t": "12348",       // Trade ID
        "p": "0.001",       // Price
        "q": "100",         // Quantity
        "b": "88",          // Buyer order ID
        "a": "52",          // Seller order ID
        "T": 123456795,     // Trade time
        "sa": "bnb1me5u083m2spzt8pw8vunprnctc8syy64hegrcp", // SellerAddress
        "ba": "bnb1kdr00ydr8xj3ydcd3a8ej2xxn8lkuja7mdunr5" // BuyerAddress
        "tt": 0    //tiekertype
    }]
}
```

## Extra data from your fullnode

All those [extra info](https://docs.binance.org/get-extra-data-from-fullnode.html#publish-different-messages-to-local-files ) can also be found in exported data from your fullnode.

### Changes
In `trade` data structure, there are five new fields: `SSrc`,`BSrc`,`SSingleFee`, `BSingleFee` and `TickerType`.

* `SSrc`: Source code of Sell order transaction
* `BSrc`: Source code of Buy order transaction
* `SSingleFee`: fee of matched sell order
* `BSingleFee`: fee of matched buy order
* `TickerType`: ticker type

In `Order` data structure, there is a new field: `singlefee`. This is used to show the fee of this order.



For example:


```json
"Height":3154,
   "Timestamp":1560927932877738000,
   "NumOfMsgs":4,
   "Trades":{
      "NumOfMsgs":1,
      "Trades":[
         {
            "Id":"3154-0",
            "Symbol":"NNB-811_BNB",
            "Price":1200000000,
            "Qty":1200000000,
            "Sid":"8FEC97AB9B3F52A30B860CFBB8E41B72E9EB02C1-11",
            "Bid":"01C93F3512BCAA7E1DDD490B69B85E53A76C79B9-2",
            "Sfee":"BNB:5760000",
            "Bfee":"BNB:5760000",
            "SSrc":0,
            "BSrc":0,
            "SSingleFee":"",
            "BSingleFee":"",
            "TickType":0,
            "SAddr":"bnb13lkf02um8af2xzuxpnam3eqmwt57kqkp3hcvyp",
            "BAddr":"bnb1q8yn7dgjhj48u8wafy9knwz72wnkc7dehf39ch"
         }
      ]
   },
   "Orders":{
      "NumOfMsgs":3,
      "Orders":[
         {
            "Symbol":"NNB-811_BNB",
            "Status":0,
            "OrderId":"01C93F3512BCAA7E1DDD490B69B85E53A76C79B9-2",
            "TradeId":"",
            "Owner":"bnb1q8yn7dgjhj48u8wafy9knwz72wnkc7dehf39ch",
            "Side":1,
            "OrderType":2,
            "Price":1300000000,
            "Qty":1300000000,
            "LastExecutedPrice":0,
            "LastExecutedQty":0,
            "CumQty":1200000000,
            "Fee":"",
            "OrderCreationTime":1560927932877738000,
            "TransactionTime":1560927932877738000,
            "TimeInForce":1,
            "CurrentExecutionType":0,
            "TxHash":"A120FAA19A3448119E7F32B986540B21A5927616C73F95ACD1626FB54A74A865",
            "SingleFee":""
         },
         {
            "Symbol":"NNB-811_BNB",
            "Status":5,
            "OrderId":"01C93F3512BCAA7E1DDD490B69B85E53A76C79B9-2",
            "TradeId":"3154-0",
            "Owner":"bnb1q8yn7dgjhj48u8wafy9knwz72wnkc7dehf39ch",
            "Side":1,
            "OrderType":2,
            "Price":1300000000,
            "Qty":1300000000,
            "LastExecutedPrice":1200000000,
            "LastExecutedQty":1200000000,
            "CumQty":1200000000,
            "Fee":"BNB:5760000",
            "OrderCreationTime":1560927932877738000,
            "TransactionTime":1560927932877738000,
            "TimeInForce":1,
            "CurrentExecutionType":0,
            "TxHash":"A120FAA19A3448119E7F32B986540B21A5927616C73F95ACD1626FB54A74A865",
            "SingleFee":""
         },
         {
            "Symbol":"NNB-811_BNB",
            "Status":6,
            "OrderId":"8FEC97AB9B3F52A30B860CFBB8E41B72E9EB02C1-11",
            "TradeId":"3154-0",
            "Owner":"bnb13lkf02um8af2xzuxpnam3eqmwt57kqkp3hcvyp",
            "Side":2,
            "OrderType":2,
            "Price":1200000000,
            "Qty":1200000000,
            "LastExecutedPrice":1200000000,
            "LastExecutedQty":1200000000,
            "CumQty":1200000000,
            "Fee":"BNB:5760000",
            "OrderCreationTime":1560927931834863000,
            "TransactionTime":1560927932877738000,
            "TimeInForce":1,
            "CurrentExecutionType":0,
            "TxHash":"617565ECA6464E1B7435819A8154BCF5FC773FE1C5982A833DBEEDBE78E660C6",
            "SingleFee":""
         }
      ]
   },
   "Proposals":{
      "NumOfMsgs":0,
      "Proposals":null
   },
   "StakeUpdates":{
      "NumOfMsgs":0,
      "CompletedUnbondingDelegations":null
   }
}
```


