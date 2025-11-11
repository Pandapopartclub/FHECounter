// SPDX-License-Identifier: BSD-3-Clause-Clear
pragma solidity ^0.8.24;

import "https://cdn.jsdelivr.net/npm/@fhevm/solidity@0.7.0/lib/FHE.sol";
import "https://cdn.jsdelivr.net/npm/@fhevm/solidity@0.7.0/config/ZamaConfig.sol";

contract FHECounter is SepoliaConfig {
    euint32 private _count;

    function getCount() external view returns (euint32) {
        return _count;
    }

    function incrementOne() external {
        _count = FHE.add(_count, FHE.asEuint32(1));
        FHE.allowThis(_count);
        FHE.allow(_count, msg.sender);
    }
}
