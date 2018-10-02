module galactic_msg_.from_.move_ship_;

import std.experimental.logger;

import galactic_msg_.from_;

import cst_;

FromGalacticMsg Msg() {
	return FromGalacticMsg(FromGalacticMsg.Type.moveShip);
}

enum msgLength = float.sizeof*3+2;

@property {
	float[2] pos(FromGalacticMsg msg) {
		return msg._data[2..2+float.sizeof*2].ptr.cst!(float*)[0..2];////[_data[2..2+float.sizeof],_data[2+float.sizeof..2+float.sizeof+float.sizeof]];
	}
	void pos(FromGalacticMsg msg, float[2] n) {
		msg._data[2..2+float.sizeof*2] = n.ptr.cst!(ubyte*)[0..float.sizeof*2];
	}
	float ori(FromGalacticMsg msg, ) {
		return *(msg._data[2+float.sizeof*2..2+float.sizeof*3].ptr.cst!(float*));////[_data[2..2+float.sizeof],_data[2+float.sizeof..2+float.sizeof+float.sizeof]];
	}
	void ori(FromGalacticMsg msg, float n) {
		msg._data[2+float.sizeof*2..2+float.sizeof*3] = (&n).cst!(ubyte*)[0..float.sizeof];
	}
}

