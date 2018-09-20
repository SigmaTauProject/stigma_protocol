

export default class Ship {
	constructor() {
		this.components = [];
	}
	
	msg_components(msg) {
		this.components = msg.components.map(type=>{
			if (type=="shipView") {
				return new ShipView(this);
			}
			else if (type=="thruster") {
				return new Thruster(this);
			}
		});
	}
	////addEntity(args) {
	////	if (!args) args={};
	////	
	////	var entity = {};
	////	if (args.entity)
	////		entity = args.entity;
	////	
	////	if (!args.pos	) {	args.pos	= vec()	;	}
	////	if (!args.rot	) {	args.rot	= 0	;	}
	////	entity.pos = args.pos;
	////	entity.rot = args.rot;
	////	
	////	if (args.player	) {	this.player	= entity	;	}
	////	
	////	this.ui	.onAddEntity(entity);
	////	this.entities.push(entity);
	////	
	////	return entity;
	////}
}


class ShipView {
	constructor(ship) {
		this.ship	= ship	;
		this.ships	= []	;
		this.us	= {pos:vec(),rot:0}	;
		this.type	= "shipView"	;
	}
	msg_setUs(msg) {
		var ship = {};
		this.us.pos	= msg.pos	;
		this.us.rot	= msg.rot	;
	}
	msg_addShip(msg) {
		var ship = {};
		ship.pos	= msg.pos	;
		ship.rot	= msg.rot	;
		this.ships.push(ship);
	}
}
class Thruster {
	constructor(ship) {
		this.ship	= ship	;
		this.state	= 0	;
	}
	msg_setState(msg) {
		this.state = msg.state;
	}
}