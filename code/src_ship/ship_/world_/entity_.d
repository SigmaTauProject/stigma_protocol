module ship_.world_.entity_;

import std.experimental.logger;
import cst_;


class Entity {
	this() {}
	this(	float[2]	pos	,
		float	ori	,
		ushort	id	,) {
		
		this.pos	= pos	;
		this.ori	= ori	;
		this.id	= id	;
	}
	float[2]	pos	;
	float	ori	;
	ushort	id	;
	bool	updated	; // Used when galactic sends update (in ship_.galactic_.galactic_mgr_.d)
}

