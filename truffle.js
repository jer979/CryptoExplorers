module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      gasPrice: 5000000000,
      from: "0xf8536ca7a25cbf70df754fa310079ada4c6114c2",
      network_id: "*" // Match any network id
    }
  }
};
