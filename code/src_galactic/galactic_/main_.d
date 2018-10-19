module galactic_.main_;

import std.experimental.logger;

import galactic_.network_	.network_;
import galactic_.ship_	.ship_mgr_;
import galactic_.logic_world_	.world_;

import loose_.sleep_ : sleep;
import core.time;

class Main {
	this(int gameTick) {
		auto network	= new NetworkMaster	;
		auto world	= new World	;
		auto shipMgr	= new ShipMgr(world, gameTick)	;
		
		while (true) {
			sleep(gameTick.msecs);
			world	.update()	;
			shipMgr	.update(network.getNewNetworks())	;
		}
	}
}

