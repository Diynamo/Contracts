//SPDX-License-Identifier: GPL-3.0
//Giuliano Neroni DEV

pragma solidity ^0.8.12;

contract Ownable {
    address private _owner_1 = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address private _owner_2 = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    
    function get_owner_1() public view returns (address) {
        return _owner_1;}
    function get_owner_2() public view returns (address) {
        return _owner_2;}
        
    modifier onlyOwner() {
        require(msg.sender == _owner_1 || msg.sender == _owner_2 , 'Not owner');
        _;}
        
    function set_owner_1(address _own) public onlyOwner {
        _owner_1 = _own;}
    function set_owner_2(address _own) public onlyOwner {
        _owner_2 = _own;}}

contract tx_mapping is Ownable {
    uint256 max_quantity = 10;

    struct tx_nft {
        uint256 qty_bought;
        uint256 qty_left;
        string pay_tx;
        uint256 tx_done;}

    //mapping(address => bool) public myaddressmapping;
    //uint public remaining_quantity;

    mapping(address => uint256) private quantity;
    mapping(address => tx_nft) public balance;

    uint256 tx_done;
    uint256 qty_bought;
    uint256 qty_left;
    string tx_add;

    //function setaddresstrue() public {myaddressmapping[msg.sender] = true;}
    //function setpayment(string memory _payment) public {tx_addr[msg.sender] = _payment;}
    
    function purchase (address _addr, uint256 _quantity, string memory _pay) public onlyOwner {
        quantity[_addr] = _quantity;
        count(_addr, _pay);}

    function count (address _addr, string memory _pay) private onlyOwner {
        tx_done = balance[_addr].tx_done;

        if(tx_done == 0){
            balance[_addr].pay_tx = _pay;
            balance[_addr].qty_left = max_quantity;
            balance[_addr].qty_left -= quantity[_addr];
            balance[_addr].qty_bought = quantity[_addr];}

        if(tx_done > 0){
            tx_add = balance[_addr].pay_tx;
            balance[_addr].pay_tx = string(abi.encodePacked(tx_add, ";", _pay));
            balance[_addr].qty_left -= quantity[_addr];
            balance[_addr].qty_bought += quantity[_addr];}

        balance[_addr].tx_done += 1;}}
