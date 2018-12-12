module stigma_protocol_.msg_template_;
import commonImports;


mixin template  MsgTemplate(){
	alias Msg = typeof(this);
	static Msg opCall() {
		return new Msg;
	}
	static Msg opCall(UnknownMsg msg) {
		return Msg(msg.msgData);
	}
	static Msg opCall(const(ubyte)[] msgData) {
		assert(msgData[0] == msgData.length);
		return msgData[2..$].deserialize!(Msg, Endian.littleEndian, ubyte);
	}
	
	@property
	const(ubyte)[] msgData() {
		auto data = this.serialize!(Endian.littleEndian, ubyte);
		data = [(data.length+2).cst!ubyte, type.cst!ubyte]~data;
		assert(data.length == data[0]);
		return data;
	}
	alias msgData this;
}


mixin template UnknownMsgTemplate() {
	const(ubyte)[] msgData;
	
	@property
	MsgType type() {
		assert(msgData.ptr && msgData.length>=2);
		return msgData[1].cst!MsgType;
	}
}

