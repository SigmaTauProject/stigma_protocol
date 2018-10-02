

import GameLogic	from "./gameLogic.mjs"	;
import Network	from "./network.mjs"	;
import World	from "./world.mjs"	;


class Game {
	
	constructor(clientNetworkMaster) {
		this.world	= new World	();
		this.ameLogic	= new GameLogic	(world);
		this.termCom	= new TermCom	(world, clientNetworkMaster);
		
		this.gameLogic	.init();
		this.network	.init();
		
		setInterval(this.update.bind(this),50);
	}
	update() {
		this.gameLogic	.update();
		this.termCom	.update();
	}
	
}






