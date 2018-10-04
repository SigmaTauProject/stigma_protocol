module terminal_msg_.down_;

import std.experimental.logger;
import cst_;

import loose_.net_msg_;

struct UnknownMsg {
	const(ubyte)[] msgData;
	
	@property
	ubyte component() {
		assert(msgData.ptr && msgData.length>=2);
		return msgData[1];
	}
}


