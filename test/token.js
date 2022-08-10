const { expect } = require("chai");
describe("NFT1 contract testing", function () {
  it("Deployment should assign the total supply of tokens to the owner", async function ()  {
    const [owner] = await ethers.getSigners();

    const Token = await ethers.getContractFactory("FirstMintNFT");

    const hardhatToken = await Token.deploy("https://api.ac55id.com/ondemand/");

    // const ownerBalance = await hardhatToken.balanceOf(owner.address);
    // expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);

    const firstNftMint = await hardhatToken.mintNFT("0.1");


    // const pauseMint = await hardhatToken.pause(true, {gasLimit : 300000});
    
  });
});


