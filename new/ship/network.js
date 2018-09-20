

export default class Network {
	constructor(world,msgQueue) {
		this.msgQueue	= msgQueue	;
		this.world	= world	;
	}
	init() {
		this.msgQueue.push({component:-1,type:"components",components:["shipView", "thruster"]});
		////this.msgQueue.push({component:0,type:"addShip",pos:[3,0],rot:115,player:true});
		////this.msgQueue.push({component:0,type:"addShip",pos:[3,2],rot:-10});
	}
	
	onCreateUs(us) {
		this.msgQueue.push({component:0,type:"setUs",pos:us.pos,rot:us.rot});
	}
	onCreateEntity(ship) {
		this.msgQueue.push({component:0,type:"addShip",pos:ship.pos,rot:ship.rot});
	}
	
	onSetUsChange() {
		var us = this.world.us;
		this.msgQueue.push({component:0,type:"setUs",pos:us.pos,rot:us.rot});
	}
}