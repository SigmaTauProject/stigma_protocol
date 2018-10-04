module terminal_msg_.up_ship_;

import std.experimental.logger;
import cst_;

import loose_.net_msg_;

public import terminal_msg_.up_;

enum MsgType {
	test	,
}




@property
MsgType type(UnknownMsg msg) {
	assert(msg.msgData.ptr && msg.msgData.length>=3);
	return msg.msgData[2].cst!MsgType;
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




