
abstract class FromGalactic {
	abstract Type type;
	abstract ubyte[] data;
	static:
	enumType {
		newShip,
		moveShip,
	}
	class NewShip : FromGalactic {
		Type type = Type.newShip;
	}
	class MoveShip : FromGalactic {
		Type type = Type.moveShip;
	}
}
