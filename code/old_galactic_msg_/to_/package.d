module galactic_msg_.to_;

import std.experimental.logger;

import galactic_msg_.both_;

import cst_;

struct ToGalacticMsg {
	mixin GalacticMsg;
	this(Type type) {
		final switch (type) {
			case Type.chVel:
				import galactic_msg_.to_.ch_vel_;
				_data = new ubyte[msgLength];
				break;
		}
		this.type = type;
	}
	this(ubyte dataSize) {
		this._data = new ubyte[dataSize];
	}
	this (const(ubyte[]) data) {
		assert(data[0]==data.length);
		this._data = data.cst!(ubyte[]);
	}
	enum Type : ubyte {
		chVel	,
	}
	
	@property {
		Type type() {
			return _data[1].cst!Type;
		}
		void type(Type n) {
			version (assert) {
				final switch (type) {
					case Type.chVel:
						import galactic_msg_.to_.ch_vel_;
						assert(msgLength==_data.length);
						break;
				}
			}
			_data[1] = n;
		}
	}
}

