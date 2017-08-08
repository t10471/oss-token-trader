[Token Trader](https://guide.blockchain.z.com/docs/oss/token-trader/) - GMO Blockchain Open Source
==================================================

License
--------------------------------------
License is [here](./LICENSE.txt).

Apart from forbidding the use of this software for criminal activity, this license is similar to the [MIT License](https://opensource.org/licenses/mit-license.php).

GMO Blockchain Open Source Common License document is [here](https://guide.blockchain.z.com/docs/oss/license/).

DEMO
--------------------------------------
You can check the operation of this sample project on this page.

http://oss.blockchain.z.com/token-trader/

Explanation
--------------------------------------
- #### GMO Blockchain Open Source
    http://guide.blockchain.z.com/docs/oss/

- #### Swap Trade
    http://guide.blockchain.z.com/docs/oss/token-trader/

Usage Guides
--------------------------------------

### Create Z.com Cloud Blockchain environment
see [Setup Development Environment](https://guide.blockchain.z.com/docs/init/setup/)

### Install application
```bash
git clone --recursive https://github.com/zcom-cloud-blockchain/oss-token-trader.git
cd oss-token-trader/server
npm install
```

### Create admin account
```bash
cd oss-token-trader
node server/create_admin_account.js
```

### Deploy contracts
```bash
cd oss-token-trader/provider
truffle migrate
```

### Set up for Z.com Cloud Blockchain
See [Basic Configuration](https://guide.blockchain.z.com/docs/dapp/setup/)

- ##### Set CNS address on admin console
  1. Open a file 'provider/build/contracts/ContractNameService.json'

  2. Use 'networks.(network-id).address' as CNS address to register as ABI address on admin console

See [Contract Creation Process](https://guide.blockchain.z.com/docs/dapp/contract/)
- ##### Set Contract ABIs on admin console
  1. Open following files
    ```bash
    'provider/build/contracts/Demo_v1.json'
    'provider/build/contracts/SwapTrade_v1.json'
    ```
  2. Use 'networks.(network-id).address' and 'abi' values to register as Contract ABIs on admin console


### Configure for client
Create server/public/js/config.json based on server/public/js/config_template.json. Edit "CNS_ADDRESS" and "TOKEN_TRADER_ADDRESS" which you deployed.

- #### Put TOKEN_TRADER_ADDRESS of config
  1. Open following files
    ```bash
    'provider/build/contracts/TokenTrader.json'
    ```
  2. Use 'networks.(network-id).address' as TokenTrader address to edit config


### Start application
```bash
cd oss-token-trader
node server/app.js
```
