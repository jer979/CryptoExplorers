# CryptoExplorers

https://cryptoexplorers.org

## Notes

  - Script uses a multiMint function implemented in `CryptoExplorersToken.sol`.
  - Token is based on the MiniMeToken - this may be overkill in this case, Dan can modify.
  - Framework is Truffle - this is used for compilation & deployment.
  - Script will always mint additional tokens, so if you run it multiple times on the same .csv file it will credit addresses multiple times.

## Prerequisites

1. This repo uses truffle, node and npm:  
https://nodejs.org/en/ (v8.4.0)  
http://truffle.readthedocs.io/en/beta/getting_started/installation/

1. Run either a geth node, or testrpc on port 8547:  
`testrpc -p8547`  
`geth --testnet --fast --rpc`

## Deployment

1. Execute `truffle compile`:  
```
Adams-MBP:CryptoExplorers adamdossa$ truffle compile
Compiling ./contracts/CryptoExplorersToken.sol...
Compiling ./contracts/Migrations.sol...
Compiling ./contracts/MiniMeToken.sol...
Writing artifacts to ./build/contracts
```
1. Execute `truffle migrate --reset`:  
```
Adams-MBP:CryptoExplorers adamdossa$ truffle migrate --reset
Using network 'development'.

Running migration: 1_initial_migration.js
  Replacing Migrations...
  Migrations: 0xba9dd18b8f1aa3187962b8f7723fdfa4a0b2892a
Saving successful migration to network...
Saving artifacts...
Running migration: 2_deploy_contracts.js
  Replacing MiniMeTokenFactory...
  MiniMeTokenFactory: 0xb3ad2bfd516bfafdc5e964d45a268e7a8c15266c
Saving successful migration to network...
  Deploying CryptoExplorersToken...
Saving artifacts...
  CryptoExplorersToken: 0x3f9a42997952682d2ac31ffd6e48f2158ee6b2c7
```
1. Edit `scripts/migrateBalances.js` to reflect:  
  - the controller of the token contract (address that deployed it above).
  - the address of the token contract (output above).
1. Edit `scripts/migrateBalances.csv` to reflect the accounts you want to update:
  - line format is <address>,<number of tokens to assign>
1. Execute `node scripts/migrateBalances.js`:  
```
Adams-MBP:CryptoExplorers adamdossa$ node scripts/migrateBalances.js
Transaction: 0 Length: 11
txHash:  0x53266a7178c8fdd9c8427f84d9c96ce7ff778383b805a37240d68f8c91f2b8d8
terminated successfully
```
