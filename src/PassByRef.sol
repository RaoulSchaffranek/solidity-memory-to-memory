// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract PassByref {

    struct ConfigMap {
        uint256 data;
    }

    uint256 constant ORIG_VALUE = 100;
    uint256 constant NEW_VALUE = 200;

    function _modifyByReference(ConfigMap memory input) internal pure  {
        input.data = NEW_VALUE;
    }

    function _modidfyByValue(uint256 data) internal pure {
        data = ORIG_VALUE;
    }

    function test_PassByReference() external {
        ConfigMap memory configMap = ConfigMap({data: ORIG_VALUE});
        // assign by reference
        ConfigMap memory configMap2 = configMap;

        /// verify inital values
        assert(configMap.data == ORIG_VALUE);
        assert(configMap2.data == ORIG_VALUE);

        // modify by reference changes both
        _modifyByReference(configMap);
        assert(configMap.data == NEW_VALUE);
        assert(configMap2.data == NEW_VALUE);

        // modify by value changes nothing
        _modidfyByValue(configMap.data);
        assert(configMap.data == NEW_VALUE);
        assert(configMap2.data == NEW_VALUE);
    }

    function test_PassingStrings() external {
        string memory test = "Hello World!";
        _mofifyString(test);
        _mofidyString2(test);
        return;
    }

    function _mofifyString(string memory input) internal pure {
        input = "GM World!";
    }

    function _mofidyString2(string memory input) internal pure {
        bytes(input)[0] = "A";
    }

}
