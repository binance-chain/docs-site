# How to Verify Proxy Contract

*Please learn how to deploy an upgradable BEP20 contract [here](./proxy.md)*

## Flatten your contract

### Install flattener
```
npm install truffle-flattener -g
```
Run the following command:
```
$ truffle-flattener BEP20TokenImplementation.sol > BEP20TokenImplementationFlattened.sol
$ truffle-flattener BEP20UpgradeableProxy.sol > BEP20UpgradeableProxyFlattened.sol"
```
## Compile and deploy your contract with Remix

### Compile Implementation contract

- Open Remix IDE: [https://remix.ethereum.org](https://remix.ethereum.org/)
- Select solidity language
- Create new contract `BEP20Token.sol` and copy contract code from flattened `BEP20TokenImplementationFlattened.sol`
- Compile the implementation contract
- Click on this button to switch to the compile page
  - Select “BEP20TokenImplementation” contract
  - Enable “Auto compile” and “optimization”
  - Click “ABI” to copy the contract abi and save it.
### Deploy the implementation contract
- Select “Injected Web3”
- Select “BEP20TokenImplementation” contract
- Click the “Deploy” button and Metamask will pop up
- Click the “confirm” button to sign and broadcast the transaction to BSC.
- Then, you need to initialize the token: fill in all the parameters and click on “transact”

<img src="https://lh3.googleusercontent.com/SjMHLYY9A1LtFXJFc2gtIOL_lEzZk--eiJyNspL-8qfDvkfNYGAgGKvodCo0-Pfp3UhmrPGUc4oOpFFuDBzYhLxqN3-LIAW7BRKdeoiPdYuJMep0hT67ifNw0i33DzVXNfzPjwZi" alt="img" style="zoom:50%;" />

> Note: `Owner` should be the address who send the deploy transaction before.

- Click on the “Copy” icon to save the initializatioin data: Like the following: ```


```
0xef3ebcb800000000000000000000000000000000000000000000000000000000000000c00000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000001200000000000000000000000000000000000000000000000000000000000f42400000000000000000000000000000000000000000000000000000000000000001000000000000000000000000fc41d5571120442d1bb82cea0884966e543cb78b000000000000000000000000000000000000000000000000000000000000000548656c6c6f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000548454c4c4f000000000000000000000000000000000000000000000000000000
```

- Confirm your transaction in MetaMask


<img src="https://lh5.googleusercontent.com/kPAo0FyEgt0vNDkBMxIHNIFqdq0mP4BhFT21vXvusa8-wlP-BXr4FcHjYV-NZEuQZrgwq74fV2oXAKIrAovpXi7KHChXtowSI3sbu5wTQL-_3-x8Qd-6-z7xRDkRXzJZLcakxrR3" alt="img" style="zoom:25%;" />

## Compile Proxy Contract

- Create new contract proxy.sol and copy contract code from flattened `BEP20UpgradeableProxyFlattened.sol `.  Here is and [example](https://bscscan.com/address/0xA6Ec2Fe4F6040b188A926048f44c9A59Fca189d4#code)
- Compile the proxy contractClick on this button to switch to the compile page
  - Select “BEP20UpgradeableProxy” contract
  - Enable “Auto compile” and “optimization”Click “ABI” to copy the contract abi and save it.

### Deploy the proxy contract

- Select “Injected Web3”Select “BEP20UpgradeableProxy.sol” contract
- Fill in the parameters

<img src="https://lh3.googleusercontent.com/bdTP2V-Fco3HogiRVO-2FTlGwzXGsgiOa2VcCUdkr1LCD2kuRbHbz0u7eM7xmLhYiJAToG9IKL-R3heI2i_TPf2dQoFE215s9w-b8D6PLjYPAktKoLRRDozV8aOpQvfYGJgEYtJM" alt="img" style="zoom:33%;" />

**Logic**: The address of `BEP20Implementation` contract
**Admin**: admin cannot be BEP20 token owner
**Data**: use the initialization data you saved before

- Click the “Deploy” button and Metamask will pop up
- Click the “confirm” button to sign and broadcast transaction to BSC.

## Verify Proxy Contract on BscScan
Note: The way to verify the BEP20TokenImplementation contract is the same as before.

- Go to your contact page and click on “Verify and Publish”

<img src="https://lh5.googleusercontent.com/RvHXgGR_7rvaNXNgBCB5JnHQE90ziGcr1kmy4NDxJfWxTJTZz3bkZuHtGRrpXY-Qb_7_5FLzzD1vwBo3cER_6Qfbvd7g3CmHE8l16cemD-92jZYhQX6XUUZRvvzFwr61f9jUuIuC" alt="img" style="zoom:50%;" />

- Select Single file

<img src="https://lh4.googleusercontent.com/PWp8_JMP9S4pXB08e3Rs2lta4Xn4ZOCoBkAmgsyr4tE0kv_KtlvA1TjLOwrBYG7ON1Z51CZh7NuFzD9IlOYZIRg6B5OZx0Z6yiyrlu2VjkvmjgqPV6BOsF4hWqzeKC8_g8PeTTZ_" alt="img" style="zoom:33%;" />


- Copy your contract code below and check “Optimization” if it’s enabled
- Contractor Data: Please use this site for getting the correct constructor data: https://abi.hashex.org/#

First, you need to copy ABI json of “BEP20UpgradeableProxy.sol” contractThen, click on “Parse”

<img src="https://lh4.googleusercontent.com/Z1Ky-aHOBVvi5qDVNv4q-kOiK_v4uLzMpct08hQ-RcGbGgyb3HdOXMPMF9a-eNw5MybIjM222lZRrtV7Bn_cxntDIw9ivZ90dpsIeB44cpu6F9S9ena8BufByPN1Yvc508gnSZQ4" alt="img" style="zoom:33%;" />

Add all those 3 parameters as indicated. Then copy/paste the result.

That’s it! You have verified your proxy contract.

  <img src="https://lh4.googleusercontent.com/MgaUVOq6GdeA374T6DYsRPbphwSG4WNsfm-fJunGif4sFU4ILDQN_XcJ6O-qh8I6SuILbu2O9oriSQii6RcCYQY09_T1qoNvK6JxFkydM9u9zDWMUrybam1Zu_YiFAoa-3T867ea" alt="img" style="zoom:33%;" />

## Link these two contracts
- Click on “More Options” and choose “is this a proxy”.

<img src="https://lh3.googleusercontent.com/2_dq4WNMba2_RWJzLSRehjDjMWx8SgcUkU5d88lNzllt6QViM1uEW49e-H0nUbhjIc9iFCsXx3iavTsUFahjTR4Gocdf_jw_IhK_QvETb-G9CFgCb1LIlZvsGor37g8dKVxDnj7I" alt="img" style="zoom:33%;" />

- Verify your proxy address

<img src="https://lh5.googleusercontent.com/Gu94XxaGAaKgqX5rxXmAurPlDoJR1UwsJs06ZA3WckZp3JJNkJg8FpWkMW2eBDpcOwtlYzePaTSTzEAKjKeM26OtOaOmsSiJ-v7mg4oS-qhoMvbX8pkbkrV1DJ1UNnMB7YmjILJ3" alt="img" style="zoom:33%;" />

- Confirm the implementation address.

<img src="https://lh5.googleusercontent.com/UOjBYquaa6k1Zt_WxnsVRnlikMTbeFTxiyymeRT0-XrNwCrPjnIvBfINuEm_Uv-vOl7chOfKus8niNqhvX21SbipwUOZ8lTX6G3JA4GPmR3TCQgtLnI9A00rshuIjf3QoqbKMFaE" alt="img" style="zoom:25%;" />

If you go back to the contract page and you can see two more buttons “Read as Proxy” and “Write as Proxy”

<img src="https://lh6.googleusercontent.com/xcVqGgOZ2mySt25Z7emHzwNmquYy4cyFSuQh-F7mJYG7rWfit4QWyxjBFl8V7Hc7_y3FepNRMLR7htZ-OiLqHfnvtwamep7exo2pocrNPMX5iyfZNlp5qVcDuPcwB8_VsisVG9dY" alt="img" style="zoom:33%;" />