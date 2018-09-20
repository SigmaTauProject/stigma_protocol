
import World from "/ship/world.js";
////import Network from "/ship/network.js";
import GameLogic from "/ship/gameLogic.js";


export default class ShipMain {
	constructor(msgQueue) {
		this.msgQueue	= msgQueue	;
		
		this.world	= new World	(	);
		this.gameLogic	= new GameLogic	(this.world	);
		////this.input	= new Input	(this.gameLogic	);
		/////this.network	= new Network	(this.world, msgQueue	);
		this.world.giveHandlers(this.gameLogic, this.network);
		/////this.network	.init();
		this.gameLogic	.init();
		////this.input	.init();
		
		setInterval(this.update.bind(this), 50);
		////setTimeout(this.update.bind(this), 1000);
	}
	update() {
		////this.ui	.updateInput();
		////this.input	.update();
		this.gameLogic	.update();
		////this.ui	.updateRender();
	}
}



