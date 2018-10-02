module galactic_msg_.to_;

import std.experimental.logger;
import cst_;

import loose_.net_msg_;

enum MsgType {
	chVel	,
}

struct UnknownMsg {
	const(ubyte)[] msgData;
	
	@property
	MsgType type() {
		assert(msgData.ptr && msgData.length>=2);
		return msgData[1].cst!MsgType;
	}
}



class ChVelMsg {
	static ChVelMsg opCall() {
		return new ChVelMsg;
	}
	static ChVelMsg opCall(UnknownMsg msg) {
		return ChVelMsg(msg.msgData);
	}
	static ChVelMsg opCall(const(ubyte)[] msgData) {
		return msgData.decodeNetMsg!ChVelMsg(MsgType.chVel);
	}
	@Net float[2]	vel	;
	@Net float	anv	;
	
	@property
	ubyte[] msgData() {
		return this.encodeNetMsg(MsgType.chVel);
	}
	alias msgData this;
}




