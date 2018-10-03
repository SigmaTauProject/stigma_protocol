module terminal_msg_.up_ship_;

import std.experimental.logger;
import cst_;

import loose_.net_msg_;

import terminal_msg_.component_type_;

enum MsgType {
	test	,
}

struct UnknownMsg {
	const(ubyte)[] msgData;
	
	@property
	MsgType type() {
		assert(msgData.ptr && msgData.length>=3);
		return msgData[2].cst!MsgType;
	}
}



class TestMsg {
	static TestMsg opCall() {
		return new TestMsg;
	}
	static TestMsg opCall(UnknownMsg msg) {
		return TestMsg(msg.msgData);
	}
	static TestMsg opCall(const(ubyte)[] msgData) {
		return msgData.decodeNetMsg!TestMsg([ubyte.max, MsgType.test.cst!ubyte]);
	}
	@Net ubyte	testByte	;
	@Net ubyte[]	testArray	;
	
	@property
	ubyte[] msgData() {
		return this.encodeNetMsg([ubyte.max, MsgType.test.cst!ubyte]);
	}
	alias msgData this;
}




