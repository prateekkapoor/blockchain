//pratcoin ico
pragma solidity ^0.4.11;

contract pratcoin_ico {
    
    //Introducing total number of pratcoin available for sale
    uint public max_pratcoins = 1000000;
    
    //Introducing USD to pratcoin conversion rate
    uint public usd_to_pratcoins = 1000;
    
    //Introducing total number of pratcoin that have been bought by investores
    uint public total_pratcoin_bought = 0;
    
    mapping(address => uint) equity_pratcoin;
    mapping(address => uint) equity_usd;
    
    modifier  can_buy_pratcoins(uint usd_invested){
        require (usd_invested * usd_to_pratcoins +total_pratcoin_bought <= max_pratcoins);
        _;
        
    }
    
    //equity_in_pratcoin
    function equity_in_pratcoin(address investor) external constant returns(uint) {
       return equity_pratcoin[investor];
    }
    
    //equity_in_usd
    function equity_in_usd(address investor) external constant returns(uint) {
       return equity_usd[investor];
    }
    
    //buying pratcoin 
    function buy_pratcoin(address investor, uint usd_invested) external
    can_buy_pratcoins(usd_invested){
        uint pratcoin_bought = usd_to_pratcoins * usd_invested;
        equity_pratcoin[investor] += pratcoin_bought;
        equity_usd[investor] = equity_pratcoin[investor] /1000;
        total_pratcoin_bought += pratcoin_bought;
    }
    //offer pratcoin
    function sell_pratcoin(address investor, uint pratcoin_to_sell) external {
        equity_pratcoin[investor] -= pratcoin_to_sell;
        equity_usd[investor] = equity_pratcoin[investor] /1000;
        total_pratcoin_bought -= pratcoin_to_sell;
    }
}
