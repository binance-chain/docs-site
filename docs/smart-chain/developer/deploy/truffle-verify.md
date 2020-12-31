# Verify Your Contract on BscScan

The recommended way to verify a smart contract is using plugin. It is easier to read, imports are maintained, licenses are maintained.

**Verified using Truffle**

Example: <https://testnet.bscscan.com/token/0x68D2E27940CA48109Fa3DaD0D2C8B27E64a0c6cf>

GitHub Project: <https://github.com/huangsuyu/verify-example>

## Truffle

Truffle has an BscScan plugin: [truffle-plugin-verify](https://github.com/rkalis/truffle-plugin-verify)

You need to deploy with Truffle to verify with the Truffle verify plugin.

- Install the plugin

```bash
npm install -D truffle-plugin-verify
```

- Configure the plugin in `truffle-config.js`

```js
const HDWalletProvider = require("@truffle/hdwallet-provider");

// const infuraKey = "fj4jll3k.....";
//
const { mnemonic, BSCSCANAPIKEY} = require('./env.json');

module.exports = {

  plugins: [
    'truffle-plugin-verify'
  ],
  api_keys: {
    bscscan: BSCSCANAPIKEY
  },
  networks: {

    testnet: {
        provider: () => new HDWalletProvider(mnemonic, `https://data-seed-prebsc-1-s1.binance.org:8545`),
        network_id: 97,
        timeoutBlocks: 200,
        confirmations: 5,
        production: true    // Treats this network as if it was a public net. (default: false)
    }
  },

  // Set default mocha options here, use special reporters etc.
  mocha: {
    timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
       version: "0.5.16",    // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      settings: {          // See the solidity docs for advice about optimization and evmVersion
       optimizer: {
         enabled: false,
         runs: 200
       },
       evmVersion: "byzantium"
      }
    },
  },
};

```

- Verify
```
truffle run verify BEP20Token@{contract-address} --network testnet
```
You should see the following output:

```
Verifying BEP20Token@0x68D2E27940CA48109Fa3DaD0D2C8B27E64a0c6cf
Pass - Verified: https://testnet.bscscan.com/address/0x68D2E27940CA48109Fa3DaD0D2C8B27E64a0c6cf#contracts
Successfully verified 1 contract(s).
```


