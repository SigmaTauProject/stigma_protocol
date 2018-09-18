
var game;

window.onload = function () {
	game = new Game();
}






// Game
class Game {
	constructor() {
		this.world	= new World	(	);
		this.gameLogic	= new GameLogic	(this.world	);
		this.rendering	= new Rendering	(this.world	);
		this.input	= new Input	(this.gameLogic	);
		this.world.giveHandlers(this.gameLogic, this.rendering);
		this.input.init();
		this.gameLogic.init();
		this.rendering.init();
		
		setInterval(this.update.bind(this), 50);
	}
	update() {
		this.input	.update();
		this.gameLogic	.update();
		this.rendering	.update();
	}
}

// GameLogic
class GameLogic {
	constructor(world) {
		this.world	= world	;
	}
	init() {
		this.world.player	= this.world.createEntity();
		this.world.createEntity();
	}
	onCreateEntity(entity) {
		entity.pos	= [0,0]	;
		entity.rot	= 0	;
	}
	update() {
	}
	
	onMove(amount) {
		amount = rotateVector(amount, this.world.player.rot);
		this.world.player.pos[0] -= amount[0]/10;
		this.world.player.pos[1] -= amount[1]/10;
	}
	onRotate(angle) {
		this.world.player.rot += angle*5;
	}
}

function rotateVector(vector, angle) {
	if (angle == 0) {
		return vector;
	}
	angle = Math.radians(angle);
	newVec = [0,0];
	newVec[0] = vector[0] * Math.cos(angle) - vector[1] * Math.sin(angle);
	newVec[1] = vector[0] * Math.sin(angle) + vector[1] * Math.cos(angle);
	return newVec;
}

Math.degrees = function(rad) {
	return rad*(180/Math.PI);
}
	
Math.radians = function(deg) {
	return deg * (Math.PI/180);
}


// Entities
class World {
	constructor() {
		this.entities	= []	;
		this.player	= null	;
	}
	giveHandlers(gameLogic,rendering) {
		this.gameLogic	= gameLogic	;
		this.rendering	= rendering	;
	}
	createEntity(entity) {
		var entity = {};
		this.gameLogic	.onCreateEntity(entity);
		this.rendering	.onCreateEntity(entity);
		this.entities.push(entity);
		return entity;
	}
}




// Rendering
class Rendering {
	constructor(world) {
		this.world	= world	;
		
		this.view =	svg (	"svg",
				Div.attributes({style: "width:90%;height:90%;", viewBox:"-10 -10 20 20"}),
			);
		
		document.body.appendChild(this.view);
	}
	init() {
	}
	onCreateEntity(entity) {
		entity.el = svg("polygon", "entity", Div.attributes({points:"-0.5,0.5 0,-0.5 0.5,0.5 0,0.25"}))
		this.view.appendChild(entity.el);
	}
	update() {
		for (var entity of this.world.entities) {
			entity.el.setAttribute("transform",`translate(${entity.pos[0]-this.world.player.pos[0]},${entity.pos[1]-this.world.player.pos[1]}) rotate(${entity.rot})`)
		}
	}
}

// Input
class Input {
	constructor(gameLogic) {
		this.gameLogic = gameLogic;
		document.addEventListener("keydown", this.onKeyDown.bind(this));
		document.addEventListener("keyup", this.onKeyUp.bind(this));
		
		this.held = {e:false};
		this.pendingEvents = [];
	}
	init() {}
	update() {
		{
			var move = [0,0];
			if (this.held.e) {
				move[1] += 1;
			}
			if (this.held.comma) {
				move[1] -= 1;
			}
			////if (this.held.r) {
			////	move[0] -= 1;
			////}
			////if (this.held.n) {
			////	move[0] += 1;
			////}
			if (move != [0,0]) {
				this.gameLogic.onMove(move);
			}
		}
		{
			var rotate = 0;
			if (this.held.r) {
				rotate -= 1;
			}
			if (this.held.n) {
				rotate += 1;
			}
			if (rotate != 0) {
				this.gameLogic.onRotate(rotate);
			}
		}
	}
	onKeyDown(e) {
		this.onKey(e,true);
	}
	onKeyUp(e) {
		this.onKey(e,false);
	}
	
	onKey(e,down) {
		if (e.key=="e") {
			this.held.e = down;
		}
		else if (e.key==",") {
			this.held.comma = down;
		}
		else if (e.key=="r") {
			this.held.r = down;
		}
		else if (e.key=="n") {
			this.held.n = down;
		}
	}
}