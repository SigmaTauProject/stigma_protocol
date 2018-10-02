
export {default as Ship	} from "./entities/ship.js"	;
export {default as Asteroid	} from "./entities/asteroid.js"	;

export default class Entity {
	constructor(pos, rot) {
		this.pos	= pos	;
		this.rot	= rot	;
	}
}

