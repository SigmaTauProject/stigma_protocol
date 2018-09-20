

class GameLogic {
	constructor(world) {
		this.world	= world	;
	}
	init() {
		this.world.player	= this.world.createEntity();
		this.world.createEntity();
	}
	onCreateEntity(entity) {
		entity.pos	= [0,0]	;
		entity.rot	= 0	;
	}
	update() {
	}
	
	onMove(amount) {
		amount = rotateVector(amount, this.world.player.rot);
		this.world.player.pos[0] -= amount[0]/10;
		this.world.player.pos[1] -= amount[1]/10;
	}
	onRotate(angle) {
		this.world.player.rot += angle*5;
	}
}



