module terminal_msg_.down_meta_move_;

import std.experimental.logger;
import cst_;

import loose_.net_msg_;

import terminal_msg_.entity_;
public import terminal_msg_.up_;
public import terminal_msg_.meta_move_;


enum MsgType {
	update	,
}



	
@property
MsgType type(UnknownMsg msg) {
	assert(msg.msgData.ptr && msg.msgData.length>=3);
	return msg.msgData[2].cst!MsgType;
}



class UpdateMsg {
	enum type = MsgType.update;
	mixin MsgTemplate;
	
	@Net Axis	axis	;
	@Net float	value	;
}






