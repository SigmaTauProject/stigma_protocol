module terminal_msg_.msg_template_;

import std.experimental.logger;
import cst_;


mixin template  MsgTemplate(){
	alias Msg = typeof(this);
	this(ubyte component=255) {
		this.component = component;
	}
	static Msg opCall(ubyte component=255) {
		return new Msg(component);
	}
	static Msg opCall(UnknownMsg msg) {
		return Msg(msg.msgData);
	}
	static Msg opCall(const(ubyte)[] msgData) {
		return msgData.decodeNetMsg!Msg([msgData[1], type]);
	}
	
	@property
	const(ubyte)[] msgData() {
		assert(component!=255);
		return this.encodeNetMsg([component, type]);
	}
	alias msgData this;
	
	private ubyte component;
}


