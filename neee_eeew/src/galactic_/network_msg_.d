module galactic_.network_msg_;

import std.experimental.logger;

import cst_;

struct NetworkMsg {
	ubyte[] _data = [0];
	this(Type type) {
		this.type = type;
	}
	this (ubyte[] data) {
		assert(data[0]==data.length);
		this._data = data;
	}
	ubyte[] opCast(T:ubyte[])() {
		return data;
	}
	ubyte[] data() {
		auto msg = this._data.dup;
		assert(msg.length<=255);
		msg[0] = msg.length.cst!ubyte;
		return msg;
	}
	alias data this;
	enum Type : ubyte {
		newShip	,
		shipLoc	,
	}
	
	
	@property {
		Type type() {
			return _data[1].cst!Type;
		}
		void type(Type n) {
			if (n==Type.newShip) {
				_data = new ubyte[2+float.sizeof*3];// posx posy rot
			}
			_data[1] = n;
		}
		float[2] pos() {
			return _data[2..2+float.sizeof*2].ptr.cst!(float*)[0..2];////[_data[2..2+float.sizeof],_data[2+float.sizeof..2+float.sizeof+float.sizeof]];
		}
		void pos(float[2] n) {
			_data[2..2+float.sizeof*2] = n.ptr.cst!(ubyte*)[0..float.sizeof*2];
		}
		float ori() {
			return *(_data[2+float.sizeof*2..2+float.sizeof*3].ptr.cst!(float*));////[_data[2..2+float.sizeof],_data[2+float.sizeof..2+float.sizeof+float.sizeof]];
		}
		void ori(float n) {
			_data[2+float.sizeof*2..2+float.sizeof*3] = (&n).cst!(ubyte*)[0..float.sizeof];
		}
		
	}
}

