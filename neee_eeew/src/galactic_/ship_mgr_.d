module galactic_.ship_mgr_;

import std.experimental.logger;

import loose_.sleep_;
import core.time;

import galactic_.world_	:	World	;
import galactic_.network_	:	Network	;
import galactic_.network_msg_	:	NetworkMsg	;

import cst_;

class ShipMgr {
	this(World world, int gameTick) {
		this.world	= world	;
		this.gameTick	= gameTick	;
	}
	void update(Network[] newNetworks) {
		foreach (newNet; newNetworks) {
			{
				import galactic_msg_.from_.basic_config_;
				auto msg = Msg();
				msg.gameTick = this.gameTick;
				newNet.send(msg);
			}
			{
				import galactic_msg_.from_.new_ship_;
				auto msg = Msg();
				msg.pos = world.entities[0].pos;
				msg.ori =  world.entities[0].ori;
				newNet.send(msg);
			}
		}
		this.networks ~= newNetworks;
		foreach (net; networks) {
			foreach (msgData; net) {
				import galactic_msg_.to_;
				auto msg = ToGalacticMsg(msgData);
				msgData.log;
				msg.type.log;
				final switch (msg.type) {
					case ToGalacticMsg.Type.chVel:
						import galactic_msg_.to_.ch_vel_;
						msg.vel.log;
						break;
				}
			}
			{
				import galactic_msg_.from_.move_ship_;
				auto msg = Msg();
				msg.pos = world.entities[0].pos;
				msg.ori =  world.entities[0].ori;
				net.send(msg);
			}
		}
	}
	
	private {
		World	world	;
		int	gameTick	;
		Network[]	networks	;
	}
}

