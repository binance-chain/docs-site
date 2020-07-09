# Bind Token

BSC and BC work together to ensure that one token can circulate in both formats with confirmed total supply and be used in different use cases. Token Binding can happen at any time after BEP2 and BEP2E are ready. The token owners of either BEP2 or BEP2E only need to complete the **Binding** process when a cross-chain feature is necessory.

## Issue BEP2 Token

Please refer to this [doc](../../tokens.md)

**Example**
Let's issue a new token `ABC`
```bash
tbnbcli token issue --symbol ABC --token-name "ABC token" --mintable --total-supply 10000000000000000 --from owner --chain-id Binance-Chain-Ganges --node http://data-seed-prealpha-2-s1.binance.org:80
```

## Deploy BEP2E Token
Please refer to this [doc](issue-BEP2E.md)

The symbol of the BEP2E token must be exactly identical to the prefix of the bep2 token(case sensitive).

## Token Binding
### Send Bind Transaction
```bash
tbnbcli bridge bind --symbol ABC-A64 --amount 6000000000000000 --expire-time 1597545851 --contract-decimals 18 --from owner --chain-id Binance-Chain-Ganges --contract-address 0xee3de9d0640ab4342bf83fe2897201543924a324 --node http://data-seed-prealpha-2-s1.binance.org:80
```
The total supply of the ABC-A64 token is 100 million. The above bind transfer will transfer 60 million to a pure-code-controlled address. And then there are 40 million flowable tokens in BC. According to our bind mechanism, we have to lock 40 million token to **TokenManager** contract and leave 60 million flowable token on BSC. Thus the sum of flowable tokens on both chains is 100 million. Please remember that the amounts I mentioned above don’t include decimals.
### Approve Bind Request
1. Grant allowance:

    In [myetherwallet](../wallet/myetherwallet.md), call the **approve** of the BEP2E to grant a 40 million allowance to TokenManager contract. The spender value should be `0x0000000000000000000000000000000000001008`, and the amount value should be 4e25. The transaction sender should be the BEP2E owner.
    
    ![img](https://lh6.googleusercontent.com/p-HctNRPwXg0VD1yfE3j4OJ3BrMHPZpiGGCtp7XUJX34z_LT53nvZqgTzY58Ab1EsybJipwjsnwL2uJ-CPH8gntDpcw7LW7aFPK1_KRxxnNq-xErwGpaPTlg5UbfKoVNjd4YT0xU)

2. Approve Bind
    
    In [myetherwallet](../wallet/myetherwallet.md), call **approveBind** in **TokenManager** contract to approve the bind request from the BEP2E owner address. 
    
    ![img](https://lh6.googleusercontent.com/nFIbDxpA8bTVYH0Rt4UD-SYYz62TmYKjOsgK1CXxFRHHJlz6gOyXnq5p3GesM_zrQES4ixmojvN_Srk4CIf1MPxBXbia-K2DNiL23Hao1HiUgdNe4S2BmPe6yn5XJz7ajlwVVCti)

    The value here should be no less than `miniRelayFee/1e18`. The initial `miniRelayFee` is 1e16. So `miniRelayFee/1e18` equals to `0.01`. Besides, `miniRelayFee` can be changed by on-chain governance
    
3. Confirm bind result on BC
    
    Wait for about 20 seconds and execute this command:
    ```bash
    tbnbcli token info --symbol ABC-A64 --trust-node --node http://data-seed-prealpha-2-s1.binance.org:80
    ```
    
    ```json
    {
      "type": "bnbchain/Token",
      "value": {
        "name": "ABC Token",
        "symbol": "ABC-A64",
        "original_symbol": "ABC",
        "total_supply": "100000000.00000000",
        "owner": "tbnb1l9ffdr8e2pk7h4agvhwcslh2urwpuhqm2u82hy",
        "mintable": false,
        "contract_address": "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
        "contract_decimals": 18
      }
    }
    ```
    If the bind was successful, then in the above response, "contract_address" and "contract_decimals" should not be empty.