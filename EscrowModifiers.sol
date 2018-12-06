pragma solidity ^0.5.0;

contract EscrowModifiers {
    
    enum State {CONTRACT_CREATED, PRUCHASED_ITEM, CONFIRM_PURCHASE}
    State public state;
    
    modifier isSeller(address payable _seller) {
        require(msg.sender == _seller);
        _;
    }
    
    modifier isBuyer(address payable _buyer) {
        require(msg.sender == _buyer);
        _;
    }
    
    modifier isContractCreated(State _state) {
        require(_state == State.CONTRACT_CREATED);
        _;
    }
    
    modifier isItemPurchased(State _state) {
        require(_state == State.PRUCHASED_ITEM);
        _;
    }
    
    modifier isPurchaseConfirmed(State _state) {
        require(_state == State.CONFIRM_PURCHASE);
        _;
    }
}
