## Streams

### 1. Orders

Returns individual order updates.

Examples are written in JavaScript.

**Topic Name:** orders | Stream: /ws/userAddress

**Connection Example:**

```javascript
    // URL connection
    const accountAndOrders = new WebSocket("ws://testnet-dex.binance.org/api/ws/bnc1hp7cves62dzj8n4z8ckna0d3t6zd7z2zcj6gtq");

    // Or Subscribe method
    const conn = new WebSocket("ws://testnet-dex.binance.org/api");
    conn.onopen = function(evt) {
        conn.send(JSON.stringify({ method: "subscribe", topic: "orders", userAddress: "bnc1hp7cves62dzj8n4z8ckna0d3t6zd7z2zcj6gtq" }));
    }
```

**Received Payload:**

```javascript
[
  {
    "topic": "orders",
    "payload": {
        "e": "executionReport",        // Event type
        "E": 1499405658658,            // Event time
        "s": "ETH_BTC",                // Symbol
        "S": "BUY",                    // Side
        "o": "LIMIT",                  // Order type
        "f": "GTC",                    // Time in force
        "q": "1.00000000",             // Order quantity
        "p": "0.10264410",             // Order price
        "x": "NEW",                    // Current execution type
        "X": "NEW",                    // Current order status
        "i": 4293153,                  // Order ID
        "l": "0.00000000",             // Last executed quantity
        "z": "0.00000000",             // Cumulative filled quantity
        "L": "0.00000000",             // Last executed price
        "n": "10000BNB",               // Commission amount for all user trades within a given block. Fees will be displayed with each order but will be charged once.
                                       // Fee can be composed of a single symbol, ex: "10000BNB"
                                       // or multiple symbols if the available "BNB" balance is not enough to cover the whole fees, ex: "1.00000000BNB;0.00001000BTC;0.00050000ETH"
        "T": 1499405658657,            // Transaction time
        "t": "TRD1",                   // Trade ID
        "O": 1499405658657,            // Order creation time
        "Z": "0.00000000"              // Cumulative quote asset transacted quantity
    },
    {
        "topic": "orders",
        "payload": {
            "e": "executionReport",        // Event type
            "E": 1499405658658,            // Event time
            "s": "ETH_BNB",                // Symbol
            "S": "BUY",                    // Side
            "o": "LIMIT",                  // Order type
            "f": "GTC",                    // Time in force
            "q": "1.00000000",             // Order quantity
            "p": "0.10264410",             // Order price
            "x": "NEW",                    // Current execution type
            "X": "NEW",                    // Current order status
            "i": 4293154,                  // Order ID
            "l": "0.00000000",             // Last executed quantity
            "z": "0.00000000",             // Cumulative filled quantity
            "L": "0.00000000",             // Last executed price
            "n": "10000BNB",               // Commission amount for all user trades within a given block. Fees will be displayed with each order but will be charged once.
                                          // Fee can be composed of a single symbol, ex: "10000BNB"
                                          // or multiple symbols if the available "BNB" balance is not enough to cover the whole fees, ex: "1.00000000BNB;0.00001000BTC;0.00050000ETH"
            "T": 1499405658657,            // Transaction time
            "t": "TRD2",                   // Trade ID
            "O": 1499405658657,            // Order creation time
            "Z": "0.00000000"              // Cumulative quote asset transacted quantity
        }
      },
      ...
  }
]
```

### 2. Account

Return account updates.

**Topic Name:** accounts | Stream: /ws/userAddress

**Connection Example:**

```javascript
    // URL connection
    const accountAndOrders = new WebSocket("ws://testnet-dex.binance.org/api/ws/bnc1hp7cves62dzj8n4z8ckna0d3t6zd7z2zcj6gtq");

    // Or Subscribe method
    const conn = new WebSocket("ws://testnet-dex.binance.org/api");
    conn.onopen = function(evt) {
        conn.send(JSON.stringify({ method: "subscribe", topic: "accounts", userAddress: "bnc1hp7cves62dzj8n4z8ckna0d3t6zd7z2zcj6gtq" }));
    }
```

**Received Payload:**

