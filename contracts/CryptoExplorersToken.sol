pragma solidity ^0.4.11;

import "./MiniMeToken.sol";

contract TokenBurner {
    function burn(address , uint )
    returns (bool result) {
        return false;
    }
}

contract CryptoExplorersToken is MiniMeToken {

    uint256 constant D160 = 0x0010000000000000000000000000000000000000000;

    TokenBurner public tokenBurner;

    function CryptoExplorersToken(address _tokenFactory)
      MiniMeToken(
        _tokenFactory,
        0x0,                     // no parent token
        0,                       // no snapshot block number from parent
        "Crypto Explorers Token",  // Token name
        0,                       // Decimals
        "CET",                   // Symbol
        false                    // Enable transfers
      )
    {}

    function setTokenBurner(address _tokenBurner) onlyOwner {
      tokenBurner = TokenBurner(_tokenBurner);
    }

    // data is an array of uint256s. Each uint256 represents a transfer.
    // The 160 LSB is the destination of the address that wants to be sent
    // The 96 MSB is the amount of tokens that wants to be sent.
    function multiMint(uint256[] data) public onlyController {
      for (uint256 i = 0; i < data.length; i++) {
        address addr = address(data[i] & (D160 - 1));
        uint256 amount = data[i] / D160;
        assert(generateTokens(addr, amount));
      }
    }

    // allows a token holder to burn tokens
    // requires tokenBurner to be set to a valid contract address
    // tokenBurner can take any appropriate action
    function burn(uint256 _amount) {
      uint curTotalSupply = getValueAt(totalSupplyHistory, block.number);
      require(curTotalSupply >= _amount);
      updateValueAtNow(totalSupplyHistory, curTotalSupply - _amount);
      var previousBalanceFrom = balanceOf(msg.sender);
      require(previousBalanceFrom >= _amount);
      updateValueAtNow(balances[msg.sender], previousBalanceFrom - _amount);
      assert(tokenBurner.burn(msg.sender, _amount));
      Transfer(msg.sender, 0, _amount);
    }

}
