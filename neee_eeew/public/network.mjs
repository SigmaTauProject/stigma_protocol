
import {decodeNetMsg,encodeNetMsg} from "./loose/netMsg.mjs";

export default class Network {
	constructor(ship,socket) {
		this.socket	= socket	;
		this.ship	= ship	;
	}
	init() {
	}
	update() {
		for (let msgData of this.socket) {
			let msg = decodeNetMsg(msgData, [255,0],downMsgStructure[downType(msgData)]);
			this.ship.msg_components(msg);
			console.log(msg);
			let res = encodeNetMsg({testByte:246,testArray:[1,6,7]}, [255,0],upMsgStructure.test);
			log(res);
			this.socket.send(res);
			////if (msg.component==-1) {
			////	this.ship["msg_"+msg.type](msg);
			////}
			////else {
			////	try {
			////		this.ship.components[msg.component]["msg_"+msg.type](msg);
			////	}
			////	catch (e) {
			////		console.log(msg);
			////		throw e;
			////	}
			////}
		}
	}
}

function downType(msgData) {
	if (msgData[1]==255) {
		if (msgData[2]==0) {
			return "components";
		}
	}
}

var downMsgStructure = {
	components: {
		type:"object",
		values:[{type:"array",name:"components",length:"dynamic",content:{type:"ubyte"}}],
	}
}

var upMsgStructure = {
	test: {
		type:"object",
		values:[{type:"ubyte",name:"testByte"},{type:"array",name:"testArray",length:"dynamic",content:{type:"ubyte"}}],
	},
}