module galactic_.game_logic_.entity_;

import std.experimental.logger;
import cst_;

import world_ = galactic_.world_	.entity_	;

class Entity : world_.Entity {
	this() {
		super();
	}
	this(	float[2]	pos	,
		float	ori	,
		float[2]	vel	,
		float	anv	,) {
		
		this();
		
		this.pos	= pos	;
		this.ori	= ori	;
		this.vel	= vel	;
		this.anv	= anv	;
	}
	
	private world_.Entity getWorldEntity() {return this.cst!(world_.Entity);}
	alias getWorldEntity this;
}

