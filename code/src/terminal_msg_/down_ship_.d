module terminal_msg_.down_ship_;

import std.experimental.logger;
import cst_;

import loose_.net_msg_;

import terminal_msg_.component_type_;
public import terminal_msg_.up_;

enum MsgType {
	components	,
}




@property
MsgType type(UnknownMsg msg) {
	assert(msg.msgData.ptr && msg.msgData.length>=3);
	return msg.msgData[2].cst!MsgType;
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