```javascript
{
  "e": "outboundAccountInfo",   // Event type
  "E": 1499405658849,           // Event time
  "B": [                        // Balances array
    {
      "a": "LTC",               // Asset
      "f": "17366.18538083",    // Free amount
      "l": "0.00000000",        // Locked amount
      "r": "0.00000000"         // Frozen amount
    },
    {
      "a": "BTC",
      "f": "10537.85314051",
      "l": "2.19464093",
      "r": "0.00000000"
    },
    {
      "a": "ETH",
      "f": "17902.35190619",
      "l": "0.00000000",
      "r": "0.00000000"
    }
  ]
}
```

### 3. Trades

Returns individual trade updates.

**Topic Name:** trades | Stream: \<symbol\>@trades

**Connection Example:**

```javascript
    // URL connection
    const trades = new WebSocket("ws://testnet-dex.binance.org/api/ws/BNB_BTC@trades");

    // Or Subscribe method
    const conn = new WebSocket("ws://testnet-dex.binance.org/api");
    conn.onopen = function(evt) {
        conn.send(JSON.stringify({ method: "subscribe", topic: "trades", symbols: ["BNB_BTC"] }));
    }
```

**Received Payload:**

```javascript
[
  {
    "topic": "trades",
    "payload": {
        "e": "trade",     // Event type
        "E": 123456789,   // Event time
        "s": "BNB_BTC",    // Symbol
        "t": 12345,       // Trade ID
        "p": "0.001",     // Price
        "q": "100",       // Quantity
        "b": 88,          // Buyer order ID
        "a": 50,          // Seller order ID
        "T": 123456785,   // Trade time
    }
  },
  {
    "topic": "trades",
    "payload": {
        "e": "trade",     // Event type
        "E": 123456795,   // Event time
        "s": "BNB_BTC",    // Symbol
        "t": 12348,       // Trade ID
        "p": "0.001",     // Price
        "q": "100",       // Quantity
        "b": 88,          // Buyer order ID
        "a": 52,          // Seller order ID
        "T": 123456795,   // Trade time
    }
  },
  ...
]
```

### 4. Diff. Depth Stream

Order book price and quantity depth updates used to locally keep an order book.

**Topic Name:** marketDiff | Stream: \<symbol\>@marketDiff

**Connection Example:**

```javascript
    // URL connection
    const marketDiff = new WebSocket("ws://testnet-dex.binance.org/api/ws/BNB_BTC@marketDiff");

    // Or Subscribe method
    const conn = new WebSocket("ws://testnet-dex.binance.org/api");
    conn.onopen = function(evt) {
        conn.send(JSON.stringify({ method: "subscribe", topic: "marketDiff", symbols: ["BNB_BTC"] }));
    }
```

**Received Payload:**

```javascript
{
    "topic": "marketDiff",
    "payload": {
        "e": "depthUpdate",   // Event type
        "E": 123456789,       // Event time
        "s": "BNB_BTC",       // Symbol
        "b": [                // Bids to be updated
            [
            "0.0024",         // Price level to be updated
            "10"              // Quantity
            ]
        ],
        "a": [                // Asks to be updated
            [
            "0.0026",         // Price level to be updated
            "100"             // Quantity
            ]
        ]
    }
}
```

### 5. Book Depth Streams

Top 20 levels of bids and asks.

**Topic Name:** marketDepth | Stream: \<symbol\>@marketDepth

**Connection Example:**

```javascript
    // URL connection
    const marketDepth = new WebSocket("ws://testnet-dex.binance.org/api/ws/BNB_BTC@marketDepth");

    // Or Subscribe method
    const conn = new WebSocket("ws://testnet-dex.binance.org/api");
    conn.onopen = function(evt) {
        conn.send(JSON.stringify({ method: "subscribe", topic: "marketDepth", symbols: ["BNB_BTC"] }));
    }
```

**Received Payload:**

```javascript
{
    "topic": "marketDepth",
    "payload": {
        "lastUpdateId": 160,  // Last update ID
        "bids": [             // Bids to be updated
            [
            "0.0024",         // Price level to be updated
            "10"              // Quantity
            ]
        ],
        "asks": [             // Asks to be updated
            [
            "0.0026",         // Price level to be updated
            "100"             // Quantity
            ]
        ]
    }
}
```

