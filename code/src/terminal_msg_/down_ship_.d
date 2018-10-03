module terminal_msg_.down_ship_;

import std.experimental.logger;
import cst_;

import loose_.net_msg_;

import terminal_msg_.component_type_;

enum MsgType {
	components	,
}

struct UnknownMsg {
	const(ubyte)[] msgData;
	
	@property
	MsgType type() {
		assert(msgData.ptr && msgData.length>=3);
		return msgData[2].cst!MsgType;
	}
}



class ComponentsMsg {
	static ComponentsMsg opCall() {
		return new ComponentsMsg;
	}
	static ComponentsMsg opCall(UnknownMsg msg) {
		return ComponentsMsg(msg.msgData);
	}
	static ComponentsMsg opCall(const(ubyte)[] msgData) {
		return msgData.decodeNetMsg!ComponentsMsg([ubyte.max, MsgType.components.cst!ubyte]);
	}
	@Net ComponentType[]	components;
	
	@property
	ubyte[] msgData() {
		return this.encodeNetMsg([ubyte.max, MsgType.components.cst!ubyte]);
	}
	alias msgData this;
}




