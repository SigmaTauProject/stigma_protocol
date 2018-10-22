module terminal_msg_.down_meta_radar_;

import std.experimental.logger;
import cst_;

import loose_.net_msg_;

import terminal_msg_.entity_;
public import terminal_msg_.up_;

import terminal_msg_.msg_template_;

enum MsgType : ubyte {
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
	
	@Net Entity[] entities;
}






