module galactic_msg_.down_;

import std.experimental.logger;
import cst_;

import loose_.net_msg_;

import galactic_msg_.msg_template_;

enum MsgType {
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
	enum type = MsgType.add;
	mixin MsgTemplate;
	
	@Net ushort	id	;
	@Net float[2]	pos	;
	@Net float	ori	;
}
class RemoveMsg {
	enum type = MsgType.remove;
	mixin MsgTemplate;
	
	@Net ushort	id	;
}
class UpdateMsg {
	enum type = MsgType.update;
	mixin MsgTemplate;
	
	@Net ushort	id	;
	@Net float[2]	pos	;
	@Net float	ori	;
}
class MoveAllMsg {
	enum type = MsgType.moveAll;
	mixin MsgTemplate;
	
	@Net float[2]	pos	;
	@Net float	ori	;
}





