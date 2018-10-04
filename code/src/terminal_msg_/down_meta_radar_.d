module terminal_msg_.down_meta_radar_;

import std.experimental.logger;
import cst_;

import loose_.net_msg_;

import terminal_msg_.entity_;
public import terminal_msg_.up_;

enum MsgType {
	update	,
}



	
@property
MsgType type(UnknownMsg msg) {
	assert(msg.msgData.ptr && msg.msgData.length>=3);
	return msg.msgData[2].cst!MsgType;
}



class UpdateMsg {
	this() {
		this(255);
	}
	this(ubyte component) {
		this.component = component;
	}
	static UpdateMsg opCall() {
		return new UpdateMsg(255);
	}
	static UpdateMsg opCall(ubyte component) {
		return new UpdateMsg(component);
	}
	static UpdateMsg opCall(UnknownMsg msg) {
		return UpdateMsg(msg.msgData);
	}
	static UpdateMsg opCall(const(ubyte)[] msgData) {
		return msgData.decodeNetMsg!UpdateMsg([msgData[1], MsgType.update.cst!ubyte]);
	}
	
	private ubyte component;
	@Net Entity[] entities;
	
	@property
	ubyte[] msgData() {
		assert(component!=255);
		return this.encodeNetMsg([component, MsgType.update.cst!ubyte]);
	}
	alias msgData this;
}






