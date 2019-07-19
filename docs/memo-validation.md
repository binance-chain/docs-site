#  Customized Scripts and Transfer Memo Validation

## Memo Validation

 As explained in BEP12, In some circumstances, users may want to specify some additional functions or/and validations on some transactions.  With BEP12, exchanges can reject deposits that have no valid digits-only memo.

## What is a costomized script?

This script is aimed to ensure the transfer transactions have valid memo if the receivers require this.

Firstly, this script will check the following conditions:

The transaction type is send.
The target address is the receiving address.
Then this script will ensure that the transaction memo is not empty and the memo only contains digital letters. This is the pseudocode:
```
func memoValiation(addr, tx) error {
if tx.Type != “send” {
    return nil
}
if ! isReceiver(tx, addr) {
   return nil
}
if  tx.memo.length == 0 {
    return err(“tx memo is empty”)
}
if !isAllDigital(tx.memo) {
    return err(“tx memo contains non digital character”)
}
return nil
}
```
### Fee

1 BNB will be charged on memo validation transactions.


## Command Line

### Global Parameters

| **Field**    | **Type** | **Description**                                              |
| :------------ | :-------- | :------------------------------------------------------------ |
| from   | address  | Description of the lock operation. Max length of description is 128 bytes. |
| Amount        | []Coin   | A set of tokens to be locked |
| LockTime      | int64  | The time when these tokens can be unlocked. LockTime is a future timestamp(seconds elapsed from January 1st, 1970 at UTC) and max LockTime should be before 10 years from now.  |
| broadcast     | bool   | if you want to submit your tranaction to the blockchain |


###  Set-account-flags

set account flags
### Parameters

| **Field**    | **Type** | **Description**                                              |
| :------------ | :-------- | :------------------------------------------------------------ |
| account-flags  | string   | account flags, hex encoding string with prefix 0x |

Example:
```
bnbcli account_flag set-account-flags
```

### enable-memo-checker

enable memo checker

### Parameters

| **Field**    | **Type** | **Description**                                              |
| :------------ | :-------- | :------------------------------------------------------------ |
| account-flags  | string   | account flags, hex encoding string with prefix 0x |


Example on testnet:
```
bnbcli account_flag enable-memo-checker
```

Example on mainnet:
```
bnbcli account_flag enable-memo-checker
```

### disable-memo-checker

enable memo checker

### Parameters

| **Field**    | **Type** | **Description**                                              |
| :------------ | :-------- | :------------------------------------------------------------ |
| account-flags  | string   | account flags, hex encoding string with prefix 0x |

Example:
```
bnbcli account_flag disable-memo-checker
```
