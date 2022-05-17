// SPDX-License-Identifier: GPL-3.0
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

contract tx_mapping is Ownable{

    uint256 max_quantity = 10;

    struct tx_nft {
        uint256 qty_bought;
        uint256 qty_left;
        string pay_tx;
        uint256 tx_done;}

    struct wallet_data {
        uint number_wallet;
        address address_wallet;}

    //mapping(address => bool) public myaddressmapping;
    //uint public remaining_quantity;

    mapping(address => uint) private quantity;
    mapping(address => tx_nft) public balance;
    mapping (address => bool) public whitelisted;
    address[] private _whitelist;
    address[] private _excluded;

    uint tx_done;
    uint qty_bought;
    uint qty_left;
    uint public tx_id;
    string tx_add;

    wallet_data []data;

    //function setaddresstrue() public {myaddressmapping[msg.sender] = true;}
    //function setpayment(string memory _payment) public {tx_addr[msg.sender] = _payment;}

    function add_wallet(uint _tx_id, address address_wallet) public {
	    wallet_data memory e = wallet_data(_tx_id, address_wallet); 
  	    data.push(e);}

    function get_list(uint _tx_id) public view returns(address) {
	    uint i;
	    for(i=0;i<data.length;i++){
  		    wallet_data memory e = data[i];
  		    if(e.number_wallet == _tx_id){
    			return(e.address_wallet);}}}
    
    function purchase (address _addr, uint _quantity, string memory _pay) public onlyOwner {
        quantity[_addr] = _quantity;
        count(_addr, _pay);
        tx_id += 1;
        add_wallet(tx_id, _addr);
        whitelist(_addr);}

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

        balance[_addr].tx_done += 1;}
        
        
    function whitelist(address _addr) public onlyOwner() {
        require(!whitelisted[_addr], "Account is already Whitlisted");
        whitelisted[_addr] = true;
        _whitelist.push(_addr);}

    function blacklist_A_whitelisted(address _addr) external onlyOwner() {
        require(whitelisted[_addr], "Account is already Blacklisted");
        for (uint256 i = 0; i < _whitelist.length; i++) {
            if (_whitelist[i] == _addr) {
                _whitelist[i] = _excluded[_excluded.length - 1];
                whitelisted[_addr] = false;
                _whitelist.pop();
                break;}}}}
