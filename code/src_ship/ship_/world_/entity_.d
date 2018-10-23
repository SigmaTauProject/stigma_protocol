module ship_.world_.entity_;

import std.experimental.logger;
import cst_;


class Entity {
	this() {}
	this(	float[2]	pos	,
		float	ori	,) {
		
		this.pos	= pos	;
		this.ori	= ori	;
	}
	float[2]	pos	;
	float	ori	;
	
	bool inWorld = false;
	bool getInWorld() {
		return inWorld;
	}
}

