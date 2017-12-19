pragma solidity ^0.4.19;

import "ds-test/test.sol";

import "./ds-delay.sol";

contract DSDelayTest is DSTest {
    DSDelay delay;

    function setUp() public {
        delay = new DSDelay(0);
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
