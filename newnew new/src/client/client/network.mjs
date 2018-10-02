

export default class Network {
	constructor(ship,serverCom) {
		this.serverCom	= serverCom	;
		this.ship	= ship	;
				
		this.msgQueue	= []	;
		serverCom.on("msg",this.onMsg.bind(this));
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
		this.msgQueue	= []	;
	}
	onMsg(msg) {
		this.msgQueue.push(msg);
	}
}
