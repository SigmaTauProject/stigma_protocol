module galactic_msg_.down_;

import std.experimental.logger;
import cst_;

import xserial;

import galactic_msg_.msg_template_;

enum MsgType : ubyte {
	add	,
	remove	,
	update	,
	moveAll	,
}

struct UnknownMsg {
	const(ubyte)[] msgData;
	
	@property
	MsgType type() {
		assert(msgData.ptr && msgData.length>=2);
		return msgData[1].cst!MsgType;
	}
}


class AddMsg {
	@Exclude {
		enum type = MsgType.add;
		mixin MsgTemplate;
	}
	
	ushort	id	;
	float[2]	pos	;
	float	ori	;
}
class RemoveMsg {
	@Exclude {
		enum type = MsgType.remove;
		mixin MsgTemplate;
	}
	
	ushort	id	;
}
class UpdateMsg {
	@Exclude {
		enum type = MsgType.update;
		mixin MsgTemplate;
	}
	
	ushort	id	;
	float[2]	pos	;
	float	ori	;
}
class MoveAllMsg {
	@Exclude {
		enum type = MsgType.moveAll;
		mixin MsgTemplate;
	}
	
	float[2]	pos	;
	float	ori	;
}