### 6. Kline/Candlestick Streams

The kline/candlestick stream pushes updates to the current klines/candlestick every second.

**Kline/Candlestick chart intervals:**

m -> minutes; h -> hours; d -> days; w -> weeks; M -> months

* 1m
* 3m
* 5m
* 15m
* 30m
* 1h
* 2h
* 4h
* 6h
* 8h
* 12h
* 1d
* 3d
* 1w
* 1M

**Topic Name:** kline_\<interval\> | Stream: \<symbol\>@kline_\<interval\>

**Connection Example:**

```javascript
    // URL connection
    const kline = new WebSocket("ws://testnet-dex.binance.org/api/ws/BNB_BTC@kline_1h");

    // Or Subscribe method
    const conn = new WebSocket("ws://testnet-dex.binance.org/api");
    conn.onopen = function(evt) {
        conn.send(JSON.stringify({ method: "subscribe", topic: "kline_1h", symbols: ["BNB_BTC"] }));
    }
```

**Received Payload:**

```javascript
{
  "e": "kline",     // Event type
  "E": 123456789,   // Event time
  "s": "BNBBTC",    // Symbol
  "k": {
    "t": 123400000, // Kline start time
    "T": 123460000, // Kline close time
    "s": "BNBBTC",  // Symbol
    "i": "1m",      // Interval
    "f": 100,       // First trade ID
    "L": 200,       // Last trade ID
    "o": "0.0010",  // Open price
    "c": "0.0020",  // Close price
    "h": "0.0025",  // High price
    "l": "0.0015",  // Low price
    "v": "1000",    // Base asset volume
    "n": 100,       // Number of trades
    "x": false,     // Is this kline closed?
    "q": "1.0000",  // Quote asset volume
    "V": "500",     // Taker buy base asset volume
    "Q": "0.500",   // Taker buy quote asset volume
    "B": "123456"   // Ignore
  }
}
```

### 7. Individual Symbol Ticker Streams

24hr Ticker statistics for a single symbol are pushed every second.

**Topic Name:** ticker | Stream: \<symbol\>@ticker

**Connection Example:**

```javascript
    // URL connection
    const ticker = new WebSocket("ws://testnet-dex.binance.org/api/ws/BNB_BTC@ticker");

    // Or Subscribe method
    const conn = new WebSocket("ws://testnet-dex.binance.org/api");
    conn.onopen = function(evt) {
        conn.send(JSON.stringify({ method: "subscribe", topic: "ticker", symbols: ["BNB_BTC"] }));
    }
```

**Received Payload:**

```javascript
{
  "e": "24hrTicker",  // Event type
  "E": 123456789,     // Event time
  "s": "BNBBTC",      // Symbol
  "p": "0.0015",      // Price change
  "P": "250.00",      // Price change percent
  "w": "0.0018",      // Weighted average price
  "x": "0.0009",      // Previous day's close price
  "c": "0.0025",      // Current day's close price
  "Q": "10",          // Close trade's quantity
  "b": "0.0024",      // Best bid price
  "B": "10",          // Best bid quantity
  "a": "0.0026",      // Best ask price
  "A": "100",         // Best ask quantity
  "o": "0.0010",      // Open price
  "h": "0.0025",      // High price
  "l": "0.0010",      // Low price
  "v": "10000",       // Total traded base asset volume
  "q": "18",          // Total traded quote asset volume
  "O": 0,             // Statistics open time
  "C": 86400000,      // Statistics close time
  "F": 0,             // First trade ID
  "L": 18150,         // Last trade Id
  "n": 18151          // Total number of trades
}
```

### 8. All Symbols Ticker Streams

24hr Ticker statistics for a all symbols are pushed every second.

**Topic Name:** allTickers | Stream: $all@ticker

**Connection Example:**

```javascript
    // URL connection
    const allTickers = new WebSocket("ws://testnet-dex.binance.org/api/ws/$all@ticker");

    // Or Subscribe method
    const conn = new WebSocket("ws://testnet-dex.binance.org/api");
    conn.onopen = function(evt) {
        conn.send(JSON.stringify({ method: "subscribe", topic: "ticker", symbols: ["$all"] }));
    }
```

