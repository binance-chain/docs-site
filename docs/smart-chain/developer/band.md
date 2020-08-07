# Binance Smart Chain Band Oracle Developer Docs

## Band Protocol Integration

Developers building on Binance Smart Chain can now leverage Band's decentralized oracle infrastructure. With Band's oracle, they now have access to various cryptocurrency price data to integrate into their applications.

## The Bridge Contract

### Bridge Architecture

Anyone looking to integrate Band's oracle data into their application can do so through Band's bridge contract. This contract is deployed on the Binance Smart Chain testnet at address `0xB911BbbF3Ef768B13b0e0257345b4756df5D4187`. The contract source code can also be found on the BandChain [repository](https://github.com/bandprotocol/bandchain/blob/master/bridges/evm/contracts/BridgeWithCache.sol).

The price data originates from [data requests](https://github.com/bandprotocol/bandchain/wiki/System-Overview#oracle-data-request) made on BandChain. The values are the median of the results retrieved by BandChain's validators from [CoinGecko](https://www.coingecko.com/api/documentations/v3), [CryptoCompare](https://min-api.cryptocompare.com/), [Binance](https://github.com/binance-exchange/binance-official-api-docs/blob/master/rest-api.md), and [Alpha Vantage](https://www.alphavantage.co/) APIs. The data request is then made by executing an price aggregator oracle script, the code of which can be examined on BandChain's [devnet](https://guanyu-devnet.cosmoscan.io/oracle-script/76).

Band's bridge contract then retrieves and stores the results of those requests onto the contract state.

### Data Available (Testnet)

The bridge contract stores the following price pairs, the values of which are updated every 5 minutes. The specific data that are available through the bridge contract, as well as the source(s) where the data was retrieved from, is as follow:

Cryptocurrency Prices ([CoinGecko](https://coingecko.com), [CryptoCompare](https://www.cryptocompare.com/), [Binance](https://binance.com), [Binance US](https://binance.us)):

- BTC/USD
- ETH/USD
- BNB/USD
- BUSD/USD
- BAND/USD

Commodity Prices ([Alpha Vantage](https://www.alphavantage.co/)):

- XAU/USD
- XAG/USD

Foreign Exchange Conversions Rates ([Alpha Vantage](https://www.alphavantage.co/)):

- EUR/USD
- CNY/USD
- JPY/USD
- GBP/USD
- KRW/USD

In addition to the actual price value, the following information are also available:

- the multiplier used to calculate the stored price value
- the timestamp of when the specific price request was resolved on BandChain

These parameters are intended to act as security parameters to help anyone using the data to verify that the data they are using is what they expect and, perhaps more importantly, actually valid.

### Bridge Contract Price Update Process

For the ease of development, the Band Foundation will be maintaining and updating the bridge contract with the latest price data. In the near future, we will be releasing guides on how developers can create similar contracts themselves to retrieve data from Band's oracle.

## Retrieving and Using the Price Data

We will now illustrate an example of a simple price database contract that uses data from Band's oracle. The code for the contract is shown below.

```javascript
pragma solidity 0.6.0;
pragma experimental ABIEncoderV2;

import "./Obi.sol";
import {IBridge} from "./IBridgeWithCache.sol";
import {ParamsDecoder, ResultDecoder} from "./Decoders.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";


contract SimplePriceDB {
    using SafeMath for uint256;
    using ResultDecoder for bytes;
    using ParamsDecoder for bytes;

    IBridge bridge;
    IBridge.RequestPacket req;

    uint256 public price;

    constructor(IBridge bridge_) public {
         bridge = bridge_;

        req.clientId = "bsc";
        req.oracleScriptId = 76;
        // {symbol:"BTC"}
        req.params = hex"00000003425443";
        req.askCount = 4;
        req.minCount = 4;
    }


    // getPrice fetches the latest BTC/USD price value from the bridge contract and saves it to state.
    function getPrice() public {
       (IBridge.ResponsePacket memory res,) = bridge.getLatestResponse(req);
        ResultDecoder.Result memory result = res.result.decodeResult();
        price = result.px;
    }
}
```

Let's break down the code into sections.

### Imports


```javascript
import "./Obi.sol";
import {IBridge} from "./IBridgeWithCache.sol";
import {ParamsDecoder, ResultDecoder} from "./Decoders.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
```

Aside from `SafeMath.sol`, the contract we will be writing requires three helper files specific to Band's oracle: `Obi.sol`, `Decoders.sol`, and `IBridgeWithCache.sol`.


#### `Obi.sol`

This contains a set of function to help serialized and deserialize binary data when interacting with the BandChain ecosystem. The full standard specificationcan be found on their [wiki](https://github.com/bandprotocol/bandchain/wiki/Oracle-Binary-Encoding-(OBI)) and the code on the BandChain [repository](https://github.com/bandprotocol/bandchain/blob/master/bridges/evm/contracts/obi/Obi.sol).

#### `Decoders.sol`

This is what we will use to work with data related to requests made on BandChain. This will help us in extracting the various information, such as the price value, we may need from the request response from Band's oracle. The file is available from the oracle script's [bridge code tab](https://guanyu-devnet.cosmoscan.io/oracle-script/76#bridge) on the devnet explorer.

#### `IBridgeWithCache.sol`

The interface file for Band's bridge contract.

### Contract

```javascript
contract SimplePriceDB {
    using SafeMath for uint256;
    using ResultDecoder for bytes;
    using ParamsDecoder for bytes;

    IBridge bridge;
    IBridge.RequestPacket req;

    uint256 public price;

    constructor(IBridge bridge_) public {
         bridge = bridge_;

        req.clientId = "bsc";
        req.oracleScriptId = 76;
        // {symbol:"BTC"}
        req.params = hex"00000003425443";
        req.askCount = 4;
        req.minCount = 4;
    }


    // getPrice fetches the latest BTC/USD price value from the bridge contract and saves it to state.
    function getPrice() public {
       (IBridge.ResponsePacket memory res,) = bridge.getLatestResponse(req);
        ResultDecoder.Result memory result = res.result.decodeResult();
        price = result.px;
    }
}
```

The contract itself can then be futher broken down into two parts: the constructor and the main `getPrice` function.

#### Contract Constructor

```javascript
constructor(IBridge bridge_) public {
     bridge = bridge_;

    req.clientId = "bsc";
    req.oracleScriptId = 76;
    // {symbol:"BTC"}
    req.params = hex"00000003425443";
    req.askCount = 4;
    req.minCount = 4;
}
```

The contract's constructor takes one argument, the address of the bridge contract. It then sets the various fields of the `req` `RequestPacket` variable. This `req` variable will be what we will use as the key to match and retrieve the price from the bridge contract. Specifically, in this case, we set `req` to have the following parameters.

- `clientId` (`"band_bsc"`): the unique identifier of this oracle request, as specified by the client
- `oracleScriptId` (`76`): The unique identifier number assigned to the oracle script when it was first registered on Bandchain.
- `params` (`hex"00000003425443"`): The data passed over to the oracle script for the script to use during its execution. In this case, it is hex representation of the OBI-encoded request struct`{"symbol":"BTC"}`
- `minCount` (`4`): The minimum number of validators necessary for the request to proceed to the execution phase
- `askCount` (`4`): The number of validators that are requested to respond to this request

The specific params for each of the available price pairs are:

| Pair     | Params                 |
|----------|------------------------|
| BTC/USD  | `hex"00000003425443"`  |
| ETH/USD  | `hex"00000003455448`   |
| BNB/USD  | `hex"00000003424e42`   |
| BUSD/USD | `hex"0000000442555344` |
| BAND/USD | `hex"0000000442414e44` |
| XAU/USD  | `hex"00000003584155`   |
| XAG/USD  | `hex"00000003584147`   |
| EUR/USD  | `hex"00000003455552`   |
| CNY/USD  | `hex"00000003434e59`   |
| JPY/USD  | `hex"000000034a5059`   |
| GBP/USD  | `hex"00000003474250`   |
| KRW/USD  | `hex"000000034b5257`   |

#### getPrice Function

```javascript
// getPrice fetches the latest BTC/USD price value from the bridge contract and saves it to state.
function getPrice() public {
   (IBridge.ResponsePacket memory res,) = bridge.getLatestResponse(req);
    ResultDecoder.Result memory result = res.result.decodeResult();
    price = result.px;
}
```

This is then the main function that we will use to fetch the price from Band's bridge contract and save it into our price database contract's state. It calls the bridge contract's `getLatestResponse` to retrieve the latest request response associated with a `BTC/USD` price request. It then uses `Decoders.sol`'s `decodeResult` method to parse that response into a struct. Finally, we save the price value from that response into the contract's `price` variable.