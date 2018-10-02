
import std.stdio;
////import ClientHandler;
import Network : Network;

class World {
	Entity[] entities;
	this() {
		entities = [];
	}
}


abstract class Entity {
	this() {
		
	}
}
class Ship : Entity {
}
class Asteroid : Entity {
}



class PlayerShipController {
	
}
class AIShipController {
	
}



void main() {
	World	world	= new World	(	);
	////ClientHandler	clientHandler	= new ClientHandler	(world	);
	
	Network	network	= new Network("127.0.0.1:25777");
	while (true) {
		network.update();
	}
}




