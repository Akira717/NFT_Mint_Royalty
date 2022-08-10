// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
 
  const SecondNFT = await hre.ethers.getContractFactory("SecondMintNFT");
  const secondNFT = await SecondNFT.deploy("https://gateway.pinata.cloud/ipfs/QmcP6YgLfSygXevc6ckegjXHDPiNDXk89ZVEWzVydxB8Ph/", "0x2eBcF6Fd0Eb2C3FbE0a3bc0e3E5019919C3a3081");

  await secondNFT.deployed();

  console.log("Lock with 2 ETH deployed to:", secondNft.address);
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
