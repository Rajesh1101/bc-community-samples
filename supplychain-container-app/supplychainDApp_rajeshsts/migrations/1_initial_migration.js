var supplyChain = artifacts.require("./supplyChain.sol");
var Migrations = artifacts.require("./Migrations.sol");

module.exports = function(deployer) {
  deployer.deploy(supplyChain);
  deployer.deploy(Migrations);
};
