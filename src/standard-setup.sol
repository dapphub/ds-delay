pragma solidity ^0.4.19;

import 'ds-group/group.sol';
import './MkrVoter.sol';

contract StandardSetup {
    function build( address cold1, address cold2, address cold3
                  , address cool1, address cool2
                  , address warm
                  , uint40 ms_window, uint40 min_wait
                  )
        returns (MkrVoter)
    {
        address[] memory colds = [cold1, cold2, cold3];
        address[] memory cools = [cool1, cool2];
        var Colds = new DSGroup(colds, 2, ms_window);
        var Cools = new DSGroup(cools, 2, ms_window);
        var voter = new MkrVoter(min_wait);
        voter.swap(Colds, Cools, warm);
    }
}


