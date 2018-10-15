module galactic_.game_logic_.world_;

import std.experimental.logger;
import cst_;

import world_ = galactic_.world_	.world_	;
import world_entity_ = galactic_.world_	.entity_	;

import galactic_.game_logic_	.entity_	;

class World : world_.World{
	this() {
		
	}
	Entity[]	_entities	;
	override Entity[] entities() {
		return this._entities;
	}
	
	private world_.World getWorldWorld() {return this.cst!(world_.World);}
	alias getWorldWorld this;
}

