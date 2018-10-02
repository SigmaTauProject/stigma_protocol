module ship_.entity;

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
}

