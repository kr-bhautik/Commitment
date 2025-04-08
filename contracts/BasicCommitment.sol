// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract BasicCommitment {

    mapping(address => bytes32) commitOf;
    function generateCommitHash(uint256 value, uint256 randomNum) public pure returns (bytes32) {

        return keccak256(abi.encodePacked(value, randomNum));
    }

    function createCommitment(address user, uint256 ans) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(user, ans));
    }

    function commit(bytes32 commitment) public {
        commitOf[msg.sender] = commitment;
    }

    function reveal(uint256 value, uint256 randomNum) public returns (bool) {

        bytes32 newCommitHash = keccak256(abi.encodePacked(value, randomNum));
        require(commitOf[msg.sender] == newCommitHash, "Commit verification failed.");
        delete commitOf[msg.sender];
        return true;
    }
}