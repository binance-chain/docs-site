# Timelock

As explained in BEP9, some business plans decide to lock certain amount tokens for pre-defined periods of time, and the only vest in the future according to the schedules. For example, some projects may lock some allocation of the issued tokens as a commitment by the founding team; some business scenarios also need to lock some tokens as collateral for value.

## TimeLock

You can only lock tokens on your own account. TimeLock will transfer locked tokens to a purely-code-controlled escrow account and before the lock time expires, the specific user will not be able to claim them back, including restrictions where they cannot use, transfer or spend these tokens.

### Command line

You must use `--broadcast` to submit your tranaction to the blockchain, otherwise it will return an unaigne transaction.

### Parameters

| **Field**    | **Type** | **Description**                                              |
| :------------ | :-------- | :------------------------------------------------------------ |
| Description   | string  | Description of the lock operation. Max length of description is 128 bytes. |
| Amount        | []Coin   | A set of tokens to be locked |
| LockTime      | int64  | The time when these tokens can be unlocked. LockTime is a future timestamp(seconds elapsed from January 1st, 1970 at UTC) and max LockTime should be before 10 years from now.  |
| broadcast     | bool   | if you want to submit your tranaction to the blockchain |

### Fee

0.01 BNB will be charged on TimeLock transactions.

### Example

On testnet, you can lock 1BNB for 1 day.
```
./tbnbcli token time-lock  --amount "100000000:BNB" --from <your-name> --description " test timelock"  --lock-time <lock-timestamp> --chain-id Binance-Chain-Nile --trust-node --node http://data-seed-pre-0-s3.binance.org:80 --broadcast
```

## TimeUnlock

TimeUnlock will claim the locked tokens back when the specified lock time has passed.

### Parameter
| **Field**    | **Type** | **Description**                                              |
| :------------ | :-------- | :------------------------------------------------------------ |
| address   | string  | the address you want to query|
| time-lock-id  | int64   | the id of your locking, it's incremental |


### Fee

0.01 BNB will be charged on ReLock transactions.

### Example

```
./tbnbcli token time-unlock  --from  <your-address> --time-lock-id <lock-id> --chain-id Binance-Chain-Nile --trust-node --node http://data-seed-pre-0-s3.binance.org:80
```


Example output for trying to unlock toekns whose locking period is not expired:

```
ERROR: {"codespace":7,"code":7,"abci_code":458759,"message":"Can not unlock: lock time(2019-06-28 09:26:54 +0000 UTC) is after now(2019-06-27 08:31:54.680643156 +0000 UTC)"}
```
## TimeRelock

TimeRelock can extend lock times, increase the amount of locked tokens or modify the description of an existing lock record.

PLease note that you either increase the `expire time` or amount of your lock of tokens which are not unlocked.

### Parameters

| **Field**    | **Type** | **Description**                                              |
| :------------ | :-------- | :------------------------------------------------------------ |
| time-lock-id  | int64   | the id of your locking, it's incremental |
| Amount        | []Coin   | A set of tokens to be locked |
| LockTime      | int64  | The time when these tokens can be unlocked. LockTime is a future timestamp(seconds elapsed from January 1st, 1970 at UTC) and max LockTime should be before 10 years from now.  |
| broadcast     | bool   | if you want to submit your tranaction to the blockchain |

### Fee

0.01 BNB will be charged on UnLock transactions.

### Example

```
./tbnbcli token time-relock --time-lock-id  <lock-id> --increase-amount-to <amount of tokens>  --from <key-name > --chain-id Binance-Chain-Nile --node=data-seed-pre-2-s1.binance.org:80 --broadcast
```

Output if you don't add more tokens or don't extend your locking period, you will get the following error:

```
ERROR: {"codespace":7,"code":6,"abci_code":458758,"message":"Invalid lock amount: new locked coins(100000000BNB) should be more than original locked coins(100000000BNB)"}
```

## QueryTimeLock

QueryTimeLock will query a lock record of a given address by the id. If this locking is ended, then no info will be returned.


### Parameter
| **Field**    | **Type** | **Description**                                              |
| :------------ | :-------- | :------------------------------------------------------------ |
| time-lock-id  | int64   | the id of your locking, it's incremental |

### Example

```
./tbnbcli token query-time-lock  --from  <your-key-name> --time-lock-id <lock-id> --chain-id Binance-Chain-Nile --trust-node --node http://data-seed-pre-0-s3.binance.org:80
```

Example output:

```
[
  {
    "id": "1",
    "description": " test timelock",
    "amount": [
      {
        "denom": "BNB",
        "amount": "100000000"
      }
    ],
    "lock_time": "2019-06-27T01:59:52Z"
  }
]
```

## QueryTimeLocks

QueryTimeLocks will query all lock records of a given address.


### QueryTimeLock Parameters

| **Field**    | **Type** | **Description**                                              |
| :------------ | :-------- | :------------------------------------------------------------ |
| address   | string  | the address you want to query|

### Example
```
./tbnbcli token query-time-lock  --address  <your-address>    --chain-id Binance-Chain-Nile --trust-node --node http://data-seed-pre-0-s3.binance.org:80
```
Example output:

```
[
  {
    "id": "1",
    "description": " test timelock",
    "amount": [
      {
        "denom": "BNB",
        "amount": "100000000"
      }
    ],
    "lock_time": "2019-06-27T01:59:52Z"
  },
  {
    "id": "2",
    "description": " test timelock",
    "amount": [
      {
        "denom": "BNB",
        "amount": "100000000"
      }
    ],
    "lock_time": "2019-06-28T09:26:54Z"
  }
]
```
