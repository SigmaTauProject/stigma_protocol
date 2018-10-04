
import {decodeNetMsg,encodeNetMsg} from "./loose/netMsg.mjs";

export default class Network {
	constructor(ship,socket) {
		this.socket	= socket	;
		this.ship	= ship	;
	}
	init() {
		{
			let res = encodeNetMsg({testByte:246,testArray:[1,6,7]}, [255,0],upShipMsgStructure.test);
			log(res);
			this.socket.send(res);
		}
		{
			let res = encodeNetMsg({}, [0,0],upMetaRadarMsgStructure.read);
			log(res);
			this.socket.send(res);
		}
		{
			let res = encodeNetMsg({}, [0,1],upMetaRadarMsgStructure.stream);
			log(res);
			this.socket.send(res);
		}
	}
	update() {
		for (let msgData of this.socket) {
			if (msgData[1] == 255) {
				let msg = decodeNetMsg(msgData, [255,0],downShipMsgStructure["components"]);////downType(msgData)]);
				this.ship.msg_components(msg);
				console.log(msg);
			}
			else {
				// TODO: this needs to talk to components
				let msg = decodeNetMsg(msgData, [0,0],downMetaRadarMsgStructure["update"]);
				////this.ship.msg_components(msg);
				console.log(msg);
			}
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

////function downType(msgData) {
////	if (msgData[1]==255) {
////		if (msgData[2]==0) {
////			return "components";
////		}
////	}
////}

var downShipMsgStructure = {
	components: {
		type:"object",
		values:[
			{name:"components",type:"array",length:"dynamic",content:{type:"ubyte"},},
		],
	}
}
var downMetaRadarMsgStructure = {
	update: {
		type:"object",
		values:[
			{	name	: "entities"	,
				type	: "array"	,
				length	: "dynamic"	,
				
				content:	{	type	: "object",
						values	: [
							{	name	: "pos"	,
								type	: "array"	,
								length	: 2	,
								content	: {type:"float"}	,
							},
							{	name	: "ori"	,
								type	: "float"	,
							},
							{	name	: "id"	,
								type	: "ushort"	,
							},
						],
					},
			},
		],
	}
}

var upShipMsgStructure = {
	test: {
		type:"object",
		values:[
			{	name	: "testByte"	,
				type	: "ubyte"	,
			},
			{	name	: "testArray"	,
				type	: "array"	,
				length	: "dynamic"	,
				content	: {type:"ubyte"}	,
			},
		],
	},
}
var upMetaRadarMsgStructure = {
	read: {
		type:"object",
		values:[],
	},
	stream: {
		type:"object",
		values:[],
	},
}