import Network	from "./network.mjs"	;
import Ship	from "./ship.mjs"	;
import UI	from "./ui.mjs"	;

export default class Main {
	constructor() {
		this.ship	= new Ship();
		this.network	= new Network();
		this.ui	= new UI(this.ship);
	}
}



