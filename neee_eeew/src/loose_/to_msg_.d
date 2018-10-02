module loose_.to_msg_;

import std.experimental.logger;

class ToMsg {
	this(ubyte[] delegate() read, ptrdiff_t delegate(ubyte[]) getMsgLen) {
		this.read	= read	;
		this.getMsgLen	= getMsgLen	;
	}
	
	
	@property bool empty() {
		buffer ~= this.read();
		for (ptrdiff_t msgLen=getMsgLen(buffer); msgLen>0; msgLen=getMsgLen(buffer)) {
			if (msgLen>buffer.length) {
				break;
			}
			msgs ~= buffer[0..msgLen];
			buffer = buffer[msgLen..$];
		}
		return msgs.length==0;
	}
	@property const(const(ubyte)[]) front() {
		return msgs[0];
	}
	void popFront() {
		msgs = msgs[1..$];
	}
	
	private {
		ubyte[] delegate()	read	;
		ptrdiff_t delegate(ubyte[])	getMsgLen	;
		
		ubyte[]	buffer	;
		ubyte[][]	msgs	;
	}
}


