
import UI	from "./ui.mjs"	;
import Ship	from "./ship.mjs"	;
import Socket	from "./socket.mjs"	;
import Network	from "./network.mjs"	;


export default class Main {
	constructor() {
		this.socket	= new Socket	(	);
		this.ship	= new Ship	(	);
	////	////this.gameLogic	= new GameLogic	(this.world	);
	////	////this.input	= new Input	(this.gameLogic	);
		this.ui	= new UI	(this.ship, /*this.gameLogic, this.input*/	);
		this.network	= new Network	(this.ship, this.socket	);
		
		this.socket.onConnected((()=>{
		////	this.ui.	init();
			this.network	.init();
		////	/*this.gameLogic	.init();*/
		////	/*this.input	.init();*/
		////	
			setInterval(this.update.bind(this), 50);
		////	////setTimeout(this.update.bind(this), 1000);
		}).bind(this));
	}
	update() {
	////	////this.ui	.updateInput();
	////	////this.input	.update();
	////	////this.gameLogic	.update();
		this.network	.update();
		this.ui	.updateRender();
	}
}


