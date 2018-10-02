
import UI from "./ui.mjs";
import Ship from "./ship.mjs";
import Network from "./network.mjs";


export default class Main {
	constructor(serverCom) {
		this.serverCom = serverCom;
		
		this.serverCom.on("connect"	,()=>{console.log("connected")});
		this.serverCom.on("disconnect"	,(reason)=>{console.log("disconnected",reason)});
		this.serverCom.on("msg"	,(msg)=>{console.log(msg)});
		
		this.ship	= new Ship	(	);
	////	////this.gameLogic	= new GameLogic	(this.world	);
	////	////this.input	= new Input	(this.gameLogic	);
		this.ui	= new UI	(this.ship, /*this.gameLogic, this.input*/	);
		this.network	= new Network	(this.ship, serverCom	);
	////	this.ui.	init();
	////	this.network	.init();
	////	/*this.gameLogic	.init();*/
	////	/*this.input	.init();*/
	////	
		setInterval(this.update.bind(this), 50);
	////	////setTimeout(this.update.bind(this), 1000);
	}
	update() {
	////	////this.ui	.updateInput();
	////	////this.input	.update();
	////	////this.gameLogic	.update();
		this.network	.update();
		this.ui	.updateRender();
	}
}


