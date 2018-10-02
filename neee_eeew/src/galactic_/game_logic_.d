module galactic_.game_logic_;

import std.experimental.logger;
import cst_;

import galactic_.entity_;
import galactic_.world_;

class GameLogic {
	this(World world) {
		this.world	= world	;
		
		world.entities ~= new Entity([1,0],2,[0.5,0.01],-0.1);
	}
	void update() {
		foreach (entity; world.entities) {
			entity.pos[]	+= entity.vel[]	;
			entity.ori	+= entity.anv	;
		}
	}
	World world;
}

