pragma solidity ^0.4.15;

import "./MintableToken.sol";

contract CVT2Token is MintableToken {

    uint256 constant D160 = 0x0010000000000000000000000000000000000000000;

    string public name = "Crypto Explorers CVT2 Token";
    string public symbol = "CVT2";
    uint256 public decimals = 0;

    // data is an array of uint256s. Each uint256 represents a transfer.
    // The 160 LSB is the destination of the address that wants to be sent
    // The 96 MSB is the amount of tokens that wants to be sent.
    function multiMint(uint256[] data) public onlyOwner {
      for (uint256 i = 0; i < data.length; i++) {
        address addr = address(data[i] & (D160 - 1));
        uint256 amount = data[i] / D160;
        assert(mint(addr, amount));
      }
    }

}
