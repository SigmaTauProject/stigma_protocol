module galactic_.entity_;

import std.experimental.logger;
import cst_;

class Entity {
	this() {}
	this(	float[2]	pos	,
		float	ori	,
		float[2]	vel	,
		float	anv	,) {
		
		this.pos	= pos	;
		this.ori	= ori	;
		this.vel	= vel	;
		this.anv	= anv	;
	}
	float[2]	pos	;
	float	ori	;
	float[2]	vel	;
	float	anv	;
}

