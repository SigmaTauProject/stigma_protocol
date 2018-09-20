


export default class GameLogic {
	constructor(world) {
		this.world	= world	;
	}
	init() {
		this.world.createUs({pos:vec(),rot:0,components:"shipView"});
		this.world.createEntity({pos:vec(3,3),rot:0});
	}
	onCreateUs(us) {
	}
	onCreateEntity(entity) {
	}
	update() {
		this.world.setUsPos([this.world.us.pos[0]+0.01, this.world.us.pos[1]+0.01]);
		this.world.setUsRot(this.world.us.rot+0.1);
	}
}



