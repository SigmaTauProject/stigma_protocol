

export default class World {
	constructor() {
		this.entities	= []	;
	}
	giveHandlers(gameLogic, network) {
		this.gameLogic	= gameLogic;
		this.network	= network	;
	}
	
	createEntity(args) {
		if (!args) args={};
		
		var entity = {};
		if (args.entity)
			entity = args.entity;
		
		if (!args.pos	) {	args.pos	= vec()	;	}
		if (!args.rot	) {	args.rot	= 0	;	}
		entity.pos = args.pos;
		entity.rot = args.rot;
		
		if (args.player	) {	this.player	= entity	;	}
		
		this.gameLogic	.onCreateEntity(entity);
		this.network	.onCreateEntity(entity);
		this.entities.push(entity);
		
		return entity;
	}
	
	setUsPos(pos) {
		this.us.pos = pos;
		this.network	.onSetUsChange();
	}
	setUsRot(rot) {
		this.us.rot = rot;
		this.network	.onSetUsChange();
	}
}
