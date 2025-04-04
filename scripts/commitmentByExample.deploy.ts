import { ethers } from "hardhat";

const _commitment = ''; // Answer commitment of creator
const guessLimit = 180; // Guess time limit
const revealLimit = 180; // Reveal time limit
async function main() {
    const BasicCommitmentContract = await ethers.getContractFactory('Commitment');
    console.log("Deploying CommitmentByExample contract...")
    const tx = await BasicCommitmentContract.deploy(_commitment, guessLimit, revealLimit);
    console.log("Contract deployed at", await tx.getAddress());
}
main().then(() => console.log("Success")).catch((err) => console.log(err));