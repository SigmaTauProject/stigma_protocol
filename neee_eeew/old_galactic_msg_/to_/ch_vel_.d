module galactic_msg_.to_.ch_vel_;

import std.experimental.logger;

import galactic_msg_.to_;

import cst_;

ToGalacticMsg Msg() {
	return ToGalacticMsg(ToGalacticMsg.Type.chVel);
}

enum msgLength = float.sizeof*3+2;

@property {
	float[2] vel(ToGalacticMsg msg) {
		return msg._data[2..2+float.sizeof*2].ptr.cst!(float*)[0..2];////[_data[2..2+float.sizeof],_data[2+float.sizeof..2+float.sizeof+float.sizeof]];
	}
	void vel(ToGalacticMsg msg, float[2] n) {
		msg._data[2..2+float.sizeof*2] = n.ptr.cst!(ubyte*)[0..float.sizeof*2];
	}
	float anv(ToGalacticMsg msg, ) {
		return *(msg._data[2+float.sizeof*2..2+float.sizeof*3].ptr.cst!(float*));////[_data[2..2+float.sizeof],_data[2+float.sizeof..2+float.sizeof+float.sizeof]];
	}
	void anv(ToGalacticMsg msg, float n) {
		msg._data[2+float.sizeof*2..2+float.sizeof*3] = (&n).cst!(ubyte*)[0..float.sizeof];
	}
}

