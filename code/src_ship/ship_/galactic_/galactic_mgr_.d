module ship_.galactic_.galactic_mgr_;

import std.experimental.logger;
import cst_;

import ship_.world_	.world_	:	World	;
import ship_.galactic_	.galactic_network_	:	GalacticNetwork	;

import std.algorithm.iteration;
import std.algorithm.searching;
import std.algorithm.mutation;
import std.range;

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
						import ship_.world_.entity_:Entity;
						foreach (e; msg.entities){
							auto found = this.world.entities.find!(a=>a.id==e.id);
							if (!found.empty) {
								found.front.pos	= e.pos	;
								found.front.ori	= e.ori	;
								found.front.id	= e.id	;
								found.front.updated	= true	;
							}
							else {
								this.world.entities ~= new Entity(e.pos,e.ori,e.id);
								this.world.entities[$-1].updated=true;
							}
						}
						for (long i=this.world.entities.length-1; i>=0; i--) {
							if (!this.world.entities[i].updated) {
								this.world.entities = this.world.entities.remove(i);
							}
						}
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

