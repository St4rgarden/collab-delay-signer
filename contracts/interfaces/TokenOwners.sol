// SPDX-License-Identifier: MIT
// @author st4rgard3n, Collab.Land
pragma solidity >=0.8.0;

interface IERC712 {

    /**
     * @dev Returns the number of tokens in ``owner``'s account.
     */
    function balanceOf(address owner) external view returns (uint256 balance);

}

interface IERC20 {

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

}

interface IERC1155 {

    /**
     * @dev Returns the amount of tokens of token type `id` owned by `account`.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function balanceOf(address account, uint256 id) external view returns (uint256);

}

contract TokenOwners {

    enum TokenTypes {ERC20, ERC721, ERC1155}

}