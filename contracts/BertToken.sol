// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

// Token Design

// 1) initial supply (sent to owner) => 50_000_000              DONE

// 2) max supply (capped) 100_000_000                           DONE

// 3) make token burnable                                       DONE

// 4) Create block reward to distribute new supply to miners    DONE

contract BertToken is ERC20Capped, ERC20Burnable {
    address payable public immutable i_owner;
    uint256 public blockReward;

    constructor(
        uint256 cap,
        uint256 reward
    ) ERC20("BertToken", "BTK") ERC20Capped(cap * (10 ** decimals())) {
        i_owner = payable(msg.sender);
        _mint(msg.sender, 50_000_000 * (10 ** decimals()));
        blockReward = reward * (10 ** decimals());
    }

    function _mint(
        address account,
        uint256 amount
    ) internal virtual override(ERC20Capped, ERC20) {
        require(
            ERC20.totalSupply() + amount <= cap(),
            "ERC20Capped: cap exceeded"
        );
        super._mint(account, amount);
    }

    function _mintMinerReward() internal {
        _mint(block.coinbase, blockReward);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 value
    ) internal virtual override {
        if (
            from != address(0) &&
            to != block.coinbase &&
            block.coinbase != address(0)
        ) {
            _mintMinerReward();
        }
        super._beforeTokenTransfer(from, to, value);
    }

    function setBlockReward(uint256 reward) public {}

    function destroy() public onlyOwner {
        selfdestruct(i_owner);
    }

    modifier onlyOwner() {
        require(msg.sender == i_owner, "Only the owner can call this function");
        _;
    }
}
