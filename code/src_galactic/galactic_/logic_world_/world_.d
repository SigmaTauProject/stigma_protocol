module galactic_.logic_world_.world_;

import std.experimental.logger;
import cst_;
import std.traits;

import galactic_.logic_world_	.entity_	;

import galactic_.flat_world_	.world_	: FlatWorld = World	;
import galactic_.flat_world_	.entity_	: FlatEntity = Entity	;

class World{
	this() {
		flatWorld	= new FlatWorld;
		foreach (_; 0..10) {
			import std.random;
			addEntity(new Asteroid([uniform(-100,100)*0.01,uniform(-100,100)*0.01],uniform(-100,100)*0.01,[0,0],0));
		}
		addEntity(new Ship());
	}
	
	private Entity[]	_entities	;
	@property Entity[] entities() {
		return _entities~[];	// Shallow compy the array, so that only the data in the `Entity` will be affected.
			// It would be far better to just pass an const(headconst(Entity)[]) but D does not support this.
	}
	
	FlatWorld	flatWorld	;
	alias flatWorld this;
	
	void update() {
		foreach (entity; entities) {
			entity.update;
		}
	}
	void addEntity(E)(E entity) if(!isAbstractClass!E) {
		this._entities~=entity;
		static if (is(E:FlatEntity)) {
			flatWorld.addEntity(entity);
		}
	}
	void removeEntity(E)(E entity) if(!isAbstractClass!E) {
		import std.algorithm;
		_entities = _enties.remove(_entities.countUntil(entity));
		static if (is(E:FlatEntity)) {
			flatWorld.removeEntity(entity);
		}
	}
}


