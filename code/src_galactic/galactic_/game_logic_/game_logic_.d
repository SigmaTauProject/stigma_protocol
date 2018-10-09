module galactic_.game_logic_.game_logic_;

import std.experimental.logger;
import cst_;

import galactic_.world_	.entity_;
import galactic_.world_	.world_;

class GameLogic {
	this(World world) {
		this.world	= world	;
	}
	void update() {
		world.entities.length.log;
		if (++counter == 5) {
			import std.random;
			world.entities ~= new Entity([0,0],0,[uniform(-100,100)*0.01,uniform(-100,100)*0.01],uniform(-100,100)*0.01);
			if (world.entities.length>10) {
				world.entities = world.entities[1..$];
			}
			counter = 0;
		}
		foreach (entity; world.entities) {
			entity.pos[]	+= entity.vel[]	;
			entity.ori	+= entity.anv	;
		}
	}
	private {
		World world;
		
		uint counter = 0;
	}
}

