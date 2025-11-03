// SPDX-License-Identifier: BSD-3-Clause-Clear

pragma solidity ^0.8.24;

// Imports HTTP stables (v0.7.x) depuis jsDelivr CDN
import "https://cdn.jsdelivr.net/npm/@fhevm/solidity@0.7.0/lib/FHE.sol";
import "https://cdn.jsdelivr.net/npm/@fhevm/solidity@0.7.0/config/ZamaConfig.sol";

contract FHECounterV7 is SepoliaConfig {
    euint32 private _count;

    // renvoie le ciphertext (bytes32 côté ABI)
    function getCount() external view returns (euint32) {
        return _count;
    }

    // clique ici dans Remix pour tester sans entrée chiffrée
    function incrementOne() external {
        _count = FHE.add(_count, FHE.asEuint32(1));
        FHE.allowThis(_count);
        FHE.allow(_count, msg.sender);
    }

    // entrée chiffrée standard v0.7 (aligne avec ton SDK)
    function incrementEncrypted(externalEuint32 input, bytes calldata inputProof) external {
        euint32 v = FHE.fromExternal(input, inputProof);
        _count = FHE.add(_count, v);
        FHE.allowThis(_count);
        FHE.allow(_count, msg.sender);
    }
}
