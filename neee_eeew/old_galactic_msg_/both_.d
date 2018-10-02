
module galactic_msg_.both_;

import std.experimental.logger;

import cst_;

mixin template GalacticMsg() {
	ubyte[] _data;
	ubyte[] opCast(T:ubyte[])() {
		return data;
	}
	ubyte[] data() {
		assert(_data.length<=255);
		_data[0] = _data.length.cst!ubyte;
		return _data;
	}
	alias data this;
}



