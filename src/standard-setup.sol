pragma solidity ^0.4.19;

import 'ds-group/group.sol';
import './ds-delay.sol';

contract StandardSetup {
    function build( address cold1, address cold2, address cold3
                  , address cool1, address cool2
                  , address warm
                  , uint40 ms_window, uint40 min_wait
                  )
        returns (DSDelay)
    {
        address[] colds; colds.push(cold1); colds.push(cold2); colds.push(cold3);
        address[] cools; cools.push(cool1); cools.push(cool2);
        var Colds = new DSGroup(colds, 2, ms_window);
        var Cools = new DSGroup(cools, 2, ms_window);
        var delay = new DSDelay(min_wait);
        delay.swap(Colds, Cools, warm);
        return delay;
    }
}


