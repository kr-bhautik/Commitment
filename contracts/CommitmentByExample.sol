// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract Commitment {
    
    address private creator;
    uint256 guessLimit;
    uint256 revealLimit;

    mapping(address => bytes32) commitmentOf;
    mapping(address => bool) public winners;
    constructor(bytes32 _commitment, uint256 _guessLimit, uint256 _revealLimit) {
        creator = msg.sender;
        commitmentOf[creator] = _commitment;  // True Answer
        guessLimit = block.timestamp + _guessLimit;
        revealLimit = guessLimit + _revealLimit;
    }

    function setLimits(uint256 _guessLimit, uint256 _revealLimit) public {
        require(msg.sender == creator, "NOT AUTHORIZED.");
        require(block.timestamp > revealLimit, "Reveal time is not over yet");
        guessLimit = block.timestamp + _guessLimit;
        revealLimit = guessLimit + _revealLimit;
    }

    function createCommitment(address user, uint256 ans) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(user, ans));
    }

    function guess(bytes32 _commitment) public {
        require(block.timestamp < guessLimit, "Guess limit is over");
        require(msg.sender != creator, "Creator is not allowed to guess");
        commitmentOf[msg.sender] = _commitment;
    }

    function reveal(uint256 ans) public {
        require(block.timestamp >= guessLimit, "Reveal time is not started yet.");
        require(block.timestamp <= revealLimit, "reveal time is over");
        require(msg.sender != creator, "Creator can't reveal");
        require( createCommitment(msg.sender, ans) == commitmentOf[msg.sender], "Commit not verified");
        require( createCommitment(creator, ans) == commitmentOf[creator], "Wrong answer, You lose...");
        winners[msg.sender] = true;
    }
}