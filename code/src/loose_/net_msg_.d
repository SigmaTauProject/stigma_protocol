module loose_.net_msg_;

import std.experimental.logger;
import cst_;

import std.traits;

struct Net {}

ubyte[] encodeNetMsg(Msg)(Msg msg, ubyte addedHeader) {
	return encodeNetMsg(msg,[addedHeader]);
}
ubyte[] encodeNetMsg(Msg)(Msg msg, ubyte[] addedHeader) {
	ubyte[] enm(Msg)(Msg msg) {
		static if (isDynamicArray!(Msg)) {
			assert(msg.length<=255);
			ubyte len = msg.length.cst!ubyte;
			ubyte[] msgData = [len];
			foreach (val; msg) {
				msgData ~= enm(val);
			}
			return msgData;
		}
		else static if (is(Msg == class)) {
			ubyte[] msgData = [];
			static foreach (val; getSymbolsByUDA!(Msg, Net)){
				{
					auto value = __traits(getMember, msg, val.stringof);
					alias Type = typeof(val);
					msgData ~= enm(value);
				}
			}
			return msgData;
		}
		else {
			ubyte[] msgData = ((&msg).cst!(ubyte*)[0..Msg.sizeof]).dup;
			return msgData;
		}
	}
	auto msgBody = enm(msg);
	auto msgLen = (1+addedHeader.length+msgBody.length);
	assert(msgLen<256);
	ubyte[] msgData = msgLen.cst!ubyte~addedHeader~msgBody;
	return msgData;
}
Msg decodeNetMsg(Msg)(const(ubyte)[] msgData, ubyte addedHeader) {
	return decodeNetMsg!Msg(msgData,[addedHeader]);
}
Msg decodeNetMsg(Msg)(const(ubyte)[] msgData, ubyte[] addedHeader) {
	Msg dnm(Msg)(const(ubyte)[] msgData,ref ubyte offset) {
		static if (isDynamicArray!(Msg)) {
			ubyte len = msgData[0];
			offset++;
			Msg msg = [];
			foreach (val; 0..len) {
				ubyte used;
				msg ~= dnm!(typeof(*(msg.ptr)))(msgData[offset..$],used);
				offset+=used;
			}
			return msg;
		}
		else static if (is(Msg == class)) {
			Msg msg = new Msg;
			static foreach (val; getSymbolsByUDA!(Msg, Net)){
				{
					alias Type = typeof(val);
					ubyte used;
					__traits(getMember, msg, val.stringof) = dnm!Type(msgData[offset..$],used);
					offset+=used;
				}
			}
			return msg;
		}
		else {
			Msg msg = *((msgData.ptr).cst!(Msg*));
			offset = Msg.sizeof;
			return msg;
		}
	}
	assert(msgData[1..1+addedHeader.length]==addedHeader);
	ubyte used;
	auto msg = dnm!Msg(msgData[1+addedHeader.length..$],used);
	assert(used+1+addedHeader.length==msgData.length);
	return msg;
}

