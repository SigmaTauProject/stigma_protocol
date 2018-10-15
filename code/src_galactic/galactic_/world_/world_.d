module galactic_.world_.world_;

import std.experimental.logger;
import cst_;

import galactic_.world_	.entity_;

abstract class World {
	this() {
		
	}
	abstract Entity[]	entities()	;
}

