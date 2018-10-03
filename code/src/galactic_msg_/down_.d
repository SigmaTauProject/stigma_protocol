module galactic_msg_.down_;

import std.experimental.logger;
import cst_;

import loose_.net_msg_;

enum MsgType {
	update	,
}

struct UnknownMsg {
	const(ubyte)[] msgData;
	
	@property
	MsgType type() {
		assert(msgData.ptr && msgData.length>=2);
		return msgData[1].cst!MsgType;
	}
}



class UpdateMsg {
	import galactic_msg_.entity_;
	static UpdateMsg opCall() {
		return new UpdateMsg;
	}
	static UpdateMsg opCall(UnknownMsg msg) {
		return UpdateMsg(msg.msgData);
	}
	static UpdateMsg opCall(const(ubyte)[] msgData) {
		return msgData.decodeNetMsg!UpdateMsg(MsgType.update);
	}
	@Net Entity[] entities;
	
	@property
	const(ubyte)[] msgData() {
		return this.encodeNetMsg(MsgType.update);
	}
	alias msgData this;
}




