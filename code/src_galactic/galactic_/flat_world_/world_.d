module galactic_.flat_world_.world_;

import std.experimental.logger;
import cst_;

import galactic_.flat_world_	.entity_;

class World {
	this() {
		
	}
	private Entity[]	_entities	;
	@property Entity[] entities() {
		return _entities~[];	// Shallow compy the array, so that only the data in the `Entity` will be affected.
			// It would be far better to just pass an const(headconst(Entity)[]) but D does not support this.
	}
	void addEntity(Entity entity) {
		this._entities~=entity;
	}
	void removeEntity(Entity entity) {
		import std.algorithm;
		_entities = _entities.remove(_entities.countUntil(entity));
	}
}


