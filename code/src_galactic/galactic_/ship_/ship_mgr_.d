module galactic_.ship_.ship_mgr_;
import commonImports;

import loose_.sleep_;
import core.time;

import galactic_.ship_	.ship_	:	Ship	;
import galactic_.flat_world_	.world_	:	World	;
import galactic_.network_	.network_	:	Network	;

import std.algorithm.iteration	;
import std.range	:	array	;

class ShipMgr {
	this(World world, int gameTick) {
		this.world	= world	;
		this.gameTick	= gameTick	;
	}
	void update(Network[] newNetworks) {
		this.ships ~= newNetworks.map!(n=>new Ship(world, n)).array;
		foreach (ship; ships) {
			ship.update();
		}
	}
	
	private {
		World	world	;
		int	gameTick	;
		Ship[]	ships	;
	}
}

