const DeliveryRequest = artifacts.require("DeliveryRequest");
delete require.cache[require.resolve('./libs/utils')];
const utils = require('./libs/utils');


// 200000000000000000, 100, 200, "0xabcabc"

// contract: 0x83DceFEa7FD0E350D70eA786D1FA49b3b932345a
// owner: 0x597898a2C256561996583d8eFE224b1fa905646b
// bidder: 0x508a6c0f1c3fcc940d89b74a940518c06ac2c6bf

// 0x5406fab38d7bee8b23f4f8d28b74c323d0029e86

contract('1st DeliveryRequest test', async (accounts) => {


  let tx, inst;
  let acc0 = accounts[0];
  let acc1 = accounts[1];
  let acc2 = accounts[2];
  let amt = '450000000000000000';


  it("should just deploy", async () => {
	inst = await DeliveryRequest.new(30000000000, {from: acc0});
  })

  it("should start a delivery request", async () => {
  	inst = await DeliveryRequest.new(30000000000, {from: acc0});
  	tx = await inst.start('200000000000000000', 100, 200, "911", {from: acc0, value: amt });
  })

  it("should place bids on a request", async () => {
  	inst = await DeliveryRequest.new(30000000000, {from: acc0});
  	tx = await inst.start('200000000000000000', 100, 200, "911", {from: acc0, value: amt });
  	tx = await inst.bid({from: acc1, value: '7000000000000000' });
  })

  it("should assign a request", async () => {
  	inst = await DeliveryRequest.new(30000000000, {from: acc0});
  	tx = await inst.start('200000000000000000', 100, 200, "911", {from: acc0, value: amt });
  	tx = await inst.bid({from: acc1, value: '7000000000000000' });
  	tx = await inst.assign(acc1, {from: acc0});
  })

  it("should mark a request complete", async () => {
  	inst = await DeliveryRequest.new(30000000000, {from: acc0});
  	tx = await inst.start('200000000000000000', 100, 200, "911", {from: acc0, value: amt });
  	tx = await inst.bid({from: acc1, value: '7000000000000000' });
  	tx = await inst.assign(acc1, {from: acc0});
  	tx = await inst.mark_complete({from: acc0});
  })

  it("should let rider claim", async () => {
  	inst = await DeliveryRequest.new(30000000000, {from: acc0});
  	tx = await inst.start('200000000000000000', 100, 200, "911", {from: acc0, value: amt });
  	tx = await inst.bid({from: acc1, value: '7000000000000000' });
  	tx = await inst.assign(acc1, {from: acc0});
  	tx = await inst.mark_complete({from: acc0});
  	tx = await inst.claim({from: acc1});
  })

});






// 0xB6f6Ad60A9D7402159E7DA8aE4b360e6f5910F7a
// 0x8f61f85486eE1256b1c892B9e13C18C76019815f
// 0x34CF29Ee644f391Cd142183cE6c2F8784C33ad12
// 0xF37fC809c2477F9727A01D96EbfDc3819E9F4e6A

// ------------------------------



