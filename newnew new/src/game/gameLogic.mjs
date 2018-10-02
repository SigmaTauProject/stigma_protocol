
import {Entity as BaseEntity} from "./world.mjs"	;


export default class GameLogic {
	constructor(world) {
		this.world	= world	;
		this.world.us	= new Entity(vec(),0);
	}
	
	init() {
		this.world.entities.push(new Entity(vec(2,1),2));
	}
	update() {
		this.world.us.pos[1]+=0.05;
	}
	
	onNewEntity(entity) {
	}
}


class Entity extends BaseEntity {
	constructor(...args) {
		super(...args);
	}
}


