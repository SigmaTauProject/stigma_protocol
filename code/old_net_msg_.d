import std.stdio;
import std.traits;
import std.algorithm.iteration;
import std.typecons : Tuple;

void main() {
	Msg msg = new Msg;
	msg.pos = [2,1.2];
	msg.ori = 2.5;
	msg.nums = [1,5.2,2.3];
	msg.more = [1000,525646,212];
	
	auto msgData = msg.encodeNetMsg(Type.msg2);
	
	auto de = msgData.decodeNetMsg!Msg;
	de.pos.writeln;
	de.ori.writeln;
	de.nums.writeln;
	de.more.writeln;
}



enum Type : ubyte {
	msg,
	msg2,
}



class Msg {
	@Net float[2] pos;
	@Net float ori;
	@Net float[] nums;
	@Net long[] more;
}




ubyte[] encodeNetMsg(T)(T t, ubyte msgType) {
	alias netMembers = getSymbolsByUDA!(T, Net);
	
	size_t bodyLen = ubyte.sizeof*2;
	size_t tailLen = 0;
	{
		static foreach (val; netMembers){
			{
				auto value = __traits(getMember, t, val.stringof);
				alias Type = typeof(val);
				static if (isDynamicArray!Type) {
					bodyLen += ubyte.sizeof;
					tailLen += typeof(*val.ptr).sizeof * value.length;
				}
				else {
					bodyLen += Type.sizeof;
				}
			}
		}
	}
	
	ubyte[] msgData = new ubyte[bodyLen+tailLen];
	{
		size_t bodyOffset = ubyte.sizeof*2;//because of header
		size_t tailOffset = 0;
		msgData[0] = cast(ubyte)(bodyLen+tailLen);
		msgData[1] = msgType;
		static foreach (val; netMembers){
			{
				auto value = __traits(getMember, t, val.stringof);
				static if (isDynamicArray!(typeof(val))) {
					assert(value.length<=255);
					auto len = cast(ubyte)(value.length);
					msgData[bodyOffset..bodyOffset+ubyte.sizeof] = (&len)[0..ubyte.sizeof];
					bodyOffset += ubyte.sizeof;
					ubyte* dataPtr = (cast(ubyte*)value.ptr);
					auto dataLen = cast(ubyte)(typeof(*val.ptr).sizeof*value.length);
					msgData[bodyLen+tailOffset..bodyLen+tailOffset+dataLen] = dataPtr[0..dataLen];
					tailOffset += dataLen;
				}
				else {
					ubyte size = typeof(val).sizeof;
					msgData[bodyOffset..bodyOffset+size] = (cast(ubyte*)(&value))[0..size];
					bodyOffset += size;
				}
			}
		}
	}
	assert(msgData.length==msgData[0]);
	return msgData;
}

T decodeNetMsg(T)(ubyte[] msgData) {
	alias netMembers = getSymbolsByUDA!(T, Net);
	
	assert(msgData.length==msgData[0]);
	
	size_t bodyLen = ubyte.sizeof*2;
	size_t tailLen = 0;
	{
		static foreach (val; netMembers){
			{
				alias Type = typeof(val);
				static if (isDynamicArray!Type) {
					tailLen += (cast(ubyte)(typeof(*val.ptr).sizeof*(*(cast(ubyte*)msgData[bodyLen..bodyLen+ubyte.sizeof]))));
					bodyLen += ubyte.sizeof;
				}
				else {
					bodyLen += Type.sizeof;
				}
			}
		}
	}
	assert(bodyLen+tailLen==msgData.length);
	
	T t = new T;
	{
		size_t bodyOffset = ubyte.sizeof*2;//because of header
		size_t tailOffset = 0;
		static foreach (val; netMembers){
			{
				static if (isDynamicArray!(typeof(val))) {
					auto len = *(cast(ubyte*)msgData[bodyOffset..bodyOffset+ubyte.sizeof]);
					bodyOffset += ubyte.sizeof;
					__traits(getMember, t, val.stringof) = (cast(typeof(val.ptr))msgData[bodyLen+tailOffset..$].ptr)[0..len];
					tailOffset += cast(ubyte)(typeof(*val.ptr).sizeof*len);
				}
				else {
					ubyte size = typeof(val).sizeof;
					__traits(getMember, t, val.stringof) = *(cast(typeof(val)*)(msgData[bodyOffset..bodyOffset+size].ptr));
					bodyOffset += size;
				}
			}
		}
	}
	return t;
}

struct Net {
	
}

