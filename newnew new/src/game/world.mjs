
import IdArray from "./idArray.mjs";

export default class World {
	constructor() {
		this.entities	= new IdArray()	;
		this.us	;
	}
}

export class Entity {
	constructor(pos,rot,vel,rotVel) {
		this.pos	= pos	;
		this.rot	= rot	;
		this.vel	= vel	;
		this.rotVel	= rotVel	;
	}
}


////export default class World {
////	constructor() {
////		this.entities	= [];
////		this.listeners	= {"newEntity":[]};
////		this.pos	= {};
////	}
////	addListener(event, callback) {
////		this.listeners[event].push(callback);
////	}
////	newEntity(pos=vec(), rot=0) {
////		var entity = new Entity(pos,rot,this);
////		
////		this.entities.push(entity);
////		this.listeners.newEntity.each(listener=>listener(entity));
////		return entity;
////	}
////}



////class Entity {
////	constructor(pos,rot,world) {
////		this.pos	= pos	;
////		this.rot	= rot	;
////		this.world	= world	;
////	}
////}






