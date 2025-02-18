// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IBridge {
    function sendMessage(address target, bytes calldata data) external;
}

contract CrossChainMessenger {
    address public admin;
    IBridge public bridge;

    event MessageSent(address indexed sender, address indexed target, bytes data);
    event MessageReceived(address indexed sender, bytes data);

    constructor(address _bridge) {
        admin = msg.sender;
        bridge = IBridge(_bridge);
    }

    function sendMessage(address target, bytes calldata data) external {
        bridge.sendMessage(target, data);
        emit MessageSent(msg.sender, target, data);
    }

    function receiveMessage(bytes calldata data) external {
        require(msg.sender == address(bridge), "Only bridge can send messages");
        emit MessageReceived(msg.sender, data);
    }
}