**Received Payload:**

```javascript
[
  {
    "e": "24hrTicker",  // Event type
    "E": 123456789,     // Event time
    "s": "BNBBTC",      // Symbol
    "p": "0.0015",      // Price change
    "P": "250.00",      // Price change percent
    "w": "0.0018",      // Weighted average price
    "x": "0.0009",      // Previous day's close price
    "c": "0.0025",      // Current day's close price
    "Q": "10",          // Close trade's quantity
    "b": "0.0024",      // Best bid price
    "B": "10",          // Best bid quantity
    "a": "0.0026",      // Best ask price
    "A": "100",         // Best ask quantity
    "o": "0.0010",      // Open price
    "h": "0.0025",      // High price
    "l": "0.0010",      // Low price
    "v": "10000",       // Total traded base asset volume
    "q": "18",          // Total traded quote asset volume
    "O": 0,             // Statistics open time
    "C": 86400000,      // Statistics close time
    "F": 0,             // First trade ID
    "L": 18150,         // Last trade Id
    "n": 18151          // Total number of trades
  },
  {
    ...
  }
]
```

### 9. Individual Symbol Mini Ticker Streams

A ticker for a single symbol is pushed every second.

**Topic Name:** miniTicker | Stream: \<symbol\>@miniTicker

**Connection Example:**

```javascript
    // URL connection
    const miniTicker = new WebSocket("ws://testnet-dex.binance.org/api/ws/BNB_BTC@miniTicker");

    // Or Subscribe method
    const conn = new WebSocket("ws://testnet-dex.binance.org/api");
    conn.onopen = function(evt) {
        conn.send(JSON.stringify({ method: "subscribe", topic: "miniTicker", symbols: ["BNB_BTC"] }));
    }
```

**Received Payload:**

```javascript
{
  "e": "24hrMiniTicker",  // Event type
  "E": 123456789,     // Event time
  "s": "BNBBTC",      // Symbol
  "c": "0.0025",      // Current day's close price
  "o": "0.0010",      // Open price
  "h": "0.0025",      // High price
  "l": "0.0010",      // Low price
  "v": "10000",       // Total traded base asset volume
  "q": "18",          // Total traded quote asset volume
}
```

### 10. All Symbols Mini Ticker Streams

Array of 24hr Mini Ticker statistics for a all symbols pushed every second.

**Topic Name:** allMiniTickers | Stream: $all@miniTicker

**Connection Example:**

```javascript
    // URL connection
    const miniTickers = new WebSocket("ws://testnet-dex.binance.org/api/ws/$all@miniTicker");

    // Or Subscribe method
    const conn = new WebSocket("ws://testnet-dex.binance.org/api");
    conn.onopen = function(evt) {
        conn.send(JSON.stringify({ method: "subscribe", topic: "miniTicker", symbols: ["$all"] }));
    }
```

**Received Payload:**

```javascript
[
  {
    "e": "24hrMiniTicker",  // Event type
    "E": 123456789,     // Event time
    "s": "BNBBTC",      // Symbol
    "c": "0.0025",      // Current day's close price
    "o": "0.0010",      // Open price
    "h": "0.0025",      // High price
    "l": "0.0010",      // Low price
    "v": "10000",       // Total traded base asset volume
    "q": "18",          // Total traded quote asset volume
  },
  {
    ...
  }
]
```

### 11. Blockheight

Streams the latest block height.

**Topic Name:** blockheight | Stream: $all@blockheight

**Connection Example:**

```javascript
    // URL connection
    const blockHeights = new WebSocket("ws://testnet-dex.binance.org/api/ws/$all@blockheight");

    // Or Subscribe method
    const conn = new WebSocket("ws://testnet-dex.binance.org/api");
    conn.onopen = function(evt) {
        conn.send(JSON.stringify({ method: "subscribe", topic: "blockheight", symbols: ["$all"] }));
    }
```

**Received Payload:**

```javascript
{
  "h": 123456789,     // Block height
}
```
