

export default class Network {
	constructor(ship,socket) {
		this.socket	= socket	;
		this.ship	= ship	;
	}
	init() {
	}
	update() {
		for (var msg of this.socket) {
			if (msg.component==-1) {
				this.ship["msg_"+msg.type](msg);
			}
			else {
				try {
					this.ship.components[msg.component]["msg_"+msg.type](msg);
				}
				catch (e) {
					console.log(msg);
					throw e;
				}
			}
		}
	}
}
