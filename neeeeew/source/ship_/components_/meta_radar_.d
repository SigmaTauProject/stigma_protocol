module ship_.components_.meta_radar_;

import ship_.components_.component_	:	Component	,
		ComponentType	;
import world_.world_	:	World	;


class MetaRadar : Component {
	this(World world) {
		super(world);
	}
	override @property ComponentType type() {
		return ComponentType.metaRadar;
	}
}