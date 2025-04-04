import { ethers } from "hardhat";

async function main() {
    const BasicCommitmentContract = await ethers.getContractFactory('BasicCommitment');
    console.log("Deploying BasicCommitment contract...")
    const tx = await BasicCommitmentContract.deploy();
    console.log("Contract deployed at", await tx.getAddress());
}
main().then(() => console.log("Success")).catch((err) => console.log(err));