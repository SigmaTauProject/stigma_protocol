
import ShipMain from "/ship/shipMain.js";
import ConsoleMain from "/console/consoleMain.js";

import vec from "/glVec2/vec.js";
window.vec = vec;

window.onload = function () {
	const msgQueue = [];
	new ShipMain(msgQueue);
	new ConsoleMain(msgQueue);
}

Math.degrees = function(rad) {
	return rad*(180/Math.PI);
}
	
Math.radians = function(deg) {
	return deg * (Math.PI/180);
}
