// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract NFT_ordered {
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

    function set(address _addr, uint _bal) external onlyOwner() {
        balances[_addr] = _bal;

        if (!inserted[_addr]) {
            inserted[_addr] = true;
            keys.push(_addr);
        }
    }

    function get(uint _index) external view returns (uint) {
        address key = keys[_index];
        return balances[key];
    }

    function buyers() external view returns (uint) {
        return keys.length;
    }
}
