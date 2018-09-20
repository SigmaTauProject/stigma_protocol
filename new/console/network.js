

export default class Network {
	constructor(ship,msgQueue) {
		this.msgQueue	= msgQueue	;
		this.ship	= ship	;
	}
	init() {
	}
	update() {
		for (var msg of this.msgQueue) {
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
		this.msgQueue.length = 0;
	}
}
