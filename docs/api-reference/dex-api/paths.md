
<a name="paths"></a>
## Paths

<a name="gettradestatisticsdtousingget"></a>
### Get Trade Statistics
```
GET /api/query/trades-statistics
```


#### Description
Gets statistics about market trades for a given pair symbol.


#### Parameters

|Type|Name|Description|Schema|
|---|---|---|---|
|**Query**|**symbol**  <br>*required*|symbol|string|


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|OK|[TradeStatisticsDTO](#tradestatisticsdto)|
|**400**|Bad Request|[Error](#error)|
|**404**|Not Found|No Content|
|**default**|Generic error response|[Error](#error)|


#### Produces

* `application/json`


#### Tags

* explorer


<a name="getaccount"></a>
### Get Account
```
GET /api/v1/account/{address}
```


#### Description
Gets account metadata for an address.


#### Parameters

|Type|Name|Description|Schema|
|---|---|---|---|
|**Path**|**address**  <br>*required*|The account address to query|string|


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Success|[Account](#account)|
|**400**|Bad Request|[Error](#error)|
|**404**|Not Found|No Content|
|**default**|Generic error response|[Error](#error)|


#### Produces

* `application/json`


#### Tags

* account
* node


<a name="getaccountsequence"></a>
### Get Account Sequence
```
GET /api/v1/account/{address}/sequence
```


#### Description
Gets an account sequence for an address.


#### Parameters

|Type|Name|Description|Schema|
|---|---|---|---|
|**Path**|**address**  <br>*required*|The account address to query|string|


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Success|[AccountSequence](#accountsequence)|
|**400**|Bad Request|[Error](#error)|
|**404**|Not Found|No Content|
|**default**|Generic error response|[Error](#error)|


#### Produces

* `application/json`


#### Tags

* account
* node


<a name="getblocktradesusingget"></a>
### Get Trades in Block
```
GET /api/v1/block-trades
```


#### Description
Gets historical trades per block. Sorted by block height in descending order.


#### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Query**|**address**  <br>*optional*|the sender address|string||
|**Query**|**end**  <br>*optional*|end time|integer (int64)||
|**Query**|**height**  <br>*optional*|block height|integer (int64)||
|**Query**|**limit**  <br>*optional*|default 50; max 100.|integer (int32)|`50`|
|**Query**|**offset**  <br>*optional*|start with 0; default 0.|integer (int32)|`0`|
|**Query**|**start**  <br>*optional*|start time|integer (int64)||


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|OK|[BlockTradePageVo](#blocktradepagevo)|
|**400**|Bad Request|[Error](#error)|
|**404**|Not Found|No Content|
|**default**|Generic error response|[Error](#error)|


#### Produces

* `application/json`


#### Tags

* trade


<a name="broadcasttx"></a>
### Post Transaction to Broadcast
```
POST /api/v1/broadcast
```


#### Description
Broadcasts a signed transaction. A single transaction must be sent in hex format in plain text.


#### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Query**|**sync**  <br>*optional*|Synchronous broadcast (wait for DeliverTx)|boolean|`"false"`|
|**Body**|**body**  <br>*required*||string (binary)||


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Success|< [Response 200](#broadcasttx-response-200) > array|
|**400**|Bad Request|[Error](#error)|
|**404**|Not Found|No Content|
|**default**|Generic error response|[Error](#error)|

<a name="broadcasttx-response-200"></a>
**Response 200**

|Name|Schema|
|---|---|
|**code**  <br>*optional*|integer (int32)|
|**data**  <br>*optional*|string|
|**hash**  <br>*optional*|string|
|**log**  <br>*optional*|string|
|**ok**  <br>*optional*|boolean|


#### Consumes

* `text/plain`


#### Produces

* `application/json`


#### Tags

* node


<a name="getcryptocurrencyrateusingget"></a>
### Get Currency Exchange Rate
```
GET /api/v1/crypto-currency
```


#### Description
Gets exchange rates for tokens on Binance DEX. The rate is updated every 30 seconds.


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|OK|< string, number (double) > map|
|**400**|Bad Request|[Error](#error)|
|**404**|Not Found|No Content|
|**default**|Generic error response|[Error](#error)|


#### Produces

* `application/json`


#### Tags

* market


<a name="getdepth"></a>
### Get Order Depth Data
```
GET /api/v1/depth
```


#### Description
Gets the order book depth data for a given pair symbol.


#### Parameters

|Type|Name|Description|Schema|
|---|---|---|---|
|**Query**|**limit**  <br>*optional*|symbol|integer (int32)|
|**Query**|**symbol**  <br>*optional*|symbol|string|


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Success|No Content|
|**400**|Bad Request|[Error](#error)|
|**404**|Not Found|No Content|
|**default**|Generic error response|[Error](#error)|


#### Produces

* `application/json`


#### Tags

* market


<a name="getfiatcurrencyrateusingget"></a>
### Get Fiat Exchange Rate
```
GET /api/v1/fiat-currency
```


#### Description
Gets exchange rates of fiat currency to crypto currency. The rate is updated every 5 minutes.


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|OK|< string, number (double) > map|
|**400**|Bad Request|[Error](#error)|
|**404**|Not Found|No Content|
|**default**|Generic error response|[Error](#error)|


#### Produces

* `application/json`


#### Tags

* market


<a name="getfrontierinfo"></a>
### Get Frontier Information
```
GET /api/v1/frontier-info
```


#### Description
Gets runtime information about the frontier services.


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Success|[Frontier info](#frontier-info)|

<a name="frontier-info"></a>
**Frontier info**

|Name|Description|Schema|
|---|---|---|
|**time**  <br>*optional*|In unix time (the number of seconds since the Unix Epoch)|integer (int64)|


#### Produces

* `application/json`


#### Tags

* frontier
* info


<a name="getcandlestickbarsusingget"></a>
### Get Candlestick Bars
```
GET /api/v1/klines
```


#### Description
Gets candlestick/kline bars for a symbol. Bars are uniquely identified by their open time.


#### Parameters

|Type|Name|Description|Schema|
|---|---|---|---|
|**Query**|**endTime**  <br>*optional*|end time|integer (int64)|
|**Query**|**interval**  <br>*required*|interval|enum (1m, 3m, 5m, 15m, 30m, 1h, 2h, 4h, 6h, 8h, 12h, 1d, 3d, 1w, 1M)|
|**Query**|**limit**  <br>*optional*|default 500; max 1000.|integer (int32)|
|**Query**|**startTime**  <br>*optional*|start time|integer (int64)|
|**Query**|**symbol**  <br>*required*|symbol|string|


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|OK|< object > array|


#### Produces

* `application/json`


#### Tags

* market


#### Example HTTP response

##### Response 200
```json
" [[\n1499040000000,      // Open time\n\"0.01634790\",       // Open\n\"0.80000000\",       // High\n\"0.01575800\",       // Low\n\"0.01577100\",       // Close\n\"148976.11427815\",  // Volume\n1499644799999,      // Close time\n\"2434.19055334\",    // Quote asset volume\n308                // Number of trades\n]] "
```


<a name="getpairs"></a>
### Get Market Pairs
```
GET /api/v1/markets
```


#### Description
Gets the list of market pairs that have been listed.


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Success|[Markets](#markets)|
|**400**|Bad Request|[Error](#error)|
|**404**|Not Found|No Content|
|**default**|Generic error response|[Error](#error)|


#### Produces

* `application/json`


#### Tags

* market


<a name="getnodeinfo"></a>
### Get Node Information
```
GET /api/v1/node-info
```


#### Description
Gets runtime information about the node.


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Success|object|


#### Produces

* `application/json`


#### Tags

* info
* node


<a name="getclosedordersusingget"></a>
### Get Closed Orders
```
GET /api/v1/orders/closed
```


#### Description
Gets closed (filled and cancelled) orders for a given address.


#### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Query**|**address**  <br>*required*|the sender address|string||
|**Query**|**end**  <br>*optional*|end time|integer (int64)||
|**Query**|**limit**  <br>*optional*|default 500; max 1000.|integer (int32)|`500`|
|**Query**|**offset**  <br>*optional*|start with 0; default 0.|integer (int32)|`0`|
|**Query**|**side**  <br>*optional*|order side|enum (BUY, SELL)||
|**Query**|**start**  <br>*optional*|start time|integer (int64)||
|**Query**|**status**  <br>*optional*|order status list|< string > array(multi)||
|**Query**|**symbol**  <br>*optional*|symbol|string||


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|OK|[OrderPageVo](#orderpagevo)|


#### Produces

* `application/json`


#### Tags

* order


<a name="getopenordersusingget"></a>
### Get Open Orders
```
GET /api/v1/orders/open
```


#### Description
Gets open orders for a given address.


#### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Query**|**address**  <br>*required*|the sender address|string||
|**Query**|**limit**  <br>*optional*|default 500; max 1000.|integer (int32)|`500`|
|**Query**|**offset**  <br>*optional*|start with 0; default 0.|integer (int32)|`0`|
|**Query**|**symbol**  <br>*optional*|symbol|string||


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|OK|[OrderPageVo](#orderpagevo)|
|**400**|Bad Request|[Error](#error)|
|**404**|Not Found|No Content|
|**default**|Generic error response|[Error](#error)|


#### Produces

* `application/json`


#### Tags

* order


<a name="getorderusingget"></a>
### Get Order
```
GET /api/v1/orders/{id}
```


#### Description
Gets metadata for an individual order.


#### Parameters

|Type|Name|Description|Schema|
|---|---|---|---|
|**Path**|**id**  <br>*required*|order id|string|


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|OK|[OrderVo](#ordervo)|
|**400**|Bad Request|[Error](#error)|
|**404**|Not Found|No Content|
|**default**|Generic error response|[Error](#error)|


#### Produces

* `application/json`


#### Tags

* order


<a name="getpeers"></a>
### Get Peers
```
GET /api/v1/peers
```


#### Description
Gets the list of network peers.


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Success|[Peers](#peers)|
|**400**|Bad Request|[Error](#error)|
|**404**|Not Found|No Content|
|**default**|Generic error response|[Error](#error)|


#### Produces

* `application/json`


#### Tags

* info
* node


<a name="get24hrpricestatisticsusingget"></a>
### Get Ticker
```
GET /api/v1/ticker/24hr
```


#### Description
Gets 24 hour price change statistics for a market pair symbol.


#### Parameters

|Type|Name|Description|Schema|
|---|---|---|---|
|**Query**|**symbol**  <br>*optional*|symbol|string|


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|OK|< [TickerStatisticsVo](#tickerstatisticsvo) > array|
|**400**|Bad Request|[Error](#error)|
|**404**|Not Found|No Content|
|**default**|Generic error response|[Error](#error)|


#### Produces

* `application/json`


#### Tags

* market


<a name="gettime"></a>
### Get Block Time
```
GET /api/v1/time
```


#### Description
Gets the latest block time and the current time according to the HTTP service.


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Success|[Times](#times)|
|**400**|Bad Request|[Error](#error)|
|**404**|Not Found|No Content|
|**default**|Generic error response|[Error](#error)|

<a name="times"></a>
**Times**

|Name|Schema|
|---|---|
|**ap_time**  <br>*optional*|string|
|**block_time**  <br>*optional*|string|


#### Produces

* `application/json`


#### Tags

* misc


<a name="gettokens"></a>
### Get Tokens
```
GET /api/v1/tokens
```


#### Description
Gets a list of tokens that have been issued.


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Success|[Tokens](#tokens)|
|**400**|Bad Request|[Error](#error)|
|**404**|Not Found|No Content|
|**default**|Generic error response|[Error](#error)|


#### Produces

* `application/json`


#### Tags

* tokens


<a name="gettradesusingget"></a>
### Get Trades
```
GET /api/v1/trades
```


#### Description
Gets a list of historical trades.


#### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Query**|**address**  <br>*optional*|the sender address|string||
|**Query**|**baseAsset**  <br>*optional*|base asset|string||
|**Query**|**buyerOrderId**  <br>*optional*|buyer order id|string||
|**Query**|**end**  <br>*optional*|end time|integer (int64)||
|**Query**|**height**  <br>*optional*|block height|integer (int64)||
|**Query**|**limit**  <br>*optional*|default 500; max 1000.|integer (int32)|`500`|
|**Query**|**offset**  <br>*optional*|start with 0; default 0.|integer (int32)|`0`|
|**Query**|**quoteAsset**  <br>*optional*|quote asset|string||
|**Query**|**sellerOrderId**  <br>*optional*|seller order id|string||
|**Query**|**side**  <br>*optional*|order side|enum (BUY, SELL)||
|**Query**|**start**  <br>*optional*|start time|integer (int64)||
|**Query**|**symbol**  <br>*optional*|symbol|string||


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|OK|[TradePageVo](#tradepagevo)|
|**400**|Bad Request|[Error](#error)|
|**404**|Not Found|No Content|
|**default**|Generic error response|[Error](#error)|


#### Produces

* `application/json`


#### Tags

* trade


<a name="txnsusingget"></a>
### Get Transactions
```
GET /api/v1/transactions
```


#### Description
Gets a list of transactions.


#### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Query**|**address**  <br>*optional*|address|string||
|**Query**|**blockHeight**  <br>*optional*|blockHeight|integer (int64)||
|**Query**|**endTime**  <br>*optional*|endTime|integer (int64)||
|**Query**|**limit**  <br>*optional*|limit|integer (int32)|`500`|
|**Query**|**offset**  <br>*optional*|offset|integer (int32)|`0`|
|**Query**|**side**  <br>*optional*|transaction side|enum (RECEIVE, SEND)||
|**Query**|**startTime**  <br>*optional*|startTime|integer (int64)||
|**Query**|**txAsset**  <br>*optional*|txAsset|string||
|**Query**|**txType**  <br>*optional*|transaction type|enum (NEW_ORDER, ISSUE_TOKEN, BURN_TOKEN, LIST_TOKEN, CANCEL_ORDER, FREEZE_TOKEN, UN_FREEZE_TOKEN, TRANSFER)||


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|OK|[TxPageVo](#txpagevo)|
|**400**|Bad Request|[Error](#error)|
|**404**|Not Found|No Content|
|**default**|Generic error response|[Error](#error)|


#### Produces

* `application/json`


#### Tags

* transaction


<a name="gettransaction"></a>
### Get Transaction
```
GET /api/v1/tx/{hash}
```


#### Description
Gets transaction metadata by transaction ID.


#### Parameters

|Type|Name|Description|Schema|
|---|---|---|---|
|**Path**|**hash**  <br>*required*|The transaction hash to query|string|


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Success|[Transaction](#transaction)|
|**400**|Bad Request|[Error](#error)|
|**404**|Not Found|No Content|
|**default**|Generic error response|[Error](#error)|


#### Produces

* `application/json`


#### Tags

* node
* tx


<a name="getvalidators"></a>
### Get Validators
```
GET /api/v1/validators
```


#### Description
Gets the list of consensus validators.


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Success|[Validators](#validators)|
|**400**|Bad Request|[Error](#error)|
|**404**|Not Found|No Content|
|**default**|Generic error response|[Error](#error)|


#### Produces

* `application/json`


#### Tags

* info
* node



