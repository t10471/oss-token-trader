pragma solidity ^0.4.8;

import './ERC20Interface.sol';

contract TokenTrader {

    mapping(address => mapping(address => uint)) nonces; // maker => (taker => nonce)

    function getNonce(address _makerAddress, address _takerAddress) constant returns (uint nonce) {
        return nonces[_makerAddress][_takerAddress];
    }

    function trade(
        address _makerTokenAddr, uint _makerAmount, address _makerAddress, address _takerTokenAddr, uint _takerAmount,
        uint _expiration, uint _tradeNonce, bytes _takerSign, bytes _makerSign) returns (bool success) {

        bytes32 hash = calcEnvHash('trade');
        hash = sha3(hash, _makerTokenAddr);
        hash = sha3(hash, _makerAmount);
        hash = sha3(hash, _makerAddress);
        hash = sha3(hash, _takerTokenAddr);
        hash = sha3(hash, _takerAmount);
        hash = sha3(hash, _expiration);
        hash = sha3(hash, _tradeNonce);
        address takerAddress = recoverAddress(hash, _takerSign);

        hash = sha3(hash, _takerSign);
        address makerAddress = recoverAddress(hash, _makerSign);

        if (makerAddress != _makerAddress || _tradeNonce != getNonce(makerAddress, takerAddress) || _expiration < now) return false;
        nonces[makerAddress][takerAddress]++;

        assert(ERC20Interface(_makerTokenAddr).transferFrom(makerAddress, takerAddress, _makerAmount) && ERC20Interface(_takerTokenAddr).transferFrom(takerAddress, makerAddress, _takerAmount));
        return true;
    }

    function calcEnvHash(bytes32 _functionName) constant returns (bytes32 hash) {
        hash = sha3(this);
        hash = sha3(hash, _functionName);
    }

    function recoverAddress(bytes32 _hash, bytes _sign) constant returns (address recoverdAddr) {
        bytes32 r;
        bytes32 s;
        uint8 v;

        assert(_sign.length == 65);

        assembly {
            r := mload(add(_sign, 32))
            s := mload(add(_sign, 64))
            v := byte(0, mload(add(_sign, 96)))
        }

        if (v < 27) v += 27;
        assert(v == 27 || v == 28);

        recoverdAddr = ecrecover(_hash, v, r, s);
        assert(recoverdAddr != 0);
    }
}
