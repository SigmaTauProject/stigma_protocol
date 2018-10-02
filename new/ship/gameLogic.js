


export default class GameLogic {
	constructor(world) {
		this.world	= world	;
		
		var entity = new Entity(vec(0,0),0);
		entity.logic = new playerLogic(entity);
		world.addEntity(entity);
	}
	update() {
	}
}



