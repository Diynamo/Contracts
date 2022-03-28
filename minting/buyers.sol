// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract NFT_ordered {
    mapping(address => uint) public id;
    mapping(address => uint) public balances;
    mapping(address => bool) public inserted;
    address[] public keys;
    address public _owner;

    constructor(address deployer) {
        _owner = deployer;
    }

    modifier onlyOwner() {
        require(_owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    function set(address _addr, uint _bal, uint _id) external onlyOwner() {
        balances[_addr] = _bal;
        id[_addr] = _id;

        if (!inserted[_addr]) {
            inserted[_addr] = true;
            keys.push(_addr);
        }
    }

    function get(uint _index) external view returns (uint, uint) {
        address key = keys[_index];
        return (balances[key], id[key]);

    }

    function buyers() external view returns (uint) {
        return keys.length;
    }

    function random() public view returns (uint) {
        //To generate a pseudo-random number you could do this
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, keys)));
    }

    function pickWinner() public view returns (uint) {
        //If you need a random number in a specific range you can use modulo '%'
        uint index=random()%keys.length;
        return index;
    }

    function randomval() public view onlyOwner() returns (uint) {
        uint randomHash = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, keys)));
        return randomHash % 1000;
    }

}
