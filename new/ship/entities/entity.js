

export default class Entity {
	constructor(pos, rot) {
		this.pos	= pos	;
		this.rot	= rot	;
	}
}

export class Asteroid extends Entity {
	constructor(...args) {
		super(...args);
	}
}
