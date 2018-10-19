module galactic_.ship_.ship_;

import std.experimental.logger;
import cst_;

import loose_.sleep_;
import core.time;

import galactic_.flat_world_	.world_	:	World	;
import galactic_.flat_world_	.entity_	:	Entity	;
import galactic_.network_	.network_	:	Network	;

import std.algorithm.iteration	;
import std.range	:	array	;

class Ship {
	this(World world, Network network) {
		this.world	= world	;
		this.network	= network	;
	}
	void update() {
		{
			import galactic_msg_.up_;
			foreach (unknownMsg; network.map!(msgData=>UnknownMsg(msgData))) {
				final switch (unknownMsg.type) {
					case MsgType.chVel:
						auto msg = ChVelMsg(unknownMsg);
						msg.vel.log(msg.anv);
						break;
				}
			}
		}
		{
			import galactic_msg_.down_;
			import galactic_msg_.entity_ : Entity;
			auto msg = UpdateMsg();
			msg.entities = world.entities.map!((a){auto e = new Entity(); e.pos=a.getPos;e.ori=a.getOri;e.id=getId(a);return e;}).array;
			network.send(msg);
		}
	}
	
	ushort getId(Entity entity) {
		if (auto idPtr = entity in ids) {
			return *idPtr;
		}
		else {
			ids[entity] = nextId;
			return nextId++;
		}
	}
	
	private {
		World	world	;
		Network	network	;
		
		ushort[Entity]	ids	;
		ushort	nextId	= 0;
	}
}

