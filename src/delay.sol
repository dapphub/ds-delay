// Self-contained action staging contract.

// Copyright (C) 2017  DappHub, LLC

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity ^0.4.19;

contract DSDelay {
    address  public  cold; // load, fire, swap, stop, start
    address  public  cool; // load, fire, stop
    address  public  warm; // fire, stop

    uint40   public  wait; // minimum action wait time - immutable

    bool     public  stopped;



    Action[] public  acts;
    struct Action {
        address whom; // target
        uint256 mana; // eth value
        bytes   data; // calldata
        uint40  open; // action load time
        uint40  shut; // action expire time
        bool    done; // done
    }

    function DSDelay(uint40 wait_)
    {
        cold = msg.sender;
        wait = wait_;
        stopped = false;
    }

    function stop()
    {
        require(msg.sender == warm || msg.sender == cool || msg.sender == cold);
        stopped = true;
    }

    function start()
    {
        require(msg.sender == cold);
        stopped = false;
    }

    function swap(address cold_, address cool_, address warm_)
    {
        require(!stopped);
        require(msg.sender == cold);
        cold = cold_;
        cool = cool_;
        warm = warm_;
    }

    function load(address whom_, uint256 mana_, bytes data_, uint40 life_)
        returns (uint256 acti)
    {
        require(msg.sender == cool || msg.sender == cold);
        uint40 life = life_ > wait ? life_ : wait;
        return acts.push(Action({
            whom: whom_,
            mana: mana_,
            data: data_,
            open: uint40(now),
            shut: uint40(now) + life,
            done: false
        })) - 1;
    }

    function fire(uint256 acti)
    {
        require(msg.sender == warm || msg.sender == cool || msg.sender == cold);
        var act = acts[acti];
        require( uint40(now) < act.shut );
        require( act.whom.call.value(act.mana)(act.data) );
        acts[acti].done = true;
    }
}
