# Get Extra Data From Your Full Node

This document is for developer who is very interested in transactions in every block, or order book, or account changes or block fee charge and would like to build his own downstream services of the full node. Please refer to [run a full node](fullnode.md), if you still haven't deploy a full node.

## Publish Different Messages to Local Files

You can set  the  `publishLocal` option to `true` in `nodebinary/fullnode/{network}/node/app.toml`.  Then, the full node will save the messages that you are interested under `{fullnode home}`/marketdata/marketdata.json, and you can consume them in your own apps. The messages types are explained below.

### 1. OrderUpdates
You can set  the  `publishOrderUpdates` option to `true` in `nodebinary/fullnode/{network}/node/app.toml`.  Then, the full node will save all the trades that been filled, orders that changed and proposals that been submitted in this blocks.


* Example:
```
{
	Height:    int64,
	Timestamp: int64, // milli seconds since Epoch
	NumOfMsgs: int,   // number of individual messages we published, consumer can verify messages they received against this field to make sure they does not miss messages
	Trades: {
	    NumOfMsgs: int,
        Trades:    []{
            Id:     string,
        	Symbol: string,
        	Price:  int64,
        	Qty:    int64,
        	Sid:    string,
        	Bid:    string,
        	Sfee:   string,
        	Bfee:   string,
        	SAddr:  string, // string representation of AccAddress
        	BAddr:  string // string representation of AccAddress
        },
	},
	Orders: {
	    NumOfMsgs: int,
        Orders:    []{
            	Symbol:               string,
            	Status:               uint8,
            	OrderId:              string,
            	TradeId:              string,
            	Owner:                string,
            	Side:                 int8,
            	OrderType:            int8,
            	Price:                int64,
            	Qty:                  int64,
            	LastExecutedPrice:    int64,
            	LastExecutedQty:      int64,
            	CumQty:               int64,
            	Fee:                  string,
            	OrderCreationTime:    int64,
            	TransactionTime:      int64,
            	TimeInForce:          int8,
            	CurrentExecutionType: uint8,
            	TxHash:               string
        }
	},
	Proposals: {
	    NumOfMsgs: int,
        Proposals: []{
            Id:     int64,
            Status: uint8
        }
	}
}

```


### 2. AccountBalance

You can set  the  `publishAccountBalance` option to `true` in `nodebinary/fullnode/{network}/node/app.toml`.  Then, the full node will save all the changed accounts after this blocks.

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
### 3. OrderbBook

You can set  the  `publishOrderBook` option to `true` in `nodebinary/fullnode/{network}/node/app.toml`.  Then, the full node will save all the  the order book changes after this block ends.
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

You can set  the  `publishBlockFee` option to `true` in `nodebinary/fullnode/{network}/node/app.toml`.  Then, the full node will save all thethe block fee charged in this block.
* Example
```
{
    	Height:     int64,
    	Fee:        string,
    	Validators: []string
}
```


### 5. Transfers
You can set  the  `publishTransfer` option to `true` in `nodebinary/fullnode/{network}/node/app.toml`.  Then, the full node will save all the transfer transactions in this block.

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



## Publish  Different Messages to Kafka
You can set  the  `publishKafka` option to `true` in `nodebinary/fullnode/{network}/node/app.toml`.  Then, the full node will save the messages that you are interested to Kafka, and you can consume them in your own apps. The message is encoded based on `Avro` serialization system. Their schemas are shown as below:

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