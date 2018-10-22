module galactic_msg_.up_;

import std.experimental.logger;
import cst_;

import xserial;

import galactic_msg_.msg_template_;

enum MsgType : ubyte {
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
	@Exclude {
		enum type = MsgType.chVel;
		mixin MsgTemplate;
	}
	
	float[2]	vel	;
	float	anv	;
}




