
var game;

window.onload = function () {
	game = new Game();
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




////// Rendering
////class Rendering {
////	constructor(world) {
////		this.world	= world	;
////		
////		this.view =	svg (	"svg",
////				Div.attributes({style: "width:90%;height:90%;", viewBox:"-10 -10 20 20"}),
////			);
////		
////		document.body.appendChild(this.view);
////	}
////	init() {
////	}
////	onCreateEntity(entity) {
////		entity.el = svg("polygon", "entity", Div.attributes({points:"-0.5,0.5 0,-0.5 0.5,0.5 0,0.25"}))
////		this.view.appendChild(entity.el);
////	}
////	update() {
////		for (var entity of this.world.entities) {
////			entity.el.setAttribute("transform",`translate(${entity.pos[0]-this.world.player.pos[0]},${entity.pos[1]-this.world.player.pos[1]}) rotate(${entity.rot})`)
////		}
////	}
////}

//// Input
////lass Input {
////	constructor(gameLogic) {
////		this.gameLogic = gameLogic;
////		document.addEventListener("keydown", this.onKeyDown.bind(this));
////		document.addEventListener("keyup", this.onKeyUp.bind(this));
////		
////		this.held = {e:false};
////		this.pendingEvents = [];
////	}
////	init() {}
////	update() {
////		{
////			var move = [0,0];
////			if (this.held.e) {
////				move[1] += 1;
////			}
////			if (this.held.comma) {
////				move[1] -= 1;
////			}
////			////if (this.held.r) {
////			////	move[0] -= 1;
////			////}
////			////if (this.held.n) {
////			////	move[0] += 1;
////			////}
////			if (move != [0,0]) {
////				this.gameLogic.onMove(move);
////			}
////		}
////		{
////			var rotate = 0;
////			if (this.held.r) {
////				rotate -= 1;
////			}
////			if (this.held.n) {
////				rotate += 1;
////			}
////			if (rotate != 0) {
////				this.gameLogic.onRotate(rotate);
////			}
////		}
////	}
////	onKeyDown(e) {
////		this.onKey(e,true);
////	}
////	onKeyUp(e) {
////		this.onKey(e,false);
////	}
////	
////	onKey(e,down) {
////		if (e.key=="e") {
////			this.held.e = down;
////		}
////		else if (e.key==",") {
////			this.held.comma = down;
////		}
////		else if (e.key=="r") {
////			this.held.r = down;
////		}
////		else if (e.key=="n") {
////			this.held.n = down;
////		}
////	}
////