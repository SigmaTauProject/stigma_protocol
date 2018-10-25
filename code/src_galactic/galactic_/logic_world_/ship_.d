module galactic_.logic_world_.ship_;
import commonImports;

import galactic_.flat_world_	.entity_	: FlatEntity = Entity	;
import galactic_.logic_world_	.entity_;

class Ship : Entity,FlatEntity {
	override @property EntityType type() {return EntityType.ship;}
	
	this() {
		super();
	}
	this(float[2] pos,float ori, float[2] vel,float anv,) {
		super(pos, ori);
		this.vel	= vel	;
		this.anv	= anv	;
	}
	
	mixin EntityTemplate	;
	mixin PhysicsTemplate	;
	mixin FlatEntityTemplate	;
}

