// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract NFT_ordered {
    mapping(uint => uint) public id;
    mapping(uint => uint) public balances;
    mapping(uint => bool) public inserted;
    mapping(uint => address) public buyer;
    uint[] public keys;
    address public _owner;

    constructor(address deployer) {
        _owner = deployer;
    }

    modifier onlyOwner() {
        require(_owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    function set(uint _id, uint _bal, address _buyer) external onlyOwner() {
        balances[_id] = _bal;
        buyer[_id] = _buyer;

        if (!inserted[_id]) {
            inserted[_id] = true;
            keys.push(_id);
        }
    }

    function get(uint _index) external view returns (uint, uint, address) {
        uint key = keys[_index];
        return (id[key], balances[key], buyer[key]);

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
        randomHash = randomHash % 10;
        return randomHash;
    }

}
