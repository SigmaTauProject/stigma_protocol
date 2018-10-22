module galactic_msg_.msg_template_;

import std.experimental.logger;
import cst_;


mixin template  MsgTemplate(){
	alias Msg = typeof(this);
	static Msg opCall() {
		return new Msg;
	}
	static Msg opCall(UnknownMsg msg) {
		return Msg(msg.msgData);
	}
	static Msg opCall(const(ubyte)[] msgData) {
		return msgData.decodeNetMsg!Msg(type);
	}
	
	@property
	const(ubyte)[] msgData() {
		return this.encodeNetMsg(type);
	}
	alias msgData this;
}


