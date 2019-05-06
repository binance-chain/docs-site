# Binance Chain Transaction Encoding Specification

Binance Chain transactions are protocol-based data types and can be only submit in a compatible encoding frame.

The fundamental encoding logic is from [Tendermint Amino](https://github.com/tendermint/go-amino), which derives from and is "largely compatible with" Google protocol-buffer's Proto3. 

However the client sides only need to stick to the below specifications for the most frequently used transactions.

## Encoding Output

Binance Chain (Amino) encoding logic may encode a data structure into two output formats: Binary and JSON.

### JSON Marshal
Amino supports JSON encoding natively, which is the same as other usual json marshaler. Except that it can add one more `type` info for registered type, as below.

```json
{
  "type": "<amino type name>",
  "value": <JSON>
}

```
### Binary Marshal

> **[Please note the below binary encoding logic is subjected to future change, from time to time. Please watch out for the community news](resources.md).**

Binary encoding is a variant of Google protocol buffer. The bytes are layed out in the below sequence:

1. a [varint](https://developers.google.com/protocol-buffers/docs/encoding#varints) encoded integer - it contains the length of the encoded bytes for the object, which is showed as `SIZE-OF-ENCODED` in the below structs. Please note it contains the length of encoded bytes and also the type prefix (below), but not itself, e.g. if the encoded msg is 20 bytes, then the length would be 20+4 = 24, while 4 is the type prefix bytes.
2. an object type prefix of 4-8 bytes - For different type of objects, there would be different type prefixes, and they are showed as in the below specific objects (data structures).
3. a binary encoded object - the encoding is mostly the same as protocol buffer encoding mechanism, except the embedded fields of complex type:
    - to encode data field of some specific types, an object type prefix for the field would be added ahead of the real encoding.
4. repeated (array) Encoding - it is the same as google protocol buffer, while encoding of the object/struct may contain the type prefix as showed below.

## Binance Chain Transaction Encoding

Below are the data types that should be sent to Binance Chain as requests, and their encoding layout. To simply the presentation, here we use a variant of [Google protocol buffer proto3](https://developers.google.com/protocol-buffers/docs/proto3) language to illustrate how the data fields are organized. Except the all-capitalized fields, the other fields should use the default `proto3` encoding logic.


### Standard Transaction

Transactions are each wrapped in the below "Standard Transaction": structure:

```go

// please note the field name is the JSON name.
message StdTx {
  uint64 SIZE-OF-ENCODED // varint encoded length of the structure after encoding, please note this includes both the below type prefix (4 bytes) and the all encoding bytes
  0xF0625DEE   // hardcoded, object type prefix in 4 bytes
  repeated Msg msgs = 1 // array of size 1, containing the transaction message, which are one of the transaction type below. please check the above "Array Encoding"
  repeated StdSignature signatures = 2 // array of size 1, containing the standard signature structure of the transaction sender
  string memo = 3 // a short sentence of remark for the transaction. Please only `Transfer` transaction allows 'memo' input, and other transactions with non-empty `Memo` would be rejected.
  int64 source = 4 // an identifier for tools triggerring this transaction, set to zero if unwilling to disclose.
  bytes data = 5 //byte array, reserved for future use
}
```

### Canonical Bytes for Signing

A transaction signature is **not** formed from the Amino-encoded transaction bytes themselves. Rather, a canonical represenation of the transaction is generated in JSON format for signing.

This would allow for clients to sign a transaction off-chain on, for example, a hardware HSM device like a Ledger, or within a micro-service in an algorithmic trading system. Such an external system would not have to understand Amino encoding to be able to approve of the transaction's content and produce the signed JSON string.

The canonical bytes for signing are generated from the [StdSignBytes](https://github.com/binance-chain/bnc-cosmos-sdk/blob/50675b8015ab0dbac91a926a2df746174dbb33f7/x/auth/stdtx.go#L123) method. It produces a JSON string similar to the following (formatted for clarity):

```json
{
   "sequence" : "64",
   "account_number" : "12",
   "data" : null,
   "chain_id" : "chain-bnb",
   "memo" : "smiley",
   "msgs" : [
      {
         "inputs" : [
            {
               "coins" : [
                  {
                     "denom" : "BNB",
                     "amount" : "200000000"
                  }
               ],
               "address" : "bnc1hgm0p7khfk85zpz5v0j8wnej3a90w7098fpxyh"
            }
         ],
         "outputs" : [
            {
               "address" : "bnc1cku54wwn66w2rkgs3h6v5zxrwtzyew8chcl720",
               "coins" : [
                  {
                     "denom" : "BNB",
                     "amount" : "200000000"
                  }
               ]
            }
         ]
      }
   ],
   "source" : "1"
}
```

This JSON string, **with all whitespace and keys sorted in alphabetical order**, is signed with the private key of the sender. This signature is then attached to the `StdTx` structure described in the above section. Please note that the transaction broadcasted to the blockchain is not JSON - the JSON is merely used as a canonical representation to generate the signature.

The next section describes how the generated signature is attached to a transaction.

### Standard Signature

The sender's signature is stored in the `Standard Transaction` data via a `Standard Signature`, as below. This structure is included in the `StdTx` (see above).

Please note that `StdSignature` itself doesn't have type prefix, while the `PubKey` has.

```go
message StdSignature {
  uint64 SIZE-OF-ENCODED // varint encoded length of the structure after encoding
  // please note there is no type prefix for StdSignature
  message PubKey {
    0xEB5AE987 // hardcoded, object type prefix in 4 bytes
    uint64 SIZE-OF-ENCODED // varint encoded length of the bytes below
    bytes // no name or field id, just encode the bytes
  }
  PubKey pub_key = 1 // public key bytes of the signer address
  bytes signature = 2 // signature bytes, please check chain access section for signature generation
  int64 account_number = 3 // another identifier of signer, which can be read from chain by account REST API or RPC
  int64 sequence = 4 // sequence number for the next transaction of the client, which can be read fro chain by account REST API or RPC. please check chain acces section for details.
}

```

### Message Types
Messages represent the individual operations possible on Binance Chain, and these can be inserted into `StdTx.msgs` field. These are otherwise known as "transaction types", and these terms are used interchangably in this document and in our technical documentation. So far every `StdTx` transaction "container" can only contain one "message".

#### Transfer
Transfer is the transaction for transfering funds to different addresses.

```go
// please note the field name is the JSON name.
message Send {
  0x2A2C87FA   // hardcoded, object type prefix in 4 bytes
  message Token {
    string denom = 1
    int64 amount = 2 
  }
  message Input {
    bytes address = 1
    repeated Token coins = 2    
  }
  message Output {
    bytes address = 1
    repeated Token coins = 2    
  }
  repeated Input inputs = 1
  repeated Output outputs = 2
}
```

#### NewOrder
NewOrder transaction would create a new order to buy and sell tokens on Binance DEX.

```go
// please note the field name is the JSON name.
message NewOrder {
  0xCE6DC043   // hardcoded, object type prefix in 4 bytes
  bytes sender = 1 // order originating address
  string id = 2 // order id, this is much, please check the details below Order ID section.
  string symbol = 3 // symbol for trading pair in full name of the tokens
  int64 ordertype = 4 // only accept 2 for now, meaning limit order
  int64  side = 5 // 1 for buy and 2 fory sell
  int64 price = 6 // price of the order, which is the real price multiplied by 1e8 (10^8) and rounded to integer
  int64 quantity = 7 // quantity of the order, which is the real price multiplied by 1e8 (10^8) and rounded to integer
  int64 timeinforce = 8 // 1 for Good Till Expire(GTE) order and 3 for Immediate Or Cancel (IOC)
```

##### Order ID
Order ID is unique across the world. It is generated by sender and acknowledged by Binance DEX. The current implementation is composed 3 parts:

1. Sender address in HEX format, without human-readable prefix
2. A dash sign: `-` 
3. Sequence number

E.g. `40C2979694BBC961023D1D27BE6FC4D21A9FEBE6-5`

#### Cancel
Cancel transactions cancel the outstanding (unfilled) orders from the Binance DEX. After cancel success, the locked quantity on the orders would return back to the address' balance and become free to use, i.e. transfer or send new orders.

```go
// please note the field name is the JSON name.
message CancelOrder {
  0x166E681B   // hardcoded, object type prefix in 4 bytes
  bytes sender = 1 // order originating address'
  string symbol = 2 // symbol for trading pair in full name of the tokens
  string refid = 3 // order id of the one to cancel
}
```
  
#### Freeze
Freeze transaction would move the amount of the tokens into a `frozen` state, in which it cannot be used to transfer or send new orders.

```go
// please note the field name is the JSON name.
message TokenFreeze {
  0xE774B32D   // hardcoded, object type prefix in 4 bytes
  bytes from = 1 // owner address
  string symbol = 2 // token symbol, in full name with "-" suffix
  int64 amount = 3 // amount of token to freeze
}
```

#### Unfreeze
Unfreeze would reversely turn the amount of `frozen` tokens back to free state.

```go
// please note the field name is the JSON name.
message TokenUnfreeze {
  0x6515FF0D   // hardcoded, object type prefix in 4 bytes
  bytes from = 1 // owner address
  string symbol = 2 // token symbol, in full name with "-" suffix
  int64 amount = 3 // amount of token to unfreeze
}
```

#### Vote

Vote transactions vote for proposals. 

```go
// please note the field name is the JSON name.
message Vote {
  0xA1CADD36	    // hardcoded, object type prefix in 4 bytes
  int64 proposal_id = 1     // ID of the proposal
  bytes voter = 2           // address of the voter
  uint64 option = 3         // option from OptionSet chosen by the voter,
}
```

Below are options for `option`:
```go
OptionYes           = 0x01  // yes
OptionAbstain       = 0x02  // abstain
OptionNo            = 0x03  // no
OptionNoWithVeto    = 0x04  // no with veto
```
#### Issue

Issue is to create new asset on Binance chain.
```go
message IssueTokenValue  {
  0x17EFAB80 // hardcoded, object type prefix in 4 bytes
  string Name = 1 //token name      
  string Symbol = 2 //token symbol     
  string TotalSupply = 3  //total supply
  bool Mintable = 4 //is mintable
}
```
#### Mint

Mint is to increase the total supply of a token.

```go
message Mint {
  0x467E0829  // hardcoded, object type prefix in 4 bytes
  bytes From = 1 //sender's address
  string Symbol string = 2 //token symbol
  int64 Amount = 3 // increase amount
}
```

#### Burn

Burn is to decrease the total supply of a token.
```go
message TokenBurn {
  0x7ED2D2A0  // hardcoded, object type prefix in 4 bytes
  bytes From = 1 //sender's address
  string Symbol string = 2 //token symbol
  int64 Amount = 3 // increase amount
}
```
#### List

List is to add a new trading pair.

```go
message DexList {
  0xB41DE13F // hardcoded, object type prefix in 4 bytes
  bytes From = 1 //sender's address 
  int64 ProposalId  = 2 // id of corresponding proposal  
  string BaseAssetSymbol  = 3 // token symbol of base asset     
  string QuoteAssetSymbol = 4 // token symbol of quote asset
  int64 InitPrice = 5 //  init price of the new token
}
```
#### Submit Proposal
Submit proposal is to create a proposal for validators about adding trading pairs
```go
message {
  0xACCBA2DE // hardcoded, object type prefix in 4 bytes
  string Title = 1      //  Title of the proposal
  string Description = 2 //  Description of the proposal
  byte ProposalType  = 3  //  Type of proposal. Initial set {PlainTextProposal, SoftwareUpgradeProposal}
  bytes Proposer = 4  //  Address of the proposer
  message Coin {
    string denom = 1
    int64 amount = 2 
  }
  int64 VotingPeriod  = 5 //  Length of the voting period (s) 
}
```
#### Deposit

Deposit is to increase the total deposit of a proposal.

```go
message Deposit{
  0xA18A56E5 // hardcoded, object type prefix in 4 bytes
  int64 ProposalID  = 1 // ID of the proposal
  bytes Depositer  = 2 // Address of the depositer
  message Coin {
    string denom = 1
    int64 amount = 2 
  }
}
```
