module ship_.galactic_mgr_;

import std.experimental.logger;

import ship_.world_	:	World	;
import ship_.galactic_network_	:	GalacticNetwork	;

import cst_;

class GalacticMgr {
	this(World world, GalacticNetwork, network) {
		this.world	= world	;
		this.network	= network	;
	}
	void update() {
		foreach (msgData; galacticNetwork) {
			import galactic_msg_.from_;
			auto msg = FromGalacticMsg(msgData);
			msgData.log;
			msg.type.log;
			final switch (msg.type) {
				case FromGalacticMsg.Type.basicConfig:
					import galactic_msg_.from_.basic_config;
					msg.gameTick.log;
					break;
				case FromGalacticMsg.Type.newShip:
					import galactic_msg_.from_.new_ship_;
					msg.pos.log;
					break;
				case FromGalacticMsg.Type.moveShip:
					import galactic_msg_.from_.move_ship_;
					msg.pos.log;
					break;
			}
		}
		
		{
			import galactic_msg_.to_.ch_vel_;
			auto msg = Msg();
			msg.vel	= [1,1]	;
			msg.anv	= 5	;
			this.galacticNetwork.send(msg);
		}
	}
	
	private {
		World	world	;
		int	gameTick	;
		GalacticNetwork	network	;
	}
}

