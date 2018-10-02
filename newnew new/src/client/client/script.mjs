
import Main from "./main.mjs";

import vec from "./glVec2/vec.mjs";
window.vec = vec;

window.onload = function () {
	class ServerCom {
		constructor() {
			this.socket = io();
		}
		on(...args) {
			this.socket.on(...args);
		}
		send(...args) {
			this.socket.emit(...args);
		}
	}
	
	new Main(new ServerCom());
}

Math.degrees = function(rad) {
	return rad*(180/Math.PI);
}
	
Math.radians = function(deg) {
	return deg * (Math.PI/180);
}



