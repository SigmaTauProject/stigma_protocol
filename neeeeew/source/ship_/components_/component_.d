module ship_.components_.component_;

import world_.world_	:	World	;

enum ComponentType {
	metaRadar	,
}


abstract class Component {
	this(World world) {
		this.world	= world;
	}
	abstract @property ComponentType type();
	private {
		World	world;
	}
}