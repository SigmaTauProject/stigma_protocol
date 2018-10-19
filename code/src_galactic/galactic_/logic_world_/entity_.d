module galactic_.logic_world_.entity_;

import std.experimental.logger;
import cst_;

import galactic_.flat_world_	.entity_	: FlatEntity = Entity	;

enum EntityType {
	starSystem	,
	sun	,
	planet	,
	asteroid	,
	ship	,
}


abstract class Entity{
	abstract @property EntityType type();
	this() {
		this([0,0],0);
	}
	this(float[2] pos, float ori) {
		this.pos	= pos	;
		this.ori	= ori	;
	}
	void update() {
		foreach (entity; nestedEntities) 
			entity.update;
	}
	Entity[] nestedEntities = [];
	
	float[2]	pos	;
	float	ori	;
			
	bool	inWorld	= false	; // Changed in `world.addEntity` and `.removeEntity`
}
private abstract
class PhysicEntity : Entity {
	this() {
		super();
	}
	this(float[2] pos,float ori, float[2] vel,float anv,) {
		super(pos,ori);
		this.vel	= vel	;
		this.anv	= anv	;
	}
	override void update() {
		super.update;
	}
	
	float[2]	vel	;
	float	anv	;
}


class StarSystem : Entity {
	override @property EntityType type() {return EntityType.starSystem;}
	this() {
		super();
	}
	this(float[2] pos, float ori) {
		super(pos,ori);
	}
	override void update() {
		super.update;
	}
}


private abstract
class Orbiting : Entity {
	this() {
		super();
	}
	this(float[2] pos, float ori) {
		super(pos,ori);
	}
	override void update() {
		super.update;
	}
}

class Sun : Orbiting,FlatEntity {
	override @property EntityType type() {return EntityType.sun;}
	this() {
		super();
	}
	this(float[2] pos, float ori) {
		super(pos,ori);
	}
	override void update() {
		super.update;
	}
	
	float[2]	getPos	() { return pos	; }
	float	getOri	() { return ori	; }
	bool	getInWorld	() { return inWorld	; }
}
class Planet : Orbiting,FlatEntity {
	override @property EntityType type() {return EntityType.planet;}
	this() {
		super();
	}
	this(float[2] pos, float ori) {
		super(pos,ori);
	}
	override void update() {
		super.update;
	}
	
	float[2]	getPos	() { return pos;	}
	float	getOri	() { return ori;	}
	bool	getInWorld	() { return inWorld	; }
}




class Asteroid : PhysicEntity,FlatEntity {
	override @property EntityType type() {return EntityType.asteroid;}
	this() {
		super();
	}
	this(float[2] pos,float ori, float[2] vel,float anv,) {
		super(pos,ori,vel,anv);
	}
	override void update() {
		super.update;
	}
	
	float[2]	getPos	() { return pos;	}
	float	getOri	() { return ori;	}
	bool	getInWorld	() { return inWorld	; }
}
class Ship : PhysicEntity,FlatEntity {
	override @property EntityType type() {return EntityType.ship;}
	this() {
		super();
	}
	this(float[2] pos,float ori, float[2] vel,float anv,) {
		super(pos,ori,vel,anv);
	}
	override void update() {
		super.update;
	}
	
	float[2]	getPos	() { return pos;	}
	float	getOri	() { return ori;	}
	bool	getInWorld	() { return inWorld	; }
}
