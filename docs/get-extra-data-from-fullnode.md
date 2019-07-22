# Get Extra Data From Your Full Node

This document is intended for developers who are interested in transactions, order books, account changes, fee charges in every block and would like to build their own downstream services of the full node.<br/>
Please refer to [Running Full Node](fullnode.md), if you still haven't deployed a full node.

## Publish Different Messages to Local Files

You can set the `publishLocal` option to `true` in `nodebinary/fullnode/{network}/node/app.toml`.<br/>
The full node will append the messages each block published to `{fullnode home}/marketdata/marketdata.json` (each line is a json object for a topic and height), and you can consume them in your own apps. The messages types are explained below. 

Note: only block messages after this option get turned on can be saved. This function won't make up messages for already saved blocks.

### 1. OrderUpdates
You can set  the `publishOrderUpdates` option to `true` in `nodebinary/fullnode/{network}/node/app.toml`.<br/>
Then, the full node will save all the trades that have been filled, orders that changed and proposals that been submitted.

* Example:

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
            "TxHash":"A120FAA19A3448119E7F32B986540B21A5927616C73F95ACD1626FB54A74A865"
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
            "TxHash":"A120FAA19A3448119E7F32B986540B21A5927616C73F95ACD1626FB54A74A865"
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
            "TxHash":"617565ECA6464E1B7435819A8154BCF5FC773FE1C5982A833DBEEDBE78E660C6"
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


### 2. AccountBalance

You can set the `publishAccountBalance` option to `true` in `nodebinary/fullnode/{network}/node/app.toml`.<br/>
Then, the full node will save all the changed accounts.

* Example

```
{
	Owner:    string,
	Fee:      string,
	Balances: []{
	    Asset:  string,
        Free:   int64,
        Frozen: int64,
        Locked: int64
	}

}
```

### 3. OrderBook

You can set the `publishOrderBook` option to `true` in `nodebinary/fullnode/{network}/node/app.toml`.<br/>
Then, the full node will save all order book changes.

* Example

```
{
    Height:    int64,
    Timestamp: int64,
    NumOfMsgs: int,
    Books:     []{
       Symbol: string,
       Buys:   []{
            Price:   int64,
            LastQty: int64
       },
       Sells:  []{
            Price:   int64,
            LastQty: int64
       }
    }
}
```

### 4. BlockFee

You can set the `publishBlockFee` option to `true` in `nodebinary/fullnode/{network}/node/app.toml`.<br/>
Then, the full node will save all the block fee charged.

* Example

```
{
    Height:     int64,
    Fee:        string,
    Validators: []string
}
```


### 5. Transfers
You can set the `publishTransfer` option to `true` in `nodebinary/fullnode/{network}/node/app.toml`.<br/>
Then, the full node will save all the transfer transactions.

* Example

```
{
	Height:    int64,
	Num:       int,
	Timestamp: int64,
	Transfers: []{
	    From: string,
        To:   []{
            Addr:  string,
            Coins: []{
                Denom:  string,
                Amount: int64
            }
        }
	}
}
```

## Publish Different Messages to Kafka
You can set the `publishKafka` option to `true` in `nodebinary/fullnode/{network}/node/app.toml`.<br/>
Then, the full node will save messages that you are interested into Kafka, and you can consume them in your own apps.<br/>
The message is encoded based on `Avro` serialization system.<br/>
Their schemas are shown below:<br/>

- **OrderUpdates**:
```
{
    "type": "record",
    "name": "ExecutionResults",
    "namespace": "org.binance.dex.model.avro",
    "fields": [
        { "name": "height", "type": "long" },
        { "name": "timestamp", "type": "long" },
        { "name": "numOfMsgs", "type": "int" },
        { "name": "trades", "type": ["null", {
            "type": "record",
            "name": "Trades",
            "namespace": "org.binance.dex.model.avro",
            "fields": [
                { "name": "numOfMsgs", "type": "int" },
                { "name": "trades", "type": {
                    "type": "array",
                    "items":
                        {
                            "type": "record",
                            "name": "Trade",
                            "namespace": "org.binance.dex.model.avro",
                            "fields": [
                                { "name": "symbol", "type": "string" },
                                { "name": "id", "type": "string" },
                                { "name": "price", "type": "long" },
                                { "name": "qty", "type": "long"	},
                                { "name": "sid", "type": "string" },
                                { "name": "bid", "type": "string" },
                                { "name": "sfee", "type": "string" },
                                { "name": "bfee", "type": "string" },
                                { "name": "saddr", "type": "string" },
                                { "name": "baddr", "type": "string" }
                            ]
                        }
                    }
                }
            ]
        }], "default": null },
        { "name": "orders", "type": ["null", {
            "type": "record",
            "name": "Orders",
            "namespace": "org.binance.dex.model.avro",
            "fields": [
                { "name": "numOfMsgs", "type": "int" },
                { "name": "orders", "type": {
                    "type": "array",
                    "items":
                    {
                        "type": "record",
                        "name": "Order",
                        "namespace": "org.binance.dex.model.avro",
                        "fields": [
                            { "name": "symbol", "type": "string" },
                            { "name": "status", "type": "string" },
                            { "name": "orderId", "type": "string" },
                            { "name": "tradeId", "type": "string" },
                            { "name": "owner", "type": "string" },
                            { "name": "side", "type": "int" },
                            { "name": "orderType", "type": "int" },
                            { "name": "price", "type": "long" },
                            { "name": "qty", "type": "long" },
                            { "name": "lastExecutedPrice", "type": "long" },
                            { "name": "lastExecutedQty", "type": "long" },
                            { "name": "cumQty", "type": "long" },
                            { "name": "fee", "type": "string" },
                            { "name": "orderCreationTime", "type": "long" },
                            { "name": "transactionTime", "type": "long" },
                            { "name": "timeInForce", "type": "int" },
                            { "name": "currentExecutionType", "type": "string" },
                            { "name": "txHash", "type": "string" }
                        ]
                    }
                   }
                }
            ]
        }], "default": null },
        { "name": "proposals", "type": ["null", {
            "type": "record",
            "name": "Proposals",
            "namespace": "org.binance.dex.model.avro",
            "fields": [
                { "name": "numOfMsgs", "type": "int" },
                { "name": "proposals", "type": {
                    "type": "array",
                    "items":
                    {
                        "type": "record",
                        "name": "Proposal",
                        "namespace": "org.binance.dex.model.avro",
                        "fields": [
                            { "name": "id", "type": "long" },
                            { "name": "status", "type": "string" }
                        ]
                    }
                   }
                }
            ]
        }], "default": null }
    ]
}
```

