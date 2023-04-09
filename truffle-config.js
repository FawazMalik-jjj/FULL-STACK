// require('babel-register')
// require('babel-polyfill')
require('dotenv').config()
const HDWalletProvider = require('@truffle/hdwallet-provider')

module.exports = {
  // Configure networks (Localhost, Rinkeby, etc.)
  networks: {
    development: {
      host: '127.0.0.1',
      port: 8545,
      network_id: '*', // Match any networks
    
      goerli: {
          provider: () =>
              new HDWalletProvider(process.env.SECRET_KEY, process.env.ENDPOINT_URL),
          network_id: '5',
          gas: 4465030,
      },
  },
    },
  
  contracts_directory: './contracts/',
  contracts_build_directory: './src/shared/abis/',
  // Configure your compilers
  compilers: {
    solc: {
      version: '0.8.11',
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
}