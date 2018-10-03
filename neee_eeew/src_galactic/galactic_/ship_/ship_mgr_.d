module galactic_.ship_.ship_mgr_;

import std.experimental.logger;
import cst_;

import loose_.sleep_;
import core.time;

import galactic_.world_	.world_	:	World	;
import galactic_.network_	.network_	:	Network	;

import std.algorithm.iteration	;
import std.range	:	array	;

class ShipMgr {
	this(World world, int gameTick) {
		this.world	= world	;
		this.gameTick	= gameTick	;
	}
	void update(Network[] newNetworks) {
		////foreach (newNet; newNetworks) {
		////	{
		////		import galactic_msg_.from_.basic_config_;
		////		auto msg = Msg();
		////		msg.gameTick = this.gameTick;
		////		newNet.send(msg);
		////	}
		////	{
		////		import galactic_msg_.from_.new_ship_;
		////		auto msg = Msg();
		////		msg.pos = world.entities[0].pos;
		////		msg.ori =  world.entities[0].ori;
		////		newNet.send(msg);
		////	}
		////}
		this.networks ~= newNetworks;
		foreach (net; networks) {
			import loose_.net_msg_;
			{
				import galactic_msg_.up_;
				foreach (unknownMsg; net.map!(msgData=>UnknownMsg(msgData))) {
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
				msg.entities = world.entities.map!((a){auto e = new Entity(); e.pos=a.pos;e.ori=a.ori;return e;}).array;
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

