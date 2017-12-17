// Self-contained action staging contract. A good candidate to own a `DSProxy` object.

pragma solidity ^0.4.19;

contract MkrVoter {
    address public ice;
    address public cool;
    address public hot;
    Action[] public acts;

    struct Action {
        address whom_box; // target
        uint256 mana_wad; // eth value
        bytes   data_fax; // calldata
        bool    done_fin; // done
    }


    function load(Action a) returns (uint256 actID);
}
