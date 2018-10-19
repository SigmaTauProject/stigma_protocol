module ship_.world_.entity_;

import std.experimental.logger;
import cst_;


class Entity {
	this() {}
	this(	ushort	id	,
		float[2]	pos	,
		float	ori	,) {
		
		this.pos	= pos	;
		this.ori	= ori	;
	}
	ushort	id	;
	float[2]	pos	;
	float	ori	;
}

