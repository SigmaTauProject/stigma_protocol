module galactic_msg_.from_.basic_config_;

import std.experimental.logger;

import galactic_msg_.from_;

import cst_;

FromGalacticMsg Msg() {
	return FromGalacticMsg(FromGalacticMsg.Type.basicConfig);
}

enum msgLength = int.sizeof*1+2;

@property {
	int gameTick(FromGalacticMsg msg, ) {
		return *(msg._data[2+int.sizeof*2..2+int.sizeof*3].ptr.cst!(int*));////[_data[2..2+float.sizeof],_data[2+float.sizeof..2+float.sizeof+float.sizeof]];
	}
	void gameTick(FromGalacticMsg msg, int n) {
		msg._data[2+int.sizeof*2..2+int.sizeof*3] = (&n).cst!(ubyte*)[0..int.sizeof];
	}
}

