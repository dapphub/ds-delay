pragma solidity ^0.4.19;

import "ds-test/test.sol";

import "./MkrVoter.sol";

contract MkrVoterTest is DSTest {
    MkrVoter voter;

    function setUp() public {
        voter = new MkrVoter(0);
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
