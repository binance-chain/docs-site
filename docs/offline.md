# Offline

> Note: this feature is only available in testnet.

`bnbcli` support generating and signing all types of transactions offline, then broadcast them. This feature will let users generate and sign their transactions at an offline machine, then use another machine to broadcast it to the network

## Generate your unsigned transction

First step is that you need to generate your unsigned transaction and save it in a file.

> Note: `--account-number` and `--node` is not mandatory in unsigned command

For example, you can generate an unsigned transfer transaction:
```
./tbnbcli send --from <your-address>    --account-number <your-sccount-number> --dry --to <destination-address> --amount 200000000:BNB   --chain-id Binance-Chain-Nile --node=data-seed-pre-2-s1.binance.org:80 --generate-only --offline >> unsigned.json
```
Then, you can see that the signature of unsigned.json is empty.

## Sign your transaction

You can view the unsigned.json to verify that all the info about this transaction is correct. You need to get the account-number and sequence about your address here: https://docs.binance.org/api-reference/dex-api/paths.html#apiv1accountaddress
```
./tbnbcli sign unsigned.json --account-number <address-account-number> --sequence <address-sequence> --chain-id Binance-Chain-Nile --offline  --name <your-key-name> >> signed.json
```
You need to type in your password in this step

Then, you can see that the signature of signed.json is no longer empty.

## Broadcast Your Transaction

Please then copy your signed.json to a different server and broadcast this transaction.
```
./tbnbcli broadcast signed.json --node=http://data-seed-pre-0-s3.binance.org:80
```
You can find the list of node here: https://docs.binance.org/api-reference/cli.html#where-to-connect

If the broadast is successful, you will see the transaction hash in returned info. Please go and verify it in [Explorer](https://testnet-explorer.binance.org).