- **OrderBooksSchema**:
```
{
    "type": "record",
    "name": "Books",
    "namespace": "com.company",
    "fields": [
        { "name": "height", "type": "long" },
        { "name": "timestamp", "type": "long" },
        { "name": "numOfMsgs", "type": "int" },
        { "name": "books", "type": {
            "type": "array",
            "items":
                {
                    "type": "record",
                    "name": "OrderBookDelta",
                    "namespace": "com.company",
                    "fields": [
                        { "name": "symbol", "type": "string" },
                        { "name": "buys", "type": {
                            "type": "array",
                            "items": {
                                "type": "record",
                                "name": "PriceLevel",
                                "namespace": "com.company",
                                "fields": [
                                    { "name": "price", "type": "long" },
                                    { "name": "lastQty", "type": "long" }
                                ]
                            }
                        } },
                        { "name": "sells", "type": {
                            "type": "array",
                            "items": "com.company.PriceLevel"
                        } }
                    ]
                }
            }, "default": []
        }
    ]
}
```

- **AccountBalanceSchema**:
```
{
    "type": "record",
    "name": "Accounts",
    "namespace": "com.company",
    "fields": [
        { "name": "height", "type": "long" },
        { "name": "numOfMsgs", "type": "int" },
        { "name": "accounts", "type": {
            "type": "array",
            "items":
                {
                    "type": "record",
                    "name": "Account",
                    "namespace": "com.company",
                    "fields": [
                        { "name": "owner", "type": "string" },
                        { "name": "fee", "type": "string" },
                        { "name": "balances", "type": {
                                "type": "array",
                                "items": {
                                    "type": "record",
                                    "name": "AssetBalance",
                                    "namespace": "com.company",
                                    "fields": [
                                        { "name": "asset", "type": "string" },
                                        { "name": "free", "type": "long" },
                                        { "name": "frozen", "type": "long" },
                                        { "name": "locked", "type": "long" }
                                    ]
                                }
                            }
                        }
                    ]
                }
           }, "default": []
        }
    ]
}

```


- **BlockFeeSchema**:
```
{
    "type": "record",
    "name": "BlockFee",
    "namespace": "com.company",
    "fields": [
        { "name": "height", "type": "long"},
        { "name": "fee", "type": "string"},
        { "name": "validators", "type": { "type": "array", "items": "string" }}
    ]
}
```

- **TransfersSchema**:
```
{
    "type": "record",
    "name": "Transfers",
    "namespace": "com.company",
    "fields": [
        { "name": "height", "type": "long"},
        { "name": "num", "type": "int" },
        { "name": "timestamp", "type": "long" },
        { "name": "transfers",
          "type": {
            "type": "array",
            "items": {
                "type": "record",
                "name": "Transfer",
                "namespace": "com.company",
                "fields": [
                    { "name": "from", "type": "string"},
                    { "name": "to",
                        "type": {
                            "type": "array",
                            "items": {
                                "type": "record",
                                "name": "Receiver",
                                "namespace": "com.company",
                                "fields": [
                                    { "name": "addr", "type": "string" },
                                    { "name": "coins",
                                        "type": {
                                            "type": "array",
                                            "items": {
                                                "type": "record",
                                                "name": "Coin",
                                                "namespace": "com.company",
                                                "fields": [
                                                    { "name": "denom", "type": "string" },
                                                    { "name": "amount", "type": "long" }
                                                ]
                                            }
                                        }
                                    }
                                ]
                            }
                        }
                    }
                ]
            }
          }
        }
    ]
}
```