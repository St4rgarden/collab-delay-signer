// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity >=0.8.0;

interface IDelay {
    function setAgentSigner(address signer) external;
}

contract TestAvatar {
    address public module;
    mapping(address => bool) public owners;

    constructor() {
        owners[msg.sender] == true;
    }

    receive() external payable {}

    function setModule(address _module) external {
        module = _module;
    }

    function setOwner(address newOwner) public {
        owners[newOwner] = true;
    }

    function isOwner(address owner) public view returns (bool) {
        return owners[owner];
    }

    function setDelaySigner(address delay, address signer) public {
        IDelay(delay).setAgentSigner(signer);
    }

    function exec(address payable to, uint256 value, bytes calldata data) external {
        bool success;
        bytes memory response;
        (success, response) = to.call{value: value}(data);
        if(!success) {
            assembly {
                revert(add(response, 0x20), mload(response))
            }
        }
    }

    function execTransactionFromModule(address payable to, uint256 value, bytes calldata data, uint8 operation)
        external
        returns (bool success)
    {
        require(msg.sender == module, "Not authorized");
        if (operation == 1)
            (success,) = to.delegatecall(data);
        else
            (success,) = to.call{value: value}(data);
    }
}