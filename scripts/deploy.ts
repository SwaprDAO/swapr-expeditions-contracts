import { ethers } from "hardhat";

async function main() {
  const SwaprExpeditions = await ethers.getContractFactory("SwaprExpeditions");

  console.log(
    "Deploying SwaprExpeditions from address:",
    (await ethers.getSigners())[0].address
  );

  const swaprExpeditions = await SwaprExpeditions.deploy();
  await swaprExpeditions.deployed();

  console.log("SwaprExpeditions deployed to:", swaprExpeditions.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
