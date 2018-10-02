
import Main from "/console/main.js";

import vec from "/glVec2/vec.js";
window.vec = vec;

window.onload = function () {
	new Main();
}

Math.degrees = function(rad) {
	return rad*(180/Math.PI);
}
	
Math.radians = function(deg) {
	return deg * (Math.PI/180);
}

