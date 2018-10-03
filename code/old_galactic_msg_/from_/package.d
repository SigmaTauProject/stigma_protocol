module galactic_msg_.from_;

import std.experimental.logger;

import galactic_msg_.both_;

import cst_;

struct FromGalacticMsg {
	mixin GalacticMsg;
	this(Type type) {
		final switch (type) {
			case Type.newShip:
				import galactic_msg_.from_.new_ship_;
				_data = new ubyte[msgLength];
				break;
			case Type.moveShip:
				import galactic_msg_.from_.move_ship_;
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
		newShip	,
		moveShip	,
		basicConfig	,
	}
	
	@property {
		Type type() {
			return _data[1].cst!Type;
		}
		void type(Type n) {
			version (assert) {
				final switch (type) {
					case Type.newShip:
						import galactic_msg_.from_.new_ship_;
						assert(msgLength==_data.length);
						break;
					case Type.moveShip:
						import galactic_msg_.from_.move_ship_;
						assert(msgLength==_data.length);
						break;
				}
			}
			_data[1] = n;
		}
	}
}

