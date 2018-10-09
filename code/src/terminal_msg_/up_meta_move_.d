module terminal_msg_.up_meta_move_;

import std.experimental.logger;
import cst_;

import loose_.net_msg_;

public import terminal_msg_.up_;
public import terminal_msg_.meta_move_;

enum MsgType {
	read	,
	stream	,
	set	,
}
	
@property
MsgType type(UnknownMsg msg) {
	assert(msg.msgData.ptr && msg.msgData.length>=3);
	return msg.msgData[2].cst!MsgType;
}



class ReadMsg {
	static ReadMsg opCall() {
		return new ReadMsg;
	}
	static ReadMsg opCall(UnknownMsg msg) {
		return ReadMsg(msg.msgData);
	}
	static ReadMsg opCall(const(ubyte)[] msgData) {
		return msgData.decodeNetMsg!ReadMsg([msgData[1], MsgType.read.cst!ubyte]);
	}
	
	@Net Axis axis;
	
	@property
	ubyte[] msgData() {
		return this.encodeNetMsg([msgData[1], MsgType.read.cst!ubyte]);
	}
	alias msgData this;
}

class StreamMsg {
	static StreamMsg opCall() {
		return new StreamMsg;
	}
	static StreamMsg opCall(UnknownMsg msg) {
		return StreamMsg(msg.msgData);
	}
	static StreamMsg opCall(const(ubyte)[] msgData) {
		return msgData.decodeNetMsg!StreamMsg([msgData[1], MsgType.stream.cst!ubyte]);
	}
	
	@Net Axis axis;
	
	@property
	ubyte[] msgData() {
		return this.encodeNetMsg([msgData[1], MsgType.stream.cst!ubyte]);
	}
	alias msgData this;
}

class SetMsg {
	static SetMsg opCall() {
		return new SetMsg;
	}
	static SetMsg opCall(UnknownMsg msg) {
		return SetMsg(msg.msgData);
	}
	static SetMsg opCall(const(ubyte)[] msgData) {
		return msgData.decodeNetMsg!SetMsg([msgData[1], MsgType.set.cst!ubyte]);
	}
	
	@Net Axis	axis	;
	@Net float	value	;
	
	@property
	ubyte[] msgData() {
		return this.encodeNetMsg([msgData[1], MsgType.set.cst!ubyte]);
	}
	alias msgData this;
}



