var DeliveryRequest = artifacts.require("./DeliveryRequest.sol");

module.exports = function(deployer) {
  deployer.deploy(DeliveryRequest, 3000000000);
};
