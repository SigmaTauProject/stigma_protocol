module galactic_.simulation_;

import world_.world_	:	World	;

class Simulation {
	this(World world) {
		this.world	= world;
	}
	
	private {
		World world;
	}
}