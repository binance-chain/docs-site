## WebSocket Connections

The DEX exposes several data streams over standard WebSocket connections, which can be consumed by modern web browsers and server-side WebSocket libraries.

- The base endpoint is: **wss://testnet-dex.binance.org/api/**.
- Each connection can consume a single stream or multiple streams may be multiplexed through one connection for more complex apps.
- A single connection to **https://testnet-dex.binance.org/api/** is only valid for 24 hours, so expect to be disconnected at around the 24 hour mark. Your app should handle this with reconnection logic.
- All symbols in stream names are lowercase.

Stream names may be provided in the URL **or** there is a mechanism to `subscribe` to consume streams on demand through one connection.
Examples for each of these methods are provided below in JavaScript:

### Method 1: Connect with stream names in the URL

Using this method, stream names are specified in the URLs used to connect to the data streams:

- Single streams may be accessed at **/ws/\<streamName\>**
- Combined streams may be accessed at **/stream?streams=\<streamName1\>/\<streamName2\>/\<streamName3\>** (etc.)

**Example:** Various methods of connecting to streams where stream names are provided in URLs:

```javascript
  // for personal streams, ex: Account & Orders
  const accountAndOrdersFeeds = new WebSocket("ws://testnet-dex.binance.org/api/ws/<USER_ADDRESS>");

  // for single streams
  const tradesFeeds = new WebSocket("ws://testnet-dex.binance.org/api/ws/<symbol>@trades");
  const marketFeeds = new WebSocket("ws://testnet-dex.binance.org/api/ws/<symbol>@marketDiff");
  const deltaFeeds = new WebSocket("ws://testnet-dex.binance.org/api/ws/<symbol>@marketDepth");
  ... etc

  // for all symbols
  const allTickers = new WebSocket("ws://testnet-dex.binance.org/api/ws/$all@ticker");
  const allMiniTickers = new WebSocket("ws://testnet-dex.binance.org/api/ws/$all@miniTicker");
  const blockHeight = new WebSocket("ws://testnet-dex.binance.org/api/ws/$all@blockheight");

  // for combined streams, can combined a mixed symbols and streams
  const combinedFeeds = new WebSocket("ws://testnet-dex.binance.org/api/stream?streams=<symbol>@trades/<symbol>@marketDepth/<symbol>@marketDiff");
```

### Method 2: Subscribe to streams on demand

Using this method, streams are be consumed via subscribe and unsubscribe commands, sent through a single WebSocket connection.

```javascript
    const conn = new WebSocket("ws://testnet-dex.binance.org/api");
    conn.onopen = function(evt) {
        // send Subscribe/Unsubscribe messages here (see below)
    }
    conn.onmessage = function(evt) {
        console.info('received data', evt.data);
    };
    conn.onerror = function(evt) {
        console.error('an error occurred', evt.data);
    };
```

After connecting successfully, a user can subscribe/unsubscribe to different topics.

#### Examples

**Example:** To subscribe to orders events and market depth updates, a user needs to send socket messages with the `subscribe` payloads as below:

```javascript
    const conn = new WebSocket("ws://testnet-dex.binance.org/api");
    conn.onopen = function(evt) {
        // for private topics such as accounts & orders, a `userAddress` is required
        conn.send(JSON.stringify({ method: "subscribe", topic: "orders", userAddress: "bnc1hp7cves62dzj8n4z8ckna0d3t6zd7z2zcj6gtq" }));

        // for data topics such as marketDepth, marketDelta, trades and ticker;
        // a list of symbols is required. Same message can be used to append new topic and/or symbols
        conn.send(JSON.stringify({ method: "subscribe", topic: "marketDepth", symbols: ["BNB_BTC","BNB_ETH"] }));
    }
```

**Example:** To unsubscribe from orders events, a user needs to send socket message with the payloads as below:

```javascript
    // unsubscribe from topic
    conn.send(JSON.stringify({ method: "unsubscribe", topic: "orders" }));

    // unsubscribe from individual symbols
    conn.send(JSON.stringify({ method: "unsubscribe", topic: "marketDepth", symbols: ["BNB_BTC"] }));
```

**Example:** To extend connection life, a user needs to send a message with a payload using the `keepAlive` method:

```javascript
    // This will extend the connection time to another 60 minutes
    // It's good to send this message every 30 minutes to maintain the connection life
    conn.send(JSON.stringify({ method: "keepAlive" }));
```

**Example:** To close a connection, a user needs to send socket message with the payload as below:

```javascript
    // Connections will auto close after 60 minutes by default if no "keepAlive" messages received
    // Connections with no subscriptions will be closed, regardless the keepAlive messages.
    conn.send(JSON.stringify({ method: "close" }));
```
