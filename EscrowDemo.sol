pragma solidity ^0.5.0;

import "./EscrowModifiers.sol";

contract EscrowDemo is EscrowModifiers {
    address payable public seller;
    address payable public buyer;
    string public item;
    uint256 public price;
    
    event ContractCreated(string description);
    event PurchaseItem(string description);
    event ConfirmationItemReceived(string description);
    
    // Only seller can trigger this contract
    constructor(address payable _buyer, string memory _item, uint256 _price) public {
        seller = msg.sender;
        buyer = _buyer;
        item = _item;
        price = _price;
        state = State.CONTRACT_CREATED;
        emit ContractCreated('Contract Created...');
    }
    
    // Get the balance of the contract
    function getContractBalance() view public returns(uint256) {
        return address(this).balance;
    }
    
    // Only Seller Can Call
    function abortSale() isSeller(seller) payable isContractCreated(State.CONTRACT_CREATED) public {
        // require(state == State.CONTRACT_CREATED);
        selfdestruct(seller);
    }
    
    
    // Purchasing an item
    function purchaseItem() isBuyer(buyer) payable isContractCreated(State.CONTRACT_CREATED) public {
        // require(state == State.CONTRACT_CREATED);
        require(msg.value > price + 0.5 ether);
        state = State.PRUCHASED_ITEM;
        emit PurchaseItem('Item is purchased...');
    }
    
    // User to confirm the receipt of item
    function confirmationItemReceived() isBuyer(buyer) isContractCreated(State.PRUCHASED_ITEM) public {
        // require(state == State.PRUCHASED_ITEM);
        seller.transfer(address(this).balance);
        state = State.CONFIRM_PURCHASE;
        emit ConfirmationItemReceived('Confirming the item is received...');
    }
    
}
