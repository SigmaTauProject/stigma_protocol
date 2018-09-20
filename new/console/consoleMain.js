
import UI from "/console/ui.js";
import Ship from "/console/ship.js";
import Network from "/console/network.js";


export default class ConsoleMain {
	constructor(msgQueue) {
		this.msgQueue	= msgQueue	;
		
		this.ship	= new Ship	(	);
		////this.gameLogic	= new GameLogic	(this.world	);
		////this.input	= new Input	(this.gameLogic	);
		this.ui	= new UI	(this.ship, /*this.gameLogic, this.input*/	);
		this.network	= new Network	(this.ship, msgQueue	);
		this.ui.	init();
		this.network	.init();
		/*this.gameLogic	.init();*/
		/*this.input	.init();*/
		
		setInterval(this.update.bind(this), 50);
		////setTimeout(this.update.bind(this), 1000);
	}
	update() {
		////this.ui	.updateInput();
		////this.input	.update();
		////this.gameLogic	.update();
		this.network	.update();
		this.ui	.updateRender();
	}
}


