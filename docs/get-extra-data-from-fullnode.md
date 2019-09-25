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
{
  "Height": 36384232,
  "Timestamp": 1569196830136718300,
  "NumOfMsgs": 10,
  "Trades": {
    "NumOfMsgs": 2,
    "Trades": [
      {
        "Id": "36384232-0",
        "Symbol": "DEFI-FA5_BNB",
        "Price": 345282,
        "Qty": 23200000000,
        "Sid": "5F511BE6120CE2F92877F3A1E92D408CE56A5CCC-62632",
        "Bid": "4C28D006CF8061E05EEE50D17D8B2375CE09E7EC-71967",
        "Sfee": "BNB:32042",
        "Bfee": "BNB:32042",
        "SSrc": 0,
        "BSrc": 0,
        "SSingleFee": "BNB:32042",
        "BSingleFee": "BNB:32042",
        "TickType": 5,
        "SAddr": "bnb1tag3hesjpn30j2rh7ws7jt2q3njk5hxvsx023c",
        "BAddr": "bnb1fs5dqpk0sps7qhhw2rghmzerwh8qnelv7tyat8"
      },
      {
        "Id": "36384232-1",
        "Symbol": "EQL-586_BNB",
        "Price": 4798,
        "Qty": 110000000000,
        "Sid": "610BFE81695EFD89B19D27D1E8C17D57C0239C66-6367",
        "Bid": "B3CEA961E95C4F104A791F6C33DB83458577BA76-5471",
        "Sfee": "BNB:2111",
        "Bfee": "BNB:2111",
        "SSrc": 0,
        "BSrc": 0,
        "SSingleFee": "BNB:2111",
        "BSingleFee": "BNB:2111",
        "TickType": 2,
        "SAddr": "bnb1vy9laqtftm7cnvvaylg73sta2lqz88rxs72mx7",
        "BAddr": "bnb1k082jc0ft383qjnerakr8kurgkzh0wnk8gulnj"
      }
    ]
  },
  "Orders": {
    "NumOfMsgs": 8,
    "Orders": [
      {
        "Symbol": "DEFI-FA5_BNB",
        "Status": 0,
        "OrderId": "37D9383E6AD9AFEF6C5D8066ABA3ACA8C75D9F39-1724193",
        "TradeId": "",
        "Owner": "bnb1xlvns0n2mxh77mzaspn2hgav4rr4m8eerfju38",
        "Side": 1,
        "OrderType": 2,
        "Price": 344271,
        "Qty": 89600000000,
        "LastExecutedPrice": 0,
        "LastExecutedQty": 0,
        "CumQty": 0,
        "Fee": "",
        "OrderCreationTime": 1569196830136718300,
        "TransactionTime": 1569196830136718300,
        "TimeInForce": 1,
        "CurrentExecutionType": 0,
        "TxHash": "D74A96022A2F090D7D739C1C6716481A215E0F7F10C430C28290758E9DC4EF73",
        "SingleFee": ""
      },
      {
        "Symbol": "EQL-586_BNB",
        "Status": 0,
        "OrderId": "B3CEA961E95C4F104A791F6C33DB83458577BA76-5471",
        "TradeId": "",
        "Owner": "bnb1k082jc0ft383qjnerakr8kurgkzh0wnk8gulnj",
        "Side": 1,
        "OrderType": 2,
        "Price": 4798,
        "Qty": 110000000000,
        "LastExecutedPrice": 0,
        "LastExecutedQty": 0,
        "CumQty": 110000000000,
        "Fee": "",
        "OrderCreationTime": 1569196830136718300,
        "TransactionTime": 1569196830136718300,
        "TimeInForce": 1,
        "CurrentExecutionType": 0,
        "TxHash": "792BA5F932813F9C006075EAA090D82305AD049DDC570271FA8515339A874E97",
        "SingleFee": ""
      },
      {
        "Symbol": "DEFI-FA5_BNB",
        "Status": 0,
        "OrderId": "4C28D006CF8061E05EEE50D17D8B2375CE09E7EC-71967",
        "TradeId": "",
        "Owner": "bnb1fs5dqpk0sps7qhhw2rghmzerwh8qnelv7tyat8",
        "Side": 1,
        "OrderType": 2,
        "Price": 345283,
        "Qty": 23200000000,
        "LastExecutedPrice": 0,
        "LastExecutedQty": 0,
        "CumQty": 23200000000,
        "Fee": "",
        "OrderCreationTime": 1569196830136718300,
        "TransactionTime": 1569196830136718300,
        "TimeInForce": 1,
        "CurrentExecutionType": 0,
        "TxHash": "574CB6DAF26C5D1A465A8D86760FFDFF3DA5946F9C02EB5B89051A8120844523",
        "SingleFee": ""
      },
      {
        "Symbol": "DEFI-FA5_BNB",
        "Status": 0,
        "OrderId": "5F511BE6120CE2F92877F3A1E92D408CE56A5CCC-62632",
        "TradeId": "",
        "Owner": "bnb1tag3hesjpn30j2rh7ws7jt2q3njk5hxvsx023c",
        "Side": 2,
        "OrderType": 2,
        "Price": 345282,
        "Qty": 23200000000,
        "LastExecutedPrice": 0,
        "LastExecutedQty": 0,
        "CumQty": 23200000000,
        "Fee": "",
        "OrderCreationTime": 1569196830136718300,
        "TransactionTime": 1569196830136718300,
        "TimeInForce": 1,
        "CurrentExecutionType": 0,
        "TxHash": "9D8EF7CEAE5D2CDC4026F6306296D57764BB80099B3A65865971D8D71399B6EA",
        "SingleFee": ""
      },
      {
        "Symbol": "EQL-586_BNB",
        "Status": 5,
        "OrderId": "610BFE81695EFD89B19D27D1E8C17D57C0239C66-6367",
        "TradeId": "36384232-1",
        "Owner": "bnb1vy9laqtftm7cnvvaylg73sta2lqz88rxs72mx7",
        "Side": 2,
        "OrderType": 2,
        "Price": 4798,
        "Qty": 230000000000,
        "LastExecutedPrice": 4798,
        "LastExecutedQty": 110000000000,
        "CumQty": 110000000000,
        "Fee": "BNB:2111",
        "OrderCreationTime": 1569196786802324000,
        "TransactionTime": 1569196830136718300,
        "TimeInForce": 1,
        "CurrentExecutionType": 0,
        "TxHash": "EDF132EBDA03382D2BFF7EF58CDE574D4E3FB9622BD8BCF12BA6ABECD692BA5C",
        "SingleFee": "BNB:2111"
      },
      {
        "Symbol": "DEFI-FA5_BNB",
        "Status": 6,
        "OrderId": "4C28D006CF8061E05EEE50D17D8B2375CE09E7EC-71967",
        "TradeId": "36384232-0",
        "Owner": "bnb1fs5dqpk0sps7qhhw2rghmzerwh8qnelv7tyat8",
        "Side": 1,
        "OrderType": 2,
        "Price": 345283,
        "Qty": 23200000000,
        "LastExecutedPrice": 345282,
        "LastExecutedQty": 23200000000,
        "CumQty": 23200000000,
        "Fee": "BNB:32042",
        "OrderCreationTime": 1569196830136718300,
        "TransactionTime": 1569196830136718300,
        "TimeInForce": 1,
        "CurrentExecutionType": 0,
        "TxHash": "574CB6DAF26C5D1A465A8D86760FFDFF3DA5946F9C02EB5B89051A8120844523",
        "SingleFee": "BNB:32042"
      },
      {
        "Symbol": "DEFI-FA5_BNB",
        "Status": 6,
        "OrderId": "5F511BE6120CE2F92877F3A1E92D408CE56A5CCC-62632",
        "TradeId": "36384232-0",
        "Owner": "bnb1tag3hesjpn30j2rh7ws7jt2q3njk5hxvsx023c",
        "Side": 2,
        "OrderType": 2,
        "Price": 345282,
        "Qty": 23200000000,
        "LastExecutedPrice": 345282,
        "LastExecutedQty": 23200000000,
        "CumQty": 23200000000,
        "Fee": "BNB:32042",
        "OrderCreationTime": 1569196830136718300,
        "TransactionTime": 1569196830136718300,
        "TimeInForce": 1,
        "CurrentExecutionType": 0,
        "TxHash": "9D8EF7CEAE5D2CDC4026F6306296D57764BB80099B3A65865971D8D71399B6EA",
        "SingleFee": "BNB:32042"
      },
      {
        "Symbol": "EQL-586_BNB",
        "Status": 6,
        "OrderId": "B3CEA961E95C4F104A791F6C33DB83458577BA76-5471",
        "TradeId": "36384232-1",
        "Owner": "bnb1k082jc0ft383qjnerakr8kurgkzh0wnk8gulnj",
        "Side": 1,
        "OrderType": 2,
        "Price": 4798,
        "Qty": 110000000000,
        "LastExecutedPrice": 4798,
        "LastExecutedQty": 110000000000,
        "CumQty": 110000000000,
        "Fee": "BNB:2111",
        "OrderCreationTime": 1569196830136718300,
        "TransactionTime": 1569196830136718300,
        "TimeInForce": 1,
        "CurrentExecutionType": 0,
        "TxHash": "792BA5F932813F9C006075EAA090D82305AD049DDC570271FA8515339A874E97",
        "SingleFee": "BNB:2111"
      }
    ]
  },
  "Proposals": {
    "NumOfMsgs": 0,
    "Proposals": null
  },
  "StakeUpdates": {
    "NumOfMsgs": 0,
    "CompletedUnbondingDelegations": null
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
        TxHash: string,
        Memo: string,
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
                                { "name": "qty", "type": "long" },
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
        }], "default": null },
        { "name": "stakeUpdates", "type": ["null", {
            "type": "record",
            "name": "StakeUpdates",
            "namespace": "org.binance.dex.model.avro",
            "fields": [
                { "name": "numOfMsgs", "type": "int" },
                { "name": "completedUnbondingDelegations", "type": {
                    "type": "array",
                    "items":
                    {
                        "type": "record",
                        "name": "CompletedUnbondingDelegation",
                        "namespace": "org.binance.dex.model.avro",
                        "fields": [
                            { "name": "validator", "type": "string" },
                            { "name": "delegator", "type": "string" },
                            { "name": "amount", "type": {
                                    "type": "record",
                                    "name": "Coin",
                                    "namespace": "org.binance.dex.model.avro",
                                    "fields": [
                                        { "name": "denom", "type": "string" },
                                        { "name": "amount", "type": "long" }
                                    ]
                                }
                            }
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
                    { "name": "txhash", "type": "string" },
                    { "name": "from", "type": "string" },
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