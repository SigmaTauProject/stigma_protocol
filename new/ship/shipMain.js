
import World from "/ship/world.js";
import GameLogic from "/ship/gameLogic.js";


export default class ShipMain {
	constructor() {
		this.world	= new World	(	);// Data structure
		this.gameLogic	= new GameLogic	(this.world	);// Logic
		
		setInterval(this.update.bind(this), 50);
	}
	update() {
		this.gameLogic	.update();
	}
}



