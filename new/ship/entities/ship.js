
import Entity from "./entities/entity.js";

export default class Ship extends Entity {
	constructor(pos, rot, components) {
		this.pos	= pos	;
		this.rot	= rot	;
		this.createComponents(components);
	}
	createComponents(components) {
		this.components = components.map(type=>{
			if (type=="shipView") {
				return new ShipView(this);
			}
			else if (type=="thruster") {
				return new Thruster(this);
			}
		});
	}
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
		this.type	= "thruster"	;
	}
	msg_setState(msg) {
		this.state = msg.state;
	}
}