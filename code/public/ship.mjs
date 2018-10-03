
import IdArray from "./idArray.mjs";


export default class Ship {
	constructor(network) {
		this.network	= network	;
		this.componentTypes	= []	;
		this.components	= []	;
	}
	
	msg_components(msg) {
		this.components = msg.components.each(type=>{
			if (type==0 || type=="metaRadar") {
				return new MetaRadar(this);
			}
			else {
				return new UnknownComponent(this);
			}
			////else if (type=="thruster") {
			////	return new Thruster(this);
			////}
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

class BaseComponent {
	constructor(type, ship) {
		this.type	= type	;
		this.ship	= ship	;
	}
}

class MetaRadar extends BaseComponent {
	constructor(ship, ...args) {
		super("metaRadar", ...args);
		this.us	= {pos:vec(),rot:0}	;
		this.entities	= {}	;
		this.removed	= []	;
	}
	msg_update(msg) {
		this.removed = [];
		this.us	= msg.us	;
		for (var id of Object.keys(msg.entities)) {
			if (id in this.entities) {
				this.entities[id].pos	= msg.entities[id].pos	;
				this.entities[id].rot	= msg.entities[id].rot	;
			}
			else {
				this.entities[id] = msg.entities[id];
			}
		}
		for (var id of Object.keys(this.entities)) {
			if (!(id in msg.entities)) {
				this.removed.push(this.entities[id]);
				delete this.entities[id];
			}
		}
	}
}
class UnknownComponent extends BaseComponent {
	constructor(ship, ...args) {
		super("unknownComponent", ...args);
	}
}

////class ShipView {
////	constructor(ship) {
////		this.ship	= ship	;
////		this.ships	= []	;
////		this.us	= {pos:vec(),rot:0}	;
////		this.type	= "shipView"	;
////	}
////	msg_setUs(msg) {
////		var ship = {};
////		this.us.pos	= msg.pos	;
////		this.us.rot	= msg.rot	;
////	}
////	msg_addShip(msg) {
////		var ship = {};
////		ship.pos	= msg.pos	;
////		ship.rot	= msg.rot	;
////		this.ships.push(ship);
////	}
////}
////class Thruster {
////	constructor(ship) {
////		this.ship	= ship	;
////		this.state	= 0	;
////	}
////	msg_setState(msg) {
////		this.state = msg.state;
////	}
////}