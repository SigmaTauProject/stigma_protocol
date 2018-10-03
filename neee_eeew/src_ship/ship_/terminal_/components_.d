module ship_.terminal_.components_;

import std.experimental.logger;
import cst_;

import ship_.world_	.world_;

public import terminal_msg_	.component_type_	:	ComponentType	;

abstract class Component {
	this(World world, Component[] delegate(ComponentType) getComponent) {
		this.world	= world	;
		this.getComponent	= getComponent	;
	}
	abstract @property ComponentType type();
	ComponentType opCast(T:ComponentType)() {
		return type;
	}
	abstract void update();
	private {
		World	world	;
		Component[] delegate(ComponentType)	getComponent	;
	}
}

class MetaRadar : Component {
	this(World world, Component[] delegate(ComponentType) getComponent) {
		super(world, getComponent);
	}
	override @property ComponentType type() {
		return ComponentType.metaRadar;
	}
	override void update() {
		
	}
}



