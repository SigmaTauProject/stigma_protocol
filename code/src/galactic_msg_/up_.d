module galactic_msg_.up_;

import std.experimental.logger;
import cst_;

import loose_.net_msg_;

import galactic_msg_.msg_template_;

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
	enum type = MsgType.chVel;
	mixin MsgTemplate;
	
	@Net float[2]	vel	;
	@Net float	anv	;
}




