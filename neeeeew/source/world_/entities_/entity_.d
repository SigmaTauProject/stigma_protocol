module world_.entities_.entity_;

class Entity {
	this	(	float[2]	pos	,
			float	ori	,
			float[2]	vel	,
			float	anv	,){
	
		this.pos	= pos	;
		this.ori	= ori	;
		this.vel	= vel	;
		this.anv	= anv	;
	}
	
	private {
		float[2]	pos	;// postion
		float	ori	;// orientation
		float[2]	vel	;// velocity
		float	anv	;// angular velocity
	}
}


