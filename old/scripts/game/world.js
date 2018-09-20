



class World {
	constructor() {
		this.entities	= []	;
		this.player	= null	;
	}
	giveHandlers(gameLogic,ui) {
		this.gameLogic	= gameLogic	;
		this.ui	= ui	;
	}
	createEntity(entity) {
		var entity = {};
		this.gameLogic	.onCreateEntity(entity);
		this.ui	.onCreateEntity(entity);
		this.entities.push(entity);
		return entity;
	}
}




