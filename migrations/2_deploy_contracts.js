var MiniMeTokenFactory = artifacts.require("MiniMeTokenFactory");
var CryptoExplorersToken = artifacts.require("./CryptoExplorersToken.sol");

module.exports = function(deployer) {
  deployer.deploy(MiniMeTokenFactory).then(function() {
    deployer.deploy(CryptoExplorersToken, MiniMeTokenFactory.address);
  });
};
