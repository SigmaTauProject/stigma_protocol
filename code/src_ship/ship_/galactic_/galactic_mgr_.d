module ship_.galactic_.galactic_mgr_;

import std.experimental.logger;
import cst_;

import ship_.world_	.world_	:	World	;
import ship_.galactic_	.galactic_network_	:	GalacticNetwork	;

import std.algorithm.iteration;

class GalacticMgr {
	this(World world, GalacticNetwork network) {
		this.world	= world	;
		this.network	= network	;
	}
	void update() {
		import loose_.net_msg_;
		{
			import galactic_msg_.down_;
			foreach (unknownMsg; network.map!(msgData=>UnknownMsg(msgData))) {
				final switch (unknownMsg.type) {
					case MsgType.update:
						auto msg = UpdateMsg(unknownMsg);
						////msg.entities[0].pos.log;
						break;
				}
			}
		}
		////{
		////	import galactic_msg_.to_;
		////	auto msg = ChVelMsg();
		////	msg.vel = [1,1];
		////	msg.anv =  5;
		////	network.send(msg);
		////}
	}
	
	private {
		World	world	;
		int	gameTick	;
		GalacticNetwork	network	;
	}
